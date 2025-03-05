import 'package:e_shop_flutter/controller/cart_controller.dart';
import 'package:e_shop_flutter/controller/make_order_controller.dart';
import 'package:e_shop_flutter/controller/order_controller.dart';
import 'package:e_shop_flutter/models/make_order_model.dart';
import 'package:e_shop_flutter/utils/app_colors.dart';
import 'package:e_shop_flutter/widgets/big_text.dart';
import 'package:e_shop_flutter/widgets/button.dart';
import 'package:e_shop_flutter/widgets/input_field.dart';
import 'package:e_shop_flutter/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controller/user_info_controller.dart';
import 'nav_bar.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key, required this.totalPrice, required this.ordersId, required this.cartId}) : super(key: key);

  final int totalPrice;
  final List<int> ordersId;
  final List<int> cartId;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  String paymentGateway = 'cash on delivery';
  int _value = 1;
  var user;

  @override
  void initState() {
    super.initState();
    loadResource();
    print(widget.ordersId);
  }

  loadResource() async{
    await Get.find<CartController>();
    await Get.find<CartController>().getCartItems();

    await Get.find<OrderController>();
    await Get.find<OrderController>().getCartItems();

    await Get.find<MakeOrderController>();

    await Get.find<UserInfoController>().getUserInfo();
    user = Get.find<UserInfoController>().user;
    print(user);
  }

  _deleteOrder(String id) async{
    await Get.find<CartController>().deleteOrderItems(id);
  }

  _makeOder(MakeOrderController makeOrderController){
    MakeOrderModel makeOrderModel = MakeOrderModel(user: user, orderDetails: widget.ordersId, totalPrice: widget.totalPrice, paymentStatus: paymentGateway);
    makeOrderController.makeOrder(makeOrderModel).then((status){
      if(status.isSuccess){
        for(int i = 0; i < widget.cartId.length; i++){
          _deleteOrder(widget.cartId[i].toString());
        }
        Get.off(NavBar());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Get.lazyPut(() => MakeOrderController(makeOrderRepo: Get.find()));

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        title: BigText(text: "Payment", color: AppColors.mainBlackColor,),
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.mainBlackColor,),
        ),
      ),


      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Radio(
                        activeColor: AppColors.mainColor,
                        value: 1,
                        groupValue: _value,
                        onChanged: (value){
                          setState(() {
                            _value = int.parse(value.toString());
                            paymentGateway = 'cash on delivery';
                          });
                        }
                        ),
                    SmallText(text: 'Cash on Delivery', size: 18, color: AppColors.mainBlackColor,),
                    SizedBox(width: 20,),
                    Icon(FontAwesomeIcons.wallet),

                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    ]
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Radio(
                      activeColor: AppColors.mainColor,
                        value: 2,
                        groupValue: _value,
                        onChanged: (value){
                          setState(() {
                            _value = int.parse(value.toString());
                            paymentGateway = 'bKash';
                          });
                        }
                    ),

                    SmallText(text: 'bKash', size: 18, color: AppColors.mainBlackColor,),
                    SizedBox(width: 20,),
                    Image.asset('assets/images/bkash.png', height: 30,),

                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    ]
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Radio(
                        activeColor: AppColors.mainColor,
                        value: 3,
                        groupValue: _value,
                        onChanged: (value){
                          setState(() {
                            _value = int.parse(value.toString());
                            paymentGateway = 'nagad';
                          });
                        }
                    ),
                    SmallText(text: 'Nagad', size: 18, color: AppColors.mainBlackColor,),
                    SizedBox(width: 20,),
                    Image.asset('assets/images/nagad.png', height: 30,),

                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    ]
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Radio(
                        activeColor: AppColors.mainColor,
                        value: 4,
                        groupValue: _value,
                        onChanged: (value){
                          setState(() {
                            _value = int.parse(value.toString());
                            paymentGateway = 'card';
                          });
                        }
                    ),

                    SmallText(text: 'Cards', size: 18, color: AppColors.mainBlackColor,),
                    SizedBox(width: 20,),
                    Image.asset('assets/images/cards.png', height: 30,),

                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    ]
                ),
              ),
              _value == 4 ? MyInputField(title: 'Card Number', hint: "Card Number",) : Container(),
              _value == 4 ?Row(
                children: [
                  Expanded(child: MyInputField(title: 'Expiry Date', hint: "MM/YY",)),
                  SizedBox(width: 10,),
                  Expanded(child: MyInputField(title: 'CW/CVC', hint: "123",)),
                ],
              ) : Container()
            ],
          ),
        ),
      ),

      bottomNavigationBar: GetBuilder<MakeOrderController>(builder: (order){
        return Container(
          height: height * 0.1,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: MyButton(
            label: "Complete Order - Tk ${widget.totalPrice}",
            onTap: (){
              _makeOder(order);
            },
          ),
        );
      },)
    );
  }
}
