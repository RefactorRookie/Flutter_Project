import 'package:e_shop_flutter/controller/product_details_controller.dart';
import 'package:e_shop_flutter/pages/cart_page.dart';
import 'package:e_shop_flutter/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/cart_controller.dart';
import '../controller/order_controller.dart';
import '../controller/user_info_controller.dart';
import '../models/cart_model.dart';
import '../utils/app_colors.dart';
import '../widgets/app_icon.dart';
import '../widgets/big_text.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  int cartItem = 1;

  var user;
  var name = '';
  var price = '';
  var description = '';
  var image = '';
  var stock = '';
  var productId = '';
  int cartItems = 0;

  int totalPrice = 0;

  cartSystem(String tag){
    if(tag == 'add'){
      if(cartItem < 15 ) {
        cartItem++;
      }
      else{
        Get.snackbar('Item limit exceeded', 'You can\'t add more than 15',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: Icon(Icons.warning, color: Colors.white,)
        );
      }
    }
    else if(tag == 'min'){
      if(cartItem > 1 ) {
        cartItem--;
      }
      else{
        Get.snackbar('Item quantity can\'t be 0', 'You should have at-least one item in your cart',
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: Icon(Icons.warning, color: Colors.white,)
        );
      }
    }

    totalPrice = int.parse(price) * cartItem;
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    loadResource();
  }

  Future<void>loadResource() async{

    await Get.find<CartController>().getCartItems();
    await Get.find<OrderController>().getCartItems();

    await Get.find<UserInfoController>().getUserInfo();
    user = Get.find<UserInfoController>().user;
    Get.find<CartController>();
    Get.find<OrderController>();

    await Get.find<ProductDetailsController>().getProduct(widget.id);

    productId = Get.find<ProductDetailsController>().productId.toString();
    name = Get.find<ProductDetailsController>().name!;
    image = Get.find<ProductDetailsController>().image!;
    price = Get.find<ProductDetailsController>().price.toString();
    stock = Get.find<ProductDetailsController>().stock.toString();
    totalPrice = int.parse(price);
    await Get.find<CartController>().getCartItems();
    cartItems = int.parse(Get.find<CartController>().cartItem.toString());
    setState(() {

    });
    setState(() {
      description = Get.find<ProductDetailsController>().description!;
    });
  }

  _addToCart(CartModel cartModel) async{
    await Get.find<CartController>().uploadCartItems(cartModel);
  }

  _addToOrder(CartModel cartModel) async{
    await Get.find<OrderController>().uploadCartItems(cartModel);
  }


  @override
  Widget build(BuildContext context) {

    Get.lazyPut(() => ProductDetailsController(productDetailsRepo: Get.find()));

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){

                      Get.back();
                    },
                    child: AppIcon(icon: Icons.clear)
                ),
                GestureDetector(
                    onTap: (){

                    },
                    child: GetBuilder<CartController>(builder: (_cart){
                      return GestureDetector(
                        onTap: (){
                          Get.to(CartPage());
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                              ),) ,


                            Positioned(
                              right: int.parse(_cart.cartItem.toString()) <= 9 ? 6 : 3,
                              top: 3,
                              child: BigText(text: _cart.cartItem == null? '' : cartItems.toString(), size: 12, color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },)
                  )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                width: double.maxFinite,
                child: Center(
                    child: BigText(
                      text: name,
                      size: 26,
                    )),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: image == '' ? Image.asset('assets/images/loading.gif') : Image.network(
                AppConstants.BASE_URL + image,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 20, right: 20),
                  color: Colors.white,
                  child: Text(description, style: TextStyle(fontSize: 16),)
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
         Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
                  top: 10,
                  bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      cartSystem("min");
                    },
                    child: AppIcon(
                      iconSize: 24,
                      icon: Icons.remove,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                    ),
                  ),
                  BigText(
                    text: 'Tk ${price} x $cartItem',
                    color: AppColors.mainBlackColor,
                    size: 26,
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      cartSystem("add");
                      print(cartItem);
                    },
                    child: AppIcon(
                      iconSize: 24,
                      icon: Icons.add,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
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
                    40,
                  ),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      CartModel cartModel = CartModel(user: user, productId: int.parse(productId), quantity: cartItem, totalPrice: totalPrice);
                      _addToOrder(cartModel);
                      _addToCart(cartModel);
                      loadResource();
                    },
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                            left: 20,
                            right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.shopping_cart, color: AppColors.mainColor,)
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                        right: 20),
                    child: BigText(
                      text: 'Tk ${totalPrice}',
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
