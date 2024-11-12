import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemady_drivers/widgets/custome_size.dart';

import '../controller/add_bankDetails_controller.dart';
import '../controller/bank_list_controller.dart';
import '../models/bank_list_model.dart';
import '../repository/add_bank_details_repo.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/new_helper.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);
  static var bankDetailsScreen = "/bankDetailsScreen";

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {

  final vendorBankListController = Get.put(VendorBankListController());
  final vendorBankDetailsController = Get.put(VendorBankDetailsController());
  RxString selectedCAt = "".obs;
  final _formKey = GlobalKey<FormState>();
  String dropdownvalue = 'HDFC Bank';
  @override
  void initState() {
    super.initState();
    vendorBankListController.getVendorBankListDetails().then((value) {
      vendorBankDetailsController.getVendorBankDetails().then((value) {
        if (vendorBankListController.bankListModel.value.data!.banks != null &&
            vendorBankDetailsController.bankDetailsModel.value.data != null) {
          selectedCAt.value = (vendorBankListController
              .bankListModel.value.data!.banks!
              .firstWhere(
                  (element) =>
              element.name.toString() ==
                  (vendorBankDetailsController
                      .bankDetailsModel.value.data!.bank ??
                      ""),
              orElse: () => Banks())
              .id ??
              "")
              .toString();
        }
        setState(() {});
        // print(vendorBankDetailsController.bankDetailsModel.value.data?.bank);
      });
    });
  }
  // List of items in our dropdown menu
  var items = [
    'HDFC Bank',
    'SBI Bank',
    'ICICI Bank',
    'PNB Bank',
    'IDFC Bank',
  ];
  final List<String> dropDownList = ["HDFC Bank", "SBI Bank", "PNB Bank"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: backAppBar(title: 'Bank Details', context: context),
        body:  Obx((){
        if (vendorBankDetailsController.isDataLoading.value &&
            vendorBankDetailsController.bankDetailsModel.value.data != null) {
          vendorBankDetailsController.bankController.text =
              (vendorBankDetailsController
                  .bankDetailsModel.value.data!.bank ??
                  "")
                  .toString();
          vendorBankDetailsController.bankAccountNumber.text =
              (vendorBankDetailsController
                  .bankDetailsModel.value.data!.accountNo ??
                  "")
                  .toString();

          vendorBankDetailsController.accountHolderName.text =
              (vendorBankDetailsController
                  .bankDetailsModel.value.data!.accountName ??
                  "")
                  .toString();

          vendorBankDetailsController.iFSCCode.text =
              (vendorBankDetailsController
                  .bankDetailsModel.value.data!.ifscCode ??
                  "")
                  .toString();
          // selectedCAt.value = vendorBankListController
          //     .value.data!.bank
          //     .toString();
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              addHeight(50),
              Image.asset('assets/images/bank.png',height: 151,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 13),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5F5F5F).withOpacity(0.2),
                          offset: const Offset(0.0, 0.5),
                          blurRadius: 5,),]
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xFFE2E2E2),width: 1),
                            borderRadius: BorderRadius.circular(6),color: const Color(0xFFF9F9F9),
                          ),
                          child:
                          /*DropdownButtonFormField(
                            decoration: InputDecoration(
                              fillColor: const Color(0xFFF4F4F4),
                              contentPadding:
                              const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300),
                                borderRadius:
                                BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 3.0),
                                  borderRadius:
                                  BorderRadius.circular(15.0)),
                              enabled: true,
                            ),
                            isExpanded: true,
                            hint: Text(
                              'Select account',
                              style: TextStyle(
                                  color: AppTheme.userText,
                                  fontSize: AddSize.font14),
                            ),
                            value: selectedCAt.value == ""
                                ? null
                                : selectedCAt.value,
                            items: vendorBankListController
                                .bankListModel.value.data?.banks!
                                .toList()
                                .map((value) {
                              return DropdownMenuItem(
                                value: value.id.toString(),
                                child: Text(
                                  value.name.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedCAt.value = newValue.toString();
                              });
                              // print(selectedCAt.value);
                            },
                          ),*/
                          RegistrationTextFieldChk1(
                            controller: vendorBankDetailsController.bankController,
                            hint: 'Your Bank',
                            onTap: (){},
                          ),
                        ),
                        addHeight(15),
                        RegistrationTextFieldChk1(
                          controller: vendorBankDetailsController.bankAccountNumber,
                          hint: 'Bank Account Number',
                          length: 34,
                          onTap: (){},
                          // keyboardType: TextInputType.number,
                        ),
                        addHeight(15),
                        RegistrationTextFieldChk1(
                          controller:vendorBankDetailsController.accountHolderName,
                          hint: 'Account Holder Name',
                          onTap: (){},
                        ),
                        addHeight(15),
                        RegistrationTextFieldChk1(
                          controller: vendorBankDetailsController.iFSCCode,
                          hint: 'BIC/SWIFT code',
                          onTap: (){},
                        ),
                        addHeight(15),
                        CommonButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              vendorAddBankDetailsRepo(
                                  vendorBankDetailsController.bankController.text,
                                  vendorBankDetailsController
                                      .accountHolderName.text,
                                  vendorBankDetailsController
                                      .bankAccountNumber.text,
                                  vendorBankDetailsController
                                      .iFSCCode.text,
                                  context).then((value){
                                if(value.status==true) {
                                  NewHelper.showToast(
                                      "Account Details Added Successfully");
                                  Get.back();
                                }
                                else{
                                  NewHelper.showToast(
                                      "Enter your Account details");
                                }
                              });
                            }
                          },
                          title: "Add Account",
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
      ),
    );
  }
}
