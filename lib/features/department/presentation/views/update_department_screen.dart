import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:task_management_eraa_soft/features/department/presentation/cubit/department_cubit.dart';

import '../../../../core/utils/components.dart';
import '../../../../core/utils/custom_button.dart';


class UpdateDepartmentScreen extends StatelessWidget {
  const UpdateDepartmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final managerIdController = TextEditingController();
    var formDepartmentKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => DepartmentCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocConsumer<DepartmentCubit, DepartmentState>(
            listener: (context, state) {
              if (state is UpdateDepartmentSuccessState) {
                MotionToast.success(
                  description: const Text(
                    'Department updated Successfully',
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
              if (state is UpdateDepartmentErrorState) {
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
              return SafeArea(
                child: Form(
                  key: formDepartmentKey,
                  child: Column(
                    children: [
                      SizedBox(height: 30.h,),
                      Text(
                        "Update Department!",
                        style: GoogleFonts.roboto(
                            fontSize: 35.sp, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        ''' Update department details and
    assign a new manager to continue work!.
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
                          type: TextInputType.name,
                          label: 'Name',
                          controller: nameController,
                          hint: 'Name',
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please add department name';
                            }
                            if (value.length < 3 || value.length > 20) {
                              return "department name cant be less than 3 chars or more than 20 chars";
                            }
                            return null;
                          },
                          prefix: null,
                        ),
                      ),
                      SizedBox(height: 30.h,),
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: defaultFormField(
                          type: TextInputType.number,
                          label: 'Manager ID',
                          controller: managerIdController,
                          hint: 'Manager ID',
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please add manager id';
                            }
                            return null;
                          },
                          prefix: null,
                        ),
                      ),
                      SizedBox(height: 30.h,),

                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 55.h,
                          child: BuildCondition(
                            condition: state is! UpdateDepartmentLoadingState,
                            builder: (context) => CustomButton(
                              text: 'UPDATE',
                              onTap: () {
                                if (formDepartmentKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  DepartmentCubit.get(context).updateDepartment(
                                    nameController.text,
                                    managerIdController.text
                                  );
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
              );
            },
          ),
        ),
      ),
    );
  }
}
