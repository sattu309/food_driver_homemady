import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemady_drivers/controller/assigned_Orderlist_controller.dart';
import '../controller/withdrawel_controller.dart';
import '../repository/withdraw_request_repo.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';
import '../widgets/new_helper.dart';

class WithdrawMoney extends StatefulWidget {
  const WithdrawMoney({Key? key}) : super(key: key);

  @override
  State<WithdrawMoney> createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {

  final withdrawalListController = Get.put(WithdrawalListController());
  final TextEditingController addMoneyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> moneyList = ["50", "250", "500"];

  final walletStatus = "";

  @override
  void initState() {
    super.initState();
    withdrawalListController.getWithdrawalList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: backAppBar(title: "Withdrawal money".tr, context: context),
        body: Obx((){
          return
            withdrawalListController.isDataLoading.value ?
            SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AddSize.padding16,
                      vertical: AddSize.padding10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF37C666).withOpacity(0.10),
                                offset: const Offset(.1, .1,
                                ),
                                blurRadius: 20.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: AppTheme.backgroundcolor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16,
                                    vertical: AddSize.padding16),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "My Balance".tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: AppTheme.blackcolor),
                                        ),
                                        Text(
                                          "€${withdrawalListController.model.value.data!.earnedBalance.toString()}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 31,
                                              color:Color(0xFF262F33)),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF7ED957),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.account_balance_wallet_sharp,color: Colors.white,),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF37C666).withOpacity(0.10),
                                offset: const Offset(.1, .1,
                                ),
                                blurRadius: 20.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: AppTheme.backgroundcolor,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding16,
                                      vertical: AddSize.padding16),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                              color: AppTheme.blackcolor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: AddSize.font24),
                                          controller: addMoneyController,
                                          cursorColor: const Color(0xFF7ED957),
                                          // validator: validateMoney,
                                          decoration: const InputDecoration(
                                            hintText: '€0',
                                          )),
                                      SizedBox(
                                        height: AddSize.size15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: List.generate(
                                          moneyList.length,
                                              (index) => chipList(moneyList[index]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: AddSize.size25,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // print(addMoneyController.text);
                                              withdrawalRequestRepo(
                                                  addMoneyController.text,
                                                  context)
                                                  .then((value) {
                                                NewHelper.showToast(value.message);
                                                if(value.status == true){
                                                  withdrawalListController.getWithdrawalList();
                                                  addMoneyController.clear();
                                                  FocusManager.instance.primaryFocus!.unfocus();
                                                }
                                              });
                                              // Get.toNamed(BankDetailsScreen
                                              //     .bankDetailsScreen);
                                            }

                                          },
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(double.maxFinite,
                                                  AddSize.size50), backgroundColor: const Color(0xFF7ED957),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10)),
                                              textStyle: TextStyle(
                                                  fontSize: AddSize.font20,
                                                  fontWeight: FontWeight.w500)),
                                          child: Text(
                                            "Withdrawal".tr.toUpperCase(),
                                            style: const TextStyle(
                                                color:
                                                AppTheme.backgroundcolor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
                                          )),
                                    ],
                                  ))),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF37C666).withOpacity(0.10),
                                  offset: const Offset(.1, .1,
                                  ),
                                  blurRadius: 20.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                              // color: AppTheme.backgroundcolor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AddSize.padding16,
                                vertical: AddSize.padding10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Amount".tr,
                                      style: const TextStyle(
                                          height: 1.5,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: AppTheme.primaryColor),
                                    ),
                                    Text(
                                      "Date".tr,
                                      style: const TextStyle(
                                          height: 1.5,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: AppTheme.primaryColor),
                                    ),
                                    Text(
                                      "Status".tr,
                                      style: const TextStyle(
                                          height: 1.5,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: AppTheme.primaryColor),
                                    )
                                  ],
                                ),
                                const Divider(),
                                ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: withdrawalListController
                                      .model.value.data!.withdrawalList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: AddSize.size5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "€${withdrawalListController.model.value.data!.withdrawalList![index].amount.toString()}",
                                              style: const TextStyle(
                                                  height: 1.5,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize:12),
                                            ),
                                            Text(
                                              withdrawalListController
                                                  .model
                                                  .value
                                                  .data!
                                                  .withdrawalList![index]
                                                  .date
                                                  .toString(),
                                              style: const TextStyle(
                                                  height: 1.5,
                                                  color: Color(0xFF8C9BB2),
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 11),
                                            ),
                                            withdrawalListController
                                                .model
                                                .value
                                                .data!
                                                .withdrawalList![index]
                                                .status ==
                                                "P"
                                                ? Text(
                                              withdrawalListController
                                                  .model
                                                  .value
                                                  .data!
                                                  .withdrawalList![index]
                                                  .status!
                                                  .replaceAll(
                                                  "P", "Pending")
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                  height: 1.5,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize:
                                                  AddSize.font14,
                                                  color:
                                                  Colors.green),
                                            )
                                                : withdrawalListController
                                                .model
                                                .value
                                                .data!
                                                .withdrawalList![
                                            index]
                                                .status ==
                                                "A"
                                                ? Text(
                                              withdrawalListController
                                                  .model
                                                  .value
                                                  .data!
                                                  .withdrawalList![
                                              index]
                                                  .status!
                                                  .replaceAll(
                                                  "A", "Approve")
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                  height: 1.5,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  fontSize:
                                                  AddSize
                                                      .font14,
                                                  color: Colors
                                                      .green),
                                            )
                                                : Text(
                                              withdrawalListController
                                                  .model
                                                  .value
                                                  .data!
                                                  .withdrawalList![
                                              index]
                                                  .status!
                                                  .replaceAll(
                                                  "R", "Reject")
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                  height: 1.5,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  fontSize:
                                                  AddSize
                                                      .font14,
                                                  color: Colors
                                                      .green),
                                            ),

                                          ],
                                        ),
                                        index != 4
                                            ? const Divider()
                                            : const SizedBox(),
                                        SizedBox(
                                          height: AddSize.size5,
                                        ),

                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )):
            const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor,)) ;
        }),
      ).manageNotification(context: context),
    );
  }

  chipList(title) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChoiceChip(
      padding: EdgeInsets.symmetric(
          horizontal: width * .005, vertical: height * .005),
      backgroundColor: AppTheme.backgroundcolor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.grey.shade300)),
      label: Text("+€$title",
          style: const TextStyle(
              color: Color(0xFF262F33),
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      selected: false,
      onSelected: (value) {
        setState(() {
          addMoneyController.text = title;
          FocusManager.instance.primaryFocus!.unfocus();
        });
      },
    );
  }
}