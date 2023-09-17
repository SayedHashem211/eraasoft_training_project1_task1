import 'package:buildcondition/buildcondition.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../../../core/utils/components.dart';
import '../../../../core/utils/custom_button.dart';
import '../cubit/user_cubit.dart';


class AddNewUserScreen extends StatefulWidget {
  const AddNewUserScreen({Key? key}) : super(key: key);

  @override
  State<AddNewUserScreen> createState() => _AddNewUserScreenState();
}

// Initial Selected Value of record numbers
//String userDefaultValue = 'Admin';

// List of items in our dropdown menu of record numbers
var userTypes = [
  'Admin',
  'Manager',
  'User',
];

class _AddNewUserScreenState extends State<AddNewUserScreen> {
  @override
  Widget build(BuildContext context) {


    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final departmentIdController = TextEditingController();

    var formUserKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => UserCubit(),
      child: Scaffold(
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
    if (state is AddUserSuccessState) {
    MotionToast.success(
    description: const Text(
    'user added Successfully',
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
    if (state is AddUserErrorState) {
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
            return SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: formUserKey,
                  child: Column(
                      children: [
                        SizedBox(height: 30.h,),
                        Text(
                          "Add New User!",
                          style: GoogleFonts.roboto(
                              fontSize: 37.sp, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          ''' Create a new user now and assign
    them tasks right away.
                         ''',
                          style: GoogleFonts.roboto(
                              color: const Color(0xFF7C808A),
                              fontSize: 17.sp,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 17.h,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: defaultFormField(
                            type: TextInputType.name,
                            label: 'Name',
                            controller: nameController,
                            hint: 'Name',
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please add user name';
                              }
                              return null;
                            },
                            prefix: null,
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: defaultFormField(
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            controller: emailController,
                            hint: 'Email',
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please add email address';
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
                        SizedBox(height: 8.h,),
                        Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: defaultFormField(
                            type: TextInputType.phone,
                            label: 'Phone',
                            controller: phoneController,
                            hint: 'Phone',
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please add mobile number';
                              }
                              if (value.length < 11) {
                                return "invalid mobile number";
                              }
                              return null;
                            },
                            prefix: null,
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: defaultFormField(
                            type: TextInputType.name,
                            label: 'Password',
                            controller: passwordController,
                            hint: 'Password',
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please add password';
                              }
                              return null;
                            },
                            prefix: null,
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: defaultFormField(
                            type: TextInputType.number,
                            label: 'Department ID',
                            controller: departmentIdController,
                            hint: 'Department ID',
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please add department id';
                              }
                              return null;
                            },
                            prefix: null,
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        DropdownButton(
                          //isExpanded: true,
                          elevation: 0,
                          //borderRadius: BorderRadius.circular(5.r),
                          iconSize: 45,
                          dropdownColor: const Color(0xFFD6E8EE),
                          borderRadius: BorderRadius.circular(30.r),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                              color: Colors.black),
                          // Initial Value
                          //value: dropdownDefaultValue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: userTypes.map((String items) {
                            return DropdownMenuItem(
                              alignment: Alignment.topCenter,
                              value: items,
                              child: Text(items),
                              // alignment: Alignment.center,
                            );
                          }).toList(),
                          menuMaxHeight: 200.h,
                          hint: const Text("choose user type", style: TextStyle(
                              color: Colors.black87,
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                          ),),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            UserCubit.get(context).changeUpdateUserValue(newValue);
                          },
                        ),
                        SizedBox(height: 5.h,),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 55.h,
                            child: BuildCondition(
                              condition: state is! AddUserLoadingState,
                              builder: (context) => CustomButton(
                                text: 'CREATE',
                                onTap: () {
                                  if (formUserKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    //debugPrint('email : ${nameController.text}');
                                    UserCubit.get(context).addUser(nameController.text, emailController.text, phoneController.text, passwordController.text, departmentIdController.text, UserCubit.get(context).buttonValueUpdate.toString());
                                  } else {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                              ),
                              fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                            )),

                      ]
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


}

