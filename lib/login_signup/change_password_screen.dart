import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../repository/resend_password_repo.dart';
import '../routers/routers.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/new_helper.dart';




class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override

  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var obscureText = true;
  var obscureText1 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(Get.arguments);
    text = Get.arguments;
  }
  String text = '';
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
                            addHeight(85),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 280,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
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
                                      color: Colors.white
                                  ),
                                  child: CommonTextFieldWidget(
                                    hint: 'New Password',
                                    controller: newPasswordController,
                                    obscureText: obscureText,
                                    suffix: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            obscureText = !obscureText;
                                          });
                                        },
                                        child: obscureText
                                            ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                        )
                                            : const Icon(
                                          Icons.visibility,
                                          color: Color(0xFF53B176),
                                        )),
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Password must be minimum 8 characters, with \n1 Capital letter & 1 numerical.'),
                                      MinLengthValidator(8,
                                          errorText:
                                          'Password must be minimum 8 characters, with \n1 Capital letter & 1 numerical.'),
                                      PatternValidator(
                                          r'^(?=.*[A-Z])(?=.*\d).{8,}$',
                                          errorText:
                                          'Password must be minimum 8 characters, with \n1 Capital letter & 1 numerical.')
                                    ]),

                                  ),
                                ),
                                addHeight(15),
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
                                      color: Colors.white
                                  ),
                                  child: CommonTextFieldWidget(
                                    hint: 'Confirm New Password',
                                    controller: confirmPasswordController,
                                    obscureText: obscureText1,
                                    suffix: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            obscureText1 = !obscureText1;
                                          });
                                        },
                                        child: obscureText1
                                            ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                        )
                                            : const Icon(
                                          Icons.visibility,
                                          color: Color(0xFF53B176),
                                        )),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "confirm the password";
                                      } else if (newPasswordController.text !=
                                          confirmPasswordController.text) {
                                        return "Confirm password should be match";
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                addHeight(34),
                                CommonButton(title: 'Continue',onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    resetPasswordRepo(email: text,password: newPasswordController.text, confirmPassword: confirmPasswordController.text, context: context, roleText: '3',).then((value) {
                                      if(value.status == true){
                                        NewHelper.showToast(value.message);
                                        Get.offAllNamed(MyRouters.loginScreen);
                                      }
                                      else{
                                        NewHelper.showToast(value.message);
                                      }
                                    });
                                  }
                                  // Get.toNamed(MyRouters.loginScreen);
                                },),
                                addHeight(36),
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