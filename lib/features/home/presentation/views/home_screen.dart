import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management_eraa_soft/features/department/presentation/views/add_department_screen.dart';
import 'package:task_management_eraa_soft/features/department/presentation/views/update_department_screen.dart';
import 'package:task_management_eraa_soft/features/logout/presentation/views/logout_screen.dart';

import '../../../user/presentation/views/add_new_user_screen.dart';
import '../../../user/presentation/views/update_user_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 200.h,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LogoutScreen();
                  }));
                },
                child: const Text(
                  "go to log out",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(height: 20.h,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddDepartmentScreen();
                  }));
                },
                child: const Text(
                  "add new department",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(height: 20.h,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddNewUserScreen();
                  }));
                },
                child: const Text(
                  "add new user",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(height: 20.h,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UpdateDepartmentScreen();
                  }));
                },
                child: const Text(
                  "update department",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(height: 20.h,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UpdateUserScreen();
                  }));
                },
                child: const Text(
                  "update user",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
