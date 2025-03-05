import 'package:e_shop_flutter/controller/cart_controller.dart';
import 'package:e_shop_flutter/controller/order_controller.dart';
import 'package:e_shop_flutter/controller/product_list_controller.dart';
import 'package:e_shop_flutter/models/cart_model.dart';
import 'package:e_shop_flutter/pages/auth/sign_in_page.dart';
import 'package:e_shop_flutter/pages/cart_page.dart';
import 'package:e_shop_flutter/pages/product_details_page.dart';
import 'package:e_shop_flutter/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controller/auth_controller.dart';
import '../controller/user_info_controller.dart';
import '../models/product_list_model.dart';
import '../utils/app_colors.dart';
import '../widgets/app_icon.dart';
import '../widgets/big_text.dart';
import '../widgets/custom_text.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var user;
  int cartItems = 0;
  bool showSpinner = false;

  List<Products> products = [];
  List<Products> foundProducts = [];

  @override
  void initState() {
    super.initState();
    loadResource();
    foundProducts = [];
    foundProducts = products;
  }

  loadResource() async{
    products = [];
    await Get.find<ProductListController>().getProduct();
    products.addAll(Get.find<ProductListController>().allProductList);

    await Get.find<UserInfoController>().getUserInfo();
    await Get.find<UserInfoController>().getUserInfo();
    user = Get.find<UserInfoController>().user;
    Get.find<CartController>();
    Get.find<OrderController>();

    await Get.find<CartController>().getCartItems();
    cartItems = int.parse(Get.find<CartController>().cartItem.toString());
    setState(() {

    });
  }

  _addToCart(CartModel cartModel) async{
    await Get.find<CartController>().uploadCartItems(cartModel).then((status){
      if(status.isSuccess){
        showSpinner = false;
      }
    });
  }

  _addToOrder(CartModel cartModel) async{
    await Get.find<OrderController>().uploadCartItems(cartModel).then((status){
      if(status.isSuccess){

      }
    });
  }

  void _runFilter(String enteredKeyword){
    List<Products> results = [];
    if(enteredKeyword.isEmpty){
      results = products;
    }
    else{
      results = products.where((e) => (e.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))).toList();
    }

    setState(() {
      foundProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              children: [
                GetBuilder<UserInfoController>(builder: (_userInfo){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        _userInfo.image == null ? CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage("assets/images/profile.jpg"),
                        ) : CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(AppConstants.BASE_URL + _userInfo.image!),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: 'Hello,',
                                textColor: AppColors.titleColor,
                                fontSize: 16),
                            CustomText(
                              text: _userInfo.name == null ? '' : _userInfo.name!,
                              textColor: AppColors.mainBlackColor,
                              fontSize: 18,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                      ),

                      GestureDetector(
                        onTap: (){
                          Get.to(CartPage());
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: cartItems == 0 ? Container() : AppIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                              ),) ,


                            cartItems == 0 ? Container() : Positioned(
                              right: cartItems <= 9 ? 6 : 3,
                              top: 3,
                              child: BigText(text: cartItems.toString(), size: 12, color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 10),
                            color: Colors.grey.withOpacity(0.2)
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: TextField(
                    onChanged: (value){
                      _runFilter(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search,
                        color: AppColors.mainColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.white
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.white
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                GetBuilder<ProductListController>(builder: (product){
                  return product.isLoading ? Expanded(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              mainAxisExtent: 250
                          ),
                          itemCount: foundProducts.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                Get.to(ProductDetailsPage(id: foundProducts[index].id.toString()));
                              },
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 150,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: NetworkImage(AppConstants.BASE_URL + foundProducts[index].image.toString()),
                                                fit: BoxFit.fitHeight
                                            )
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 30,),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: BigText(
                                          text: foundProducts[index].name.toString(), size: 16, color: AppColors.paraColor,),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10, left: 10),
                                      child: BigText(text: 'Tk ${foundProducts[index].price.toString()}'),
                                    ),
                                    SizedBox(height: 10,),
                                    Center(
                                      child: Container(
                                        //width: MediaQuery.of(context).size.width * 0.38,
                                        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(CupertinoIcons.cart, size: 24, color: Colors.white,),
                                            SizedBox(width: 5,),
                                            GestureDetector(
                                              onTap: () async{
                                                showSpinner = true;
                                                CartModel cartModel = CartModel(user: user, productId: foundProducts[index].id, quantity: 1, totalPrice: foundProducts[index].price);
                                                _addToOrder(cartModel);
                                                _addToCart(cartModel);
                                                loadResource();
                                              },
                                              child: CustomText(
                                                text: 'Add to Cart', textColor: Colors.white, fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: AppColors.mainColor
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
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
                            );
                          }),
                    ),
                  ) : Center(
                    child: CircularProgressIndicator(color: AppColors.mainColor,),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
