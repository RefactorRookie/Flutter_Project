import 'package:e_shop_flutter/controller/user_info_controller.dart';
import 'package:e_shop_flutter/pages/auth/sign_in_page.dart';
import 'package:e_shop_flutter/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controller/auth_controller.dart';
import '../utils/app_colors.dart';
import 'dart:io';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? name;
  String? image;
  String? shippingAddress;
  String? billingAddress;
  String? phone;

  @override
  void initState() {
    super.initState();
    loadResource();
  }

  Future<void> loadResource() async{
    if(Get.find<AuthController>().userLoggedIn()){
      await Get.find<UserInfoController>().getUserInfo();

      name = Get.find<UserInfoController>().name;
      image = Get.find<UserInfoController>().image;
      shippingAddress = Get.find<UserInfoController>().shippingAddress;
      billingAddress = Get.find<UserInfoController>().billingAddress;
      phone = Get.find<UserInfoController>().phone;

      nameController.text = name!;
      shippingAddressController.text = shippingAddress!;
      billingAddressController.text = billingAddress!;
      phoneController.text = phone!;
    }
  }

  void _uploadUserData(UserInfoController userInfoController){
    String name = nameController.text.trim();
    String billingAddress = billingAddressController.text.trim();
    String shippingAddress = shippingAddressController.text.trim();
    String phone = phoneController.text.trim();

    userInfoController.uploadUserData(name, billingAddress, shippingAddress, phone).then((status){
      if(status.isSuccess){
        loadResource();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Get.lazyPut(() => UserInfoController(userInfoRepo: Get.find()));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        title: Text('Profile', style: TextStyle(color: AppColors.mainBlackColor),),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<UserInfoController>(builder: (_userInfo){
        return ModalProgressHUD(
          inAsyncCall: _userInfo.upload,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            width: double.maxFinite,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      _userInfo.pickedImage();
                    },
                    child: Center(
                      child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(65),
                            color: Colors.grey[200],
                          ),
                          child: _userInfo.pickedFile == null ? _userInfo.image == null ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 60,
                                color: AppColors.mainColor,
                              ),
                              Text('Upload image', style: TextStyle(color: AppColors.mainColor),)
                            ],
                          ) : Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(65),
                                    image: DecorationImage(
                                        image:  NetworkImage(
                                          AppConstants.BASE_URL + _userInfo.image!,
                                        ),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    child: Icon(Icons.camera, color: Colors.white, size: 28,),
                                  )
                              )
                            ],
                          ) : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(65),
                                image: DecorationImage(
                                    image:  FileImage(
                                      File(_userInfo.pickedFile!.path).absolute,
                                    ),
                                    fit: BoxFit.cover
                                )
                            ),
                          )
                      ),
                    ),
                  ),
                  MyInputField(
                    controller: nameController,
                    title: "Name",
                    hint: "Enter your full name",
                  ),
                  MyInputField(
                    controller: billingAddressController,
                    title: "Billing Address",
                    hint: "Billing Address",
                  ),
                  MyInputField(
                    controller: shippingAddressController,
                    title: "Shipping Address",
                    hint: "Shipping Address",
                  ),
                  MyInputField(
                    controller: phoneController,
                    title: "Phone number",
                    hint: "Phone number",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyButton(label: "Save",
                    onTap: () {
                    _uploadUserData(_userInfo);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async{
                      await Get.find<AuthController>().clearToken();
                      Get.deleteAll();
                      Get.off(SignInPage());
                    },
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.rightFromBracket, color: Colors.white,),
                          SizedBox(width: 10,),
                          Text('Sign Out', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },)
    );
  }
}
