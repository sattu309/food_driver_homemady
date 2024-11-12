import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady_drivers/widgets/custome_size.dart';
import 'package:homemady_drivers/widgets/custome_textfiled.dart';
import 'package:homemady_drivers/widgets/dimenestion.dart';
import 'package:intl/intl.dart';
import '../controller/driver_information_controller.dart';
import '../repository/driver_update_repo.dart';
import '../widgets/app_theme.dart';
import '../widgets/new_helper.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class DeliveryPartnerUpdateScreen extends StatefulWidget {
  const DeliveryPartnerUpdateScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryPartnerUpdateScreen> createState() =>
      _DeliveryPartnerUpdateScreenState();
}

class _DeliveryPartnerUpdateScreenState
    extends State<DeliveryPartnerUpdateScreen> {
  final controller = Get.put(DriverInformationController());
  final _formKey = GlobalKey<FormState>();
  Rx<File> image1 = File("").obs;
  Rx<File> image2 = File("").obs;
  Rx<File> image = File("").obs;

  String? chooseOptionType;
  String? selectedCategory;
  String? selectedSecondaryCategory;
  String? selectedTertiaryCategory;
  String? selectedCollection;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData();
    });

  }
  void main() {
    String input = "Ab1234567"; // Example input

    bool isValid = validateInput(input);

    if (isValid) {
      // print("Input is valid.");
    } else {
      // print("Input is invalid. Please make sure it has 7 digits and 1 or 2 capital letters.");
    }
  }
  bool validateInput(String input) {
    // Define the regular expression pattern
    RegExp regex = RegExp(r'^(?=.*[A-Z].*[A-Z]?)(?=.*\d{7})[A-Z\d]{7}$');

    // Use hasMatch method to check if the input matches the pattern
    return regex.hasMatch(input);
  }
  var items = [
    'Car',
    'Motorcycle',
    'Bicycle',
  ];
  RxBool showValidation = false.obs;

  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }
  var selectedDate = DateTime.now().obs;
  DateTime today = DateTime.now();
  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(
            DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year - 18, DateTime.now().month,
            DateTime.now().day));
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      controller.dobController.text =
          DateFormat('dd-MM-yyyy').format(selectedDate.value).toString();
    }
  }


  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";


  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: backAppBar(title: 'Update Driver Setting', context: context),
        body: Obx(() {

          return controller.isDataLoading.value &&
              controller.model.value.data != null
              ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5F5F5F).withOpacity(0.4),
                      offset: const Offset(0.0, 0.5),
                      blurRadius: 5,),
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: controller.dobController,
                        onTap: () {
                          selectDate();
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Date of birth (dd/MM/YYYY)',
                          focusColor: Colors.green,
                          hintStyle: GoogleFonts.poppins(
                            color: const Color(0xFF697164),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9F9F9),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7),
                          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFE2E2E2), width: 1),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFE2E2E2), width: 1),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(6.0))),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFFE2E2E2), width: 1),
                              borderRadius: BorderRadius.circular(6.0)),
                        ),
                      ),
                      addHeight(13),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onTap: () {},
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(9),
                        ],
                        /* inputFormatters: [
                         // TextCapitalizationFormatter(TextCapitalization.sentences),
                        ],*/
                        //  textCapitalization: TextCapitalization.characters,
                        onChanged: (value) {
                          controller.ppsController.value =
                              TextEditingValue(
                                  text: value.toUpperCase(),
                                  selection: controller.ppsController.selection);
                        },
                        validator: (value){
                          if (value!.length == 8 || value.length == 9) {
                            int letterCount = value.replaceAll(RegExp(r'[0-9]'), '').length;

                            if (letterCount >= 1 && letterCount <= 2) {
                              return null; // Valid input
                            }
                          }

                          return 'Input must have 7 digits and 1 or 2 capital letters.';
                        },
                        // maxLength: 9,
                        keyboardType: TextInputType.text,
                        controller: controller.ppsController,
                        decoration: InputDecoration(
                          hintText: 'PPS number',
                          focusColor: Colors.green,
                          hintStyle: GoogleFonts.poppins(
                            color: const Color(0xFF697164),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,

                          fillColor: const Color(0xFFF9F9F9),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                          // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFE2E2E2),width: 1),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:  BorderSide(color: Color(0xFFE2E2E2),width: 1),
                              borderRadius:  BorderRadius.all(Radius.circular(6.0))),
                          border: OutlineInputBorder(
                              borderSide:  const BorderSide(color: Color(0xFFE2E2E2),width: 1),
                              borderRadius: BorderRadius.circular(6.0)),
                          // suffixIcon: suffix,
                          // prefixIcon: prefix
                        ),
                        //: 'PPS number',
                        //maxLength: 9,
                      ),
                      addHeight(13),
                      RegistrationTextFieldChk(
                        controller: controller.typeController,
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please select your vehicle type'),

                              ]).call,
                              isExpanded: true,
                              style: const TextStyle(
                                color: Color(0xFF697164),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              value: controller.dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down,
                                color: Color(0xFF000000),),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  controller.dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      addHeight(13),
                      InkWell(
                          onTap: () async {
                            var place = await PlacesAutocomplete.show(
                                hint: "Location",
                                context: context,
                                apiKey: googleApikey,
                                mode: Mode.overlay,
                                types: [],
                                strictbounds: false,
                                onError: (err) {
                                  log("error.....   ${err.errorMessage}");
                                });
                            if (place != null) {
                              setState(() {
                                controller.address =
                                    (place.description ?? "Location")
                                        .toString();
                              });
                              final plist = GoogleMapsPlaces(
                                apiKey: googleApikey,
                                apiHeaders: await const GoogleApiHeaders()
                                    .getHeaders(),
                              );
                              // print(plist);
                              String placeid = place.placeId ?? "0";
                              final detail =
                              await plist.getDetailsByPlaceId(placeid);
                              final geometry = detail.result.geometry!;
                              final lat = geometry.location.lat;
                              final lang = geometry.location.lng;
                              setState(() {
                                controller.address =
                                    (place.description ?? "Location")
                                        .toString();
                                // print("Address iss...${controller.address}");
                              });
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: !checkValidation(
                                              showValidation.value,
                                              controller.address == "")
                                              ? Colors.grey.shade300
                                              : Colors.red),
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      color: Colors.grey.shade50),
                                  // width: MediaQuery.of(context).size.width - 40,
                                  child: ListTile(
                                    leading: const Icon(Icons.location_on,
                                      color: Color(0xFF6CD241),),
                                    title: Text(
                                      controller.address ?? "Location".toString(),
                                      style: TextStyle(
                                          fontSize: AddSize.font14),
                                    ),
                                    trailing: const Icon(Icons.search),
                                    dense: true,
                                  )),
                              checkValidation(
                                  showValidation.value, controller.address == "")
                                  ? Padding(
                                padding: EdgeInsets.only(
                                    top: AddSize.size5),
                                child: Text(
                                  "      Location is required",
                                  style: TextStyle(
                                      color: Colors.red.shade700,
                                      fontSize: AddSize.font12),

                                ),
                              )
                                  : const SizedBox()
                            ],
                          )
                      ),
                      addHeight(18),
                      const Text('Vehicle Details', style: TextStyle(
                        color: Color(0xFF2F2F2F),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),),
                      addHeight(8),
                      Row(
                        children: [
                          Expanded(
                            child: RegistrationTextFieldChk(
                              hint: 'Year',
                              onTap: () {},
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter your vehicle model year'),
                              ]),
                              controller: controller.veyearController,
                              keyboardType: TextInputType.number,
                              length: 4,
                            ),
                          ),
                          addWidth(17),
                          Expanded(
                            child: RegistrationTextFieldChk(
                              hint: 'Make',
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter your vehicle make year'),
                              ]),
                              onTap: () {},
                              controller: controller.makeController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      addHeight(15),
                      Row(
                        children: [
                          Expanded(
                            child: RegistrationTextFieldChk(
                              hint: 'Model',
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter your vehicle model'),
                              ]),
                              onTap: () {},
                              controller: controller.modelNameController,
                            ),
                          ),
                          addWidth(17),
                          Expanded(
                            child: RegistrationTextFieldChk(
                              hint: 'Color',
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter your vehicle color'),
                              ]),
                              onTap: () {},
                              controller: controller.colorController,
                            ),
                          ),
                        ],
                      ),
                      addHeight(15),
                      const Text('PPS card', style: TextStyle(
                        color: Color(0xFF2F2F2F),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),),
                      addHeight(15),
                      Obx(() {
                        return
                          GestureDetector(
                            onTap: () {
                              NewHelper()
                                  .addFilePicker()
                                  .then((value) {
                                image1.value = value;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding16,
                                  vertical: AddSize.padding16),
                              width: AddSize.screenWidth,
                              height: height* .15,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: !checkValidation(
                                        showValidation.value,
                                        image1.value.path == "")
                                        ? Colors.grey.shade300
                                        : Colors.red,
                                  )),
                              child: image1.value.path == ""
                                  ?
                              Stack(
                                children: [
                                SizedBox(
                                height: AddSize.size125,
                                width: AddSize.screenWidth,
                                child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(16),
                                    child:
                                    image1.value.path == "" ?
                                    CachedNetworkImage(
                                        imageUrl:
                                        controller
                                            .model
                                            .value
                                            .data!
                                            .ppsCardImage
                                            .toString(),
                                      errorWidget: (_, __, ___) =>
                                      const SizedBox(),
                                      placeholder: (_, __) =>
                                      const SizedBox(),
                                fit: BoxFit.cover,
                              ):const SizedBox(),
                            ),
                          ),
                                            Positioned(
                                              right: AddSize.padding10,
                                              top: AddSize.padding10,
                                              child: GestureDetector(
                                                onTap: () {
                                                  NewHelper()
                                                      .addFilePicker()
                                                      .then((value) {
                                                    image1.value = value;
                                                  });
                                                },
                                                child: Container(
                                                  height: AddSize.size30,
                                                  width: AddSize.size30,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: AppTheme
                                                              .backgroundcolor),
                                                      color:
                                                          AppTheme.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.edit,
                                                    color:
                                                        AppTheme.backgroundcolor,
                                                    size: 20,
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Stack(
                                          children: [
                                            SizedBox(
                                                width: double.maxFinite,
                                                height: AddSize.size100,
                                                child: Image.file(image1.value)),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  NewHelper()
                                                      .addFilePicker()
                                                      .then((value) {
                                                    image1.value = value;
                                                  });
                                                },
                                                child: Container(
                                                  height: AddSize.size30,
                                                  width: AddSize.size30,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.black12),
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.edit,
                                                    color: Colors.black45,
                                                    size: 20,
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              );
                            }),
                            addHeight(15),
                      const Text('Upload Driver Licence', style: TextStyle(
                        color: Color(0xFF2F2F2F),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),),
                      addHeight(15),
                      Obx(() {
                        return Row(
                          children: [
                            Expanded(
                              child:  GestureDetector(
                                onTap: () {
                                  NewHelper()
                                      .addFilePicker()
                                      .then((value) {
                                    image2.value = value;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding16,
                                      vertical: AddSize.padding16),
                                  width: AddSize.screenWidth,
                                  height: height* .15,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: !checkValidation(
                                            showValidation.value,
                                            image2.value.path == "")
                                            ? Colors.grey.shade300
                                            : Colors.red,
                                      )),
                                  child: image2.value.path == ""
                                      ?
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: AddSize.size125,
                                        width: AddSize.screenWidth,
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(16),
                                          child:
                                          image2.value.path == "" ?
                                          CachedNetworkImage(
                                            imageUrl:
                                            controller
                                                .model
                                                .value
                                                .data!
                                                .ppsCardImage
                                                .toString(),
                                            errorWidget: (_, __, ___) =>
                                            const SizedBox(),
                                            placeholder: (_, __) =>
                                            const SizedBox(),
                                            fit: BoxFit.cover,
                                          ):const SizedBox(),
                                        ),
                                      ),
                                      Positioned(
                                        right: AddSize.padding10,
                                        top: AddSize.padding10,
                                        child: GestureDetector(
                                          onTap: () {
                                            NewHelper()
                                                .addFilePicker()
                                                .then((value) {
                                              image2.value = value;
                                            });
                                          },
                                          child: Container(
                                            height: AddSize.size30,
                                            width: AddSize.size30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppTheme
                                                        .backgroundcolor),
                                                color:
                                                AppTheme.primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    50)),
                                            child: const Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppTheme
                                                      .backgroundcolor,
                                                  size: 20,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      :
                                  Stack(
                                    children: [
                                      SizedBox(
                                          width: double.maxFinite,
                                          height: AddSize.size100,
                                          child: Image.file(image2.value)),

                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            NewHelper()
                                                .addFilePicker()
                                                .then((value) {
                                              image2.value = value;
                                            });
                                          },
                                          child: Container(
                                            height: AddSize.size30,
                                            width: AddSize.size30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black12),
                                                color:
                                                Colors.green,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    50)),
                                            child: const Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.black45,
                                                  size: 20,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            addWidth(17),
                            Expanded(
                              child:   GestureDetector(
                                onTap: () {
                                  NewHelper()
                                      .addFilePicker()
                                      .then((value) {
                                    image.value = value;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding16,
                                      vertical: AddSize.padding16),
                                  width: AddSize.screenWidth,
                                  height: height* .15,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: !checkValidation(
                                            showValidation.value,
                                            image.value.path == "")
                                            ? Colors.grey.shade300
                                            : Colors.red,
                                      )),
                                  child: image.value.path == ""
                                      ?
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: AddSize.size125,
                                        width: AddSize.screenWidth,
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(16),
                                          child:
                                          image.value.path == "" ?
                                          CachedNetworkImage(
                                            imageUrl:
                                            controller
                                                .model
                                                .value
                                                .data!
                                                .ppsCardImage
                                                .toString(),
                                            errorWidget: (_, __, ___) =>
                                            const SizedBox(),
                                            placeholder: (_, __) =>
                                            const SizedBox(),
                                            fit: BoxFit.cover,
                                          ):const SizedBox(),
                                        ),
                                      ),
                                      Positioned(
                                        right: AddSize.padding10,
                                        top: AddSize.padding10,
                                        child: GestureDetector(
                                          onTap: () {
                                            NewHelper()
                                                .addFilePicker()
                                                .then((value) {
                                              image.value = value;
                                            });
                                          },
                                          child: Container(
                                            height: AddSize.size30,
                                            width: AddSize.size30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppTheme
                                                        .backgroundcolor),
                                                color:
                                                AppTheme.primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    50)),
                                            child: const Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppTheme
                                                      .backgroundcolor,
                                                  size: 20,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      :
                                  Stack(
                                    children: [
                                      SizedBox(
                                          width: double.maxFinite,
                                          height: AddSize.size100,
                                          child: Image.file(image.value)),

                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            NewHelper()
                                                .addFilePicker()
                                                .then((value) {
                                              image.value = value;
                                            });
                                          },
                                          child: Container(
                                            height: AddSize.size30,
                                            width: AddSize.size30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black12),
                                                color:
                                                Colors.green,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    50)),
                                            child: const Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.black45,
                                                  size: 20,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      addHeight(30),
                      CommonButton(title: 'Update',
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              controller.address.isNotEmpty) {
                            Map <String, String> mapdata = {
                              'dob': controller.dobController.text.trim(),
                              'pps_no': controller.ppsController.text.trim(),
                              'vehicle_type': controller.dropdownvalue.toString(),
                              'vehicle_name': controller.veyearController.text
                                  .trim(),
                              'vehicle_model': controller.modelNameController.text
                                  .trim(),
                              'vehicle_make': controller.makeController.text
                                  .trim(),
                              'vehicle_color': controller.colorController.text
                                  .trim(),
                              'address': controller.address.toString(),
                            };
                            // print(mapdata);
                            DriverUpdate(
                              fieldName1: 'pps_card_image',
                              fieldName2: "licence_front_image",
                              fieldName3: "licence_back_image",
                              file1: image.value,
                              file2: image1.value,
                              file3: image2.value,
                              mapData: mapdata,
                              context: context,
                            ).then((value) {
                              if (value.status == true) {
                                NewHelper.showToast(value.message.toString());
                                // Get.offAllNamed(MyRouters.thankYouVendorScreen);
                              }
                              NewHelper.showToast(value.message.toString());
                            });
                          }
                          // emailLogin();
                          //
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ) : const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ));
        }),
      ),
    );
  }
}
