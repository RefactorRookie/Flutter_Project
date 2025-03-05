import 'package:e_shop_flutter/controller/cart_controller.dart';
import 'package:e_shop_flutter/controller/order_controller.dart';
import 'package:e_shop_flutter/pages/payment_page.dart';
import 'package:e_shop_flutter/pages/product_details_page.dart';
import 'package:e_shop_flutter/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controller/product_details_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/app_icon.dart';
import '../widgets/big_text.dart';
import 'package:get/get.dart';

import 'nav_bar.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    super.initState();
    loadResource();
  }

  Future<void>loadResource() async {
    await Get.find<CartController>().getCartItems();
    await Get.find<OrderController>().getCartItems();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<CartController>(
          builder: (_cart) {
            return Stack(
              children: [
                Positioned(
                    left: 20,
                    right: 20,
                    top: 20 * 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: AppIcon(
                            icon: Icons.arrow_back_ios,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                            iconSize: 24,
                          ),
                        ),
                        SizedBox(
                          width: 20 * 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(NavBar());
                          },
                          child: AppIcon(
                            icon: Icons.home_outlined,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                            iconSize: 24,
                          ),
                        ),
                        AppIcon(
                          icon: Icons.shopping_cart_outlined,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          iconSize: 24,
                        )
                      ],
                    )),
                _cart.allCartItems.isEmpty ? Center(
                  child: Image.asset('assets/images/empty_cart.png'),
                ) : Positioned(
                  top: 20 * 5,
                  left: 20,
                  right: 20,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    //color: Colors.red,
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            itemCount: _cart.allCartItems.length,
                            itemBuilder: (_, index) {
                              return Container(
                                height: 20 * 5,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(ProductDetailsPage(id: _cart.allCartItems[index].productId.toString()));
                                      },
                                      child: _cart.allCartItems[index].productImage == null ? Container(
                                        width: 20 * 5,
                                        height: 20 * 5,
                                        margin:
                                        EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/loading.gif"),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            color: Colors.white),
                                      ) : Container(
                                        width: 20 * 5,
                                        height: 20 * 5,
                                        margin:
                                        EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL + _cart.allCartItems[index].productImage),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            color: Colors.white),
                                      )
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 20 * 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(
                                              text: _cart.allCartItems[index].productName ?? '',
                                              color: Colors.black54,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BigText(
                                                  text: _cart.allCartItems[index].productPrice == null ? '' : 'Tk ${_cart.allCartItems[index].productPrice * _cart.allCartItems[index].quantity}',
                                                  color: Colors.redAccent,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      left: 10,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .minus,
                                                          size: 16,
                                                          color: AppColors
                                                              .signColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      BigText(text: _cart.allCartItems[index].quantity == null ? '' : _cart.allCartItems[index].quantity.toString()),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Icon(
                                                          FontAwesomeIcons.plus,
                                                          size: 16,
                                                          color: AppColors
                                                              .signColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })),
                  ),
                )
              ],
            );
          },
        ),
        bottomNavigationBar: GetBuilder<OrderController>(builder: (_cart){
          return Get.find<CartController>().allCartItems.isEmpty ? Container(
            height: 0,
          ) : Container(
            height: 20 * 6,
            padding: EdgeInsets.only(
              top: 30,
              bottom: 30,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  20 * 2,
                ),
                topLeft: Radius.circular(20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        BigText(text: 'Tk ${Get.find<CartController>().totalAmount.toString()}'),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                ),
                GestureDetector(
                  onTap: () {

                    Get.to(
                        PaymentPage(totalPrice: Get.find<CartController>().totalAmount, ordersId: _cart.orderId, cartId: Get.find<CartController>().orderId,));
                  },
                  child: Container(
                    padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                    child: BigText(
                      text: 'Check out',
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ],
            ),
          );
        },)
    );
  }
}
