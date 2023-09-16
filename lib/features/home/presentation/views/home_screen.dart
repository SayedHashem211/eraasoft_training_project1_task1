import 'package:flutter/material.dart';
import 'package:task_management_eraa_soft/features/logout/presentation/views/logout_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TextButton(
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
        ),
      ),
    );
  }
}
