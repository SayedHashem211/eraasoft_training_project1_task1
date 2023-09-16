import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:task_management_eraa_soft/features/login/presentation/cubit/login_cubit.dart';

import '../../../../core/utils/custom_button.dart';
import '../../../login/presentation/views/login_screen.dart';
import '../cubit/logout_cubit.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LogoutCubit, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSuccessState) {
                MotionToast.success(
                  description: const Text(
                    'Logout Successfully',
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
              if (state is LogoutErrorState) {
                MotionToast.error(
                  description: const Text(
                    'Something went wrong',
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
              return Center(
                  child:
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 55.h,
                      child: BuildCondition(
                        condition: state is! LoginLoadingState,
                        builder: (context) => CustomButton(
                          text: 'LOGOUT',
                          onTap: () {
                              LogoutCubit.get(context).logout(
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return const LoginScreen();
                              }));
                            }
                        ),
                        fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                      )),
              );
            },
          ),
        ),
      ),
    );
  }
}
