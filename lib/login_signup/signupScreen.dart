import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../repository/signup_repo.dart';
import '../routers/routers.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/new_helper.dart';
import '../widgets/phone_filed.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey1 = GlobalKey<FormState>();
  RxBool checkboxColor = false.obs;
  bool showErrorMessage = false;
  bool value = false;
  bool isLoginPasswordShow= true;
  bool isLoginPasswordShow1= true;
  String initialCountryCode = "";
  String countryCode = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController(text: "+353");
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Form(
              key: _formKey1,
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                          height: 280,
                          width: double.maxFinite,
                          child: Image.asset('assets/images/LoginBackground.png',fit: BoxFit.cover,)),
                      SizedBox(
                        width: screenWidth,
                        child: Column(
                          children: [
                            addHeight(40),
                            Image.asset('assets/images/AppLogo.png',width: 203,),
                            addHeight(35),
                            const Center(
                              child: Text(' Sign Up to your Account',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color:  Color(0xFF66656B),
                                ),),
                            ),
                            addHeight(20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
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
                                  textInputAction: TextInputAction.next,
                                  hint: 'Name',
                                  controller: nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            addHeight(20),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          ),
                          child:  CommonTextFieldWidget(
                            textInputAction: TextInputAction.next,
                            hint: 'Email',
                            controller: emailController,
                            validator: MultiValidator([
                              EmailValidator(
                                  errorText:
                                  'enter a valid email address'),
                              RequiredValidator(
                                  errorText: 'Email is required')
                            ]),
                          ),
                        ),
                        addHeight(20),
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
                          child: CustomIntlPhoneField(
                            controller: phoneController,
                            dropdownIconPosition:
                            IconPosition.trailing,
                            dropdownTextStyle: GoogleFonts.poppins(
                                color: Colors.black),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(

                              hintText: 'Phone',
                              hintStyle: const TextStyle(
                                color:  Color(0xff2F353F),
                                fontSize: 13,
                                // fontFamily: 'poppins',
                                fontWeight: FontWeight.w300,
                              ),
                              counterText: "",
                              enabled: true,
                              contentPadding:
                              const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),

                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
                            ),
                              initialCountryCode:  'IE',
                              onCountryChanged: (phone) {
                                countryCodeController.text = "+${phone.dialCode}";
                                // print('Dial Code is:${phone.dialCode}');
                                // countryCode = value.dialCode;
                                //  initialCountryCode = value.code;
                                /*  if (kDebugMode) {
                                                        // print(countryCode);
                                                        // print(initialCountryCode);
                                                      }*/
                              },
                              onChanged: (phone){
                                // print(phone);
                                // print(phoneController);

                              }

                          ),
                        ),

                        addHeight(20),
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
                            textInputAction: TextInputAction.next,
                            hint: 'Password',
                            controller: passwordController,
                            obscureText: isLoginPasswordShow,
                            suffix: InkWell(
                              onTap: () {
                                isLoginPasswordShow = !isLoginPasswordShow;
                                setState(() {

                                });
                              },
                              child: Icon(
                                  isLoginPasswordShow
                                      ? CupertinoIcons.eye_slash_fill
                                      : CupertinoIcons.eye,
                                  size: 18,
                                  color: Colors.grey),
                            ),
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
                        addHeight(20),
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
                            hint: 'Confirm Password',
                            controller: confirmController,
                            obscureText: isLoginPasswordShow1,
                            suffix: InkWell(
                              onTap: () {
                                isLoginPasswordShow1 = !isLoginPasswordShow1;
                                setState(() {

                                });
                              },
                              child: Icon(
                                  isLoginPasswordShow1
                                      ? CupertinoIcons.eye_slash_fill
                                      : CupertinoIcons.eye,
                                  size: 18,
                                  color: Colors.grey),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "confirm the password";
                              } else if (confirmController.text !=
                                  passwordController.text) {
                                return "Confirm password should be match";
                              }
                              return null;
                            },
                          ),
                        ),
                        addHeight(23),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.1,
                              child: Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: checkboxColor.value == false
                                        ? const Color(0xFF64646F)
                                        : const Color(0xFF64646F)
                                ),
                                child: Checkbox(
                                    shape: const CircleBorder(),
                                    side: BorderSide(
                                        color:   showErrorMessage == false
                                            ? AppTheme.primaryColor
                                            : Colors.red,
                                        width: 2),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: value,
                                    activeColor: const Color(0xFF7ED957),
                                    onChanged: (newValue) {
                                      setState(() {
                                        value = newValue!;
                                        checkboxColor.value = !newValue;
                                      });
                                    }),
                              ),
                            ),
                            const Text(
                                'Keep Me Signed In.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color:  Color(0xFF64646F))),
                          ],
                        ),
                        addHeight(26),
                        CommonButton(
                            title: 'Signup',
                            onPressed: (){
                              if(_formKey1.currentState!.validate()){
                                //// print("Hello");
                                register(
                                    nameController.text,
                                    emailController.text,
                                    phoneController.text,
                                    passwordController.text,
                                    confirmController.text,
                                    3,
                                    countryCodeController.text,
                                    context
                                ).then((value){
                                  if(value.status==true){
                                    NewHelper.showToast(value.message);
                                    Get.toNamed(MyRouters.otpScreen,arguments: [emailController.text]);
                                  }else{
                                    NewHelper.showToast(value.message);
                                  }
                                });
                              }

                              // if (value != true) {
                              //     setState(() {
                              //       showErrorMessage = true;
                              //      ScaffoldMessenger.of(context).showSnackBar(
                              //       const SnackBar(
                              //        content: Text(
                              //         "Agree to our terms of Service"),
                              //      ));
                              //    }
                              //    );
                              //  }
                              // else {
                              //   setState(() {
                              //     showErrorMessage = false;
                              //     Get.toNamed(MyRouters.emailVerificationScreen);
                              //   });
                              // }
                            }),
                        addHeight(26),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?',
                              style: TextStyle(
                                  color:  Color(0xFF3A3737),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Get.back();
                              },
                              child:
                              const Text(' Login',
                                style: TextStyle(
                                    color:  Color(0xFF69C541),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ],
                        ),
                        addHeight(16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
