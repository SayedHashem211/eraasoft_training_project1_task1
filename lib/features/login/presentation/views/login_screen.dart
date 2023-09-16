import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:task_management_eraa_soft/features/login/presentation/cubit/login_cubit.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:task_management_eraa_soft/core/utils/custom_button.dart';

import '../../../../core/utils/components.dart';
import '../../../home/presentation/views/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    var formLoginKey = GlobalKey<FormState>();
    bool isChecked = false;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          MotionToast.success(
            description: const Text(
              'Login Successfully',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15),
            ),
            animationType: AnimationType.fromLeft,
            //layoutOrientation: ORIENTATION.rtl,
            position: MotionToastPosition.bottom,
            width: 300.w,
            height: 100.h,
          ).show(context);
        }
        if (state is LoginErrorState) {
          MotionToast.error(
            description: const Text(
              'please check your inputs',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15),
            ),
            animationType: AnimationType.fromLeft,
            //layoutOrientation: ORIENTATION.rtl,
            position: MotionToastPosition.bottom,
            width: 300.w,
            height: 100.h,
          ).show(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: formLoginKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Welcome Back!",
                      style: GoogleFonts.roboto(
                          fontSize: 40, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      '''Login to access your assigned tasks
    and personal overview.
                   ''',
                      style: GoogleFonts.roboto(
                          color: const Color(0xFF7C808A),
                          fontSize: 17.sp,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: defaultFormField(
                        type: TextInputType.emailAddress,
                        label: 'Email',
                        controller: emailController,
                        hint: 'Email',
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please add your email';
                          }
                          final bool isValid = EmailValidator.validate(value);
                          if (!isValid) {
                            return "please enter right email";
                          }
                          return null;
                        },
                        prefix: null,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: defaultFormField(
                          label: 'Password',
                          suffix: LoginCubit.get(context).suffix,
                          isPassword: LoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();

                          },
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          hint: 'Password',
                          prefix: null,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                    //         RegExp regex = RegExp(
                    //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#\$&*~]).{8,}$');
                    //         if (!regex.hasMatch(value)) {
                    //         return
                    //           ''' password must contain at least one capital letter and
                    // one special character''';
                    //         }
                            return null;
                          }),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 7.w,
                        ),
                        Checkbox(
                          checkColor: Colors.white,
                          //fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            // setState(() {
                            //   isChecked = value!;
                            // });
                          },
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Keep me logged in",
                          style: GoogleFonts.roboto(
                              fontSize: 18.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 55.h,
                        child: BuildCondition(
                          condition: state is! LoginLoadingState,
                          builder: (context) => CustomButton(
                            text: 'LOGIN',
                            onTap: () {
                              if (formLoginKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                debugPrint('email : ${emailController.text}');
                                debugPrint(
                                    'password : ${passwordController.text}');
                                LoginCubit.get(context).login(
                                  emailController.text,
                                  passwordController.text,
                                  //token: CacheHelper.getData(key: 'token') ??'',
                                  //context: context,
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const HomeScreen();
                                }));
                              } else {
                                FocusScope.of(context).unfocus();
                              }
                            },
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}
