import 'dart:async';

import 'package:e_shop_flutter/pages/auth/sign_in_page.dart';
import 'package:e_shop_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../utils/app_colors.dart';
import 'nav_bar.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
      const Duration(seconds: 3),
        () async{
          if(Get.find<AuthController>().userLoggedIn()){
            await Get.find<AuthController>().loggedInUser();
            Get.off(NavBar());
          }
          else{
            Get.off(SignInPage());
          }
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fitWidth
                )
              ),
            )
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to ",
                  style: TextStyle(
                      fontFamily: 'KdamThmorPro',
                      color: Colors.white,
                      fontSize: screenHeight * 0.045
                  ),
                ),
                Text(
                  "E-Shop",
                  style: TextStyle(
                      fontFamily: 'KdamThmorPro',
                      color: Colors.white,
                      fontSize: screenHeight * 0.045,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
