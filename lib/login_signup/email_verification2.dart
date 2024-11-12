import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../repository/forgot_repo.dart';
import '../routers/routers.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/new_helper.dart';

class EmailVerificationScreen2 extends StatefulWidget {
  const EmailVerificationScreen2({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen2> createState() => _EmailVerificationScreen2State();
}

class _EmailVerificationScreen2State extends State<EmailVerificationScreen2> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: screenHeight,
            child: Stack(
                children:[
                  Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight*.40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/LoginBackground.png'),
                              fit: BoxFit.fill
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            addHeight(45),
                            Image.asset('assets/images/AppLogo.png',width: 203,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 260,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const Center(
                                  child: Text('Enter The Phone Number Associated With Your Account',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'poppinsSans',
                                      fontWeight: FontWeight.w600,
                                      color:  Color(0xFF66656B),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                addHeight(22),
                                Container(
                                  width: screenWidth,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                  child: CommonTextFieldWidget(
                                    hint: 'Enter email',
                                    controller: emailController,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Please enter phone number'),
                                    ]),
                                  ),
                                ),
                                addHeight(25),
                                CommonButton(title: 'Send',onPressed: (){
                                  if (_formKey.currentState!.validate()) {
                                    forgotPassRepo(emailController.text, 3 ,context)
                                        .then((value) {
                                      if (value.status == true) {
                                        NewHelper.showToast(value.message.toString());
                                        Get.toNamed(MyRouters.otpForgotScreen,arguments: [emailController.text]);
                                      } else {
                                        NewHelper.showToast(value.message.toString());
                                      }
                                    });
                                  }
                                  // Get.toNamed(MyRouters.otpForgotScreen);
                                },),
                              ],
                            ),
                          ),
                        )
                    ),
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}
