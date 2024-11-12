import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/assigned_Orderlist_controller.dart';
import '../controller/deshborad_controoler.dart';
import '../controller/order_details_controller.dart';
import '../controller/userProfile_controller.dart';
import '../repository/delivery_mode_update_repo.dart';
import '../repository/update_order_status_repo.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_size.dart';
import '../widgets/dimenestion.dart';
import '../widgets/new_helper.dart';
import 'order_details.dart';

class AssignedOrderScreen extends StatefulWidget {
  const AssignedOrderScreen({Key? key}) : super(key: key);

  @override
  State<AssignedOrderScreen> createState() => _AssignedOrderScreenState();
}

class _AssignedOrderScreenState extends State<AssignedOrderScreen> {
  bool state = true;
  final RxBool _store = false.obs;
  final controller = Get.put(DeshBoradController());
  String dropdownvalue = 'All Orders';
  final assignedController = Get.put(AssignedOrderController());
  final controller1 = Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    assignedController.getOrderData1();
  }

  String? selectedTime;
  final List<String> dropDownTimeList = ["Pending", "Completed", "Decline"];
  var items = [
    'All Orders',
    'Accepted',
    'Declined',
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          titleSpacing: 30,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                )),
          ),
          actions: [
            Obx(() {
              return Row(
                children: [
                  const Text(
                    ' Delivery Mode  ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10, color: Color(0xFF303C5E)),
                  ),
                  FlutterSwitch(
                    height: AddSize.size20,
                    width: AddSize.size40,
                    activeColor: AppTheme.primaryColor,
                    toggleSize: AddSize.size5 * 2.5,
                    value:
                    controller.isDataLoading.value ? (controller.model.value.data!.deliveryMode ?? false) : _store.value,
                    onToggle: (val) {
                      deliveryModeUpdateRepo().then((value) {
                        if (value.status == true) {
                          controller.getData();
                          controller.model.value.data!.deliveryMode = val;
                          if (controller.model.value.data!.deliveryMode == true) {
                            NewHelper.showToast("Delivery mode on");
                          } else {
                            NewHelper.showToast("Delivery mode off");
                          }
                        }
                      });
                    },
                  ),
                  SizedBox(
                    width: width * .020,
                  )
                ],
              );
            })
          ],
          leadingWidth: AddSize.size40 * 0.9,
          title: const Text(
            'Assigned Order',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Color(0xFF1A2E33)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Assigned Delivery',
                    style: GoogleFonts.raleway(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF303C5E)),
                  ),
                  Container(
                    height: 31,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFEEEEEE))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isDense: true,
                        isExpanded: false,
                        style: const TextStyle(
                          color: Color(0xFF697164),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        value: dropdownvalue,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF000000),
                        ),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                          if (dropdownvalue != "All Orders") {
                            assignedController.status.value = dropdownvalue;
                            assignedController.getOrderData1();
                          } else {
                            assignedController.status.value = "";
                            assignedController.getOrderData1();
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              addHeight(12.0),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: ()async{
                    await assignedController.getOrderData1();
                  },
                  child: Obx(() {
                    return assignedController.isDataLoading.value
                        ? assignedController.model.value.data!.isNotEmpty
                        ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: assignedController.model.value.data!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(()=> DriverDeliveryOrderDetails(orderId: assignedController.model.value.data![index].orderId.toString(),));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF5F5F5F).withOpacity(0.10),
                                            offset: const Offset(0.0, 0.5),
                                            blurRadius: 5,
                                          ),
                                        ]),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/calender_Img.png',
                                                    height: 18,
                                                  ),
                                                  addWidth(20),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Date:',
                                                          style: GoogleFonts.raleway(
                                                              fontWeight: FontWeight.w800,
                                                              fontSize: 14,
                                                              color: const Color(0xFF303C5E)),
                                                        ),
                                                        addHeight(4),
                                                        Text(
                                                          assignedController.model.value.data![index].date.toString(),
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 15,
                                                              color: Color(0xFF303C5E)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              addHeight(15),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/orderid.png',
                                                    height: 18,
                                                  ),
                                                  addWidth(20),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Order ID:',
                                                        style: GoogleFonts.raleway(
                                                            fontWeight: FontWeight.w800,
                                                            fontSize: 14,
                                                            color: const Color(0xFF303C5E)),
                                                      ),
                                                      addHeight(4),
                                                      Text(
                                                        '# ${assignedController.model.value.data![index].orderId.toString()}',
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 15,
                                                            color: Color(0xFF303C5E)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              addHeight(15),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/locationiconn.png',
                                                    height: 18,
                                                  ),
                                                  addWidth(20),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Location:',
                                                          style: GoogleFonts.raleway(
                                                              fontWeight: FontWeight.w800,
                                                              fontSize: 14,
                                                              color: const Color(0xFF303C5E)),
                                                        ),
                                                        addHeight(4),
                                                        if (assignedController.model.value.data![index].location != null)
                                                          Text(
                                                            assignedController
                                                                .model.value.data![index].location!.location
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 15,
                                                                color: Color(0xFF303C5E)),
                                                          ),
                                                        addHeight(15),
                                                        assignedController.model.value.data![index].pick_up_time!=null?
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Pick up time:',
                                                              style: GoogleFonts.raleway(
                                                                  fontWeight: FontWeight.w800,
                                                                  fontSize: 14,
                                                                  color: const Color(0xFF303C5E)),
                                                            ),
                                                              addWidth(4),

                                                              Text(assignedController.model.value.data![index].pick_up_time.toString(),  style: const TextStyle(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 15,
                                                                  color: Color(0xFF303C5E)),),
                                                          ],
                                                        ):SizedBox(),
                                                        addHeight(4),


                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              addHeight(10),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: MediaQuery.of(context).size.width / 12),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Obx(() {
                                                      return assignedController
                                                          .model.value.data![index].accpetanceStatus ==
                                                          "Accepted"
                                                          ? assignedController.model.value.data![index].orderStatus ==
                                                          "Picked Up"
                                                          ? ElevatedButton(
                                                          onPressed: () {
                                                            if (kDebugMode) {
                                                              print(
                                                                  "Assignes order id ${assignedController.model.value.data![index].orderId}");
                                                            }
                                                            driverUpdateOrder(
                                                                orderId: assignedController
                                                                    .model.value.data![index].orderId
                                                                    .toString(),
                                                                status: 'delivered',
                                                                context: context)
                                                                .then((value) {
                                                              NewHelper.showToast(value.message.toString());
                                                              if (value.status == true) {
                                                                assignedController.getOrderData1();
                                                              }
                                                            });
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: AddSize.padding22), backgroundColor: AppTheme.primaryColor,
                                                            minimumSize:
                                                            Size(AddSize.size100, AddSize.size20 * 1.8),
                                                            elevation: 0,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(6)),
                                                          ),
                                                          child: Text(
                                                            "Deliver".toUpperCase(),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .headlineSmall!
                                                                .copyWith(
                                                                color: AppTheme.backgroundcolor,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: AddSize.font14),
                                                          ))
                                                          : assignedController
                                                          .model.value.data![index].orderStatus ==
                                                          "Completed"
                                                          ? ElevatedButton(
                                                          onPressed: () {},
                                                          style: ElevatedButton.styleFrom(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: AddSize.padding22), backgroundColor: AppTheme.primaryColor,
                                                            minimumSize:
                                                            Size(AddSize.size100, AddSize.size20 * 1.8),
                                                            elevation: 0,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(6)),
                                                          ),
                                                          child: Text(
                                                            "Delivered".toUpperCase(),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .headlineSmall!
                                                                .copyWith(
                                                                color: AppTheme.backgroundcolor,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: AddSize.font14),
                                                          ))
                                                          : ElevatedButton(
                                                          onPressed: () {
                                                            driverUpdateOrder(
                                                                orderId: assignedController
                                                                    .model.value.data![index].orderId,
                                                                status: "pickup",
                                                                context: context)
                                                                .then((value) {
                                                              NewHelper.showToast(
                                                                  "${value.message}".toString());
                                                              if (value.status == true) {
                                                                assignedController.getOrderData1();
                                                              }
                                                            });
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: AddSize.padding22), backgroundColor: AppTheme.primaryColor,
                                                            minimumSize:
                                                            Size(AddSize.size100, AddSize.size20 * 1.8),
                                                            elevation: 0,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(6)),
                                                          ),
                                                          child: Text(
                                                            "Pickup".toUpperCase(),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .headlineSmall!
                                                                .copyWith(
                                                                color: AppTheme.backgroundcolor,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: AddSize.font14),
                                                          ))
                                                          : assignedController
                                                          .model.value.data![index].accpetanceStatus ==
                                                          "Declined"
                                                          ? ElevatedButton(
                                                          onPressed: () {},
                                                          style: ElevatedButton.styleFrom(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: AddSize.padding22), backgroundColor: AppTheme.primaryColor,
                                                            minimumSize:
                                                            Size(AddSize.size100, AddSize.size20 * 1.8),
                                                            elevation: 0,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(6)),
                                                          ),
                                                          child: Text(
                                                            "Declined".toUpperCase(),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .headlineSmall!
                                                                .copyWith(
                                                                color: AppTheme.backgroundcolor,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: AddSize.font14),
                                                          ))
                                                          : ElevatedButton(
                                                          onPressed: () {},
                                                          style: ElevatedButton.styleFrom(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: AddSize.padding22), backgroundColor: AppTheme.primaryColor,
                                                            minimumSize:
                                                            Size(AddSize.size100, AddSize.size20 * 1.8),
                                                            elevation: 0,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(6)),
                                                          ),
                                                          child: Text(
                                                            "Delivered".toUpperCase(),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .headlineSmall!
                                                                .copyWith(
                                                                color: AppTheme.backgroundcolor,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: AddSize.font14),
                                                          ));
                                                    }),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          // orderController.id.value =
                                                          //     assignedController.model.value.data![index].orderId.toString();
                                                          Get.to(()=> DriverDeliveryOrderDetails(orderId: assignedController.model.value.data![index].orderId.toString(),routing: true,));
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: AddSize.padding22), backgroundColor: AppTheme.primaryColor,
                                                          minimumSize:
                                                          Size(AddSize.size100, AddSize.size20 * 1.8),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(6)),
                                                        ),
                                                        child: Text(
                                                          "chat".toUpperCase(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall!
                                                              .copyWith(
                                                              color: AppTheme.backgroundcolor,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: AddSize.font14),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            right: 5,
                                            top: 8,
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xFF7ED957),
                                                      borderRadius: BorderRadius.circular(6)),
                                                  child: Text(
                                                    assignedController.model.value.data![index].paymentMethod.toString(),
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w600, fontSize: 10, color: Colors.white),
                                                  ),
                                                ),
                                                addWidth(8.0),
                                                Text(
                                                  '€ ${assignedController.model.value.data![index].orderTotal.toString()}',
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 14,
                                                      color: Color(0xFF7ED957)),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                  addHeight(20),
                                ],
                              ),
                            );
                          },
                        )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addHeight(
                          MediaQuery.of(context).size.height * .12,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .30,
                            child: Image.asset('assets/images/Cart illustartion.png')),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .030,
                        ),
                        Text("No Orders",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                height: 1.5,
                                fontWeight: FontWeight.w700,
                                fontSize: AddSize.font20,
                                color: AppTheme.blackcolor)),
                        addHeight(
                          MediaQuery.of(context).size.height * .010,
                        ),
                        Text("Bong, it appears that you don't have any orders yet",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                                fontSize: AddSize.font16,
                                color: const Color(0xFF9E9E9E))),
                      ],
                    )
                        : const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 200),
                          child: CircularProgressIndicator(
                            color: Color(0xff7ED957),
                          ),
                        ));
                  }),
                ),
              ),
            ],
          ),
        ).manageNotification(context: context),
      ),
    );
  }
}
