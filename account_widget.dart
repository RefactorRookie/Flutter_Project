import 'package:flutter/material.dart';

import 'app_icon.dart';
import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon,
    required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20,
      top: 10,
        bottom: 10
      ),

      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 2
          ),
        ]
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: 20,),
          bigText
        ],
      ),
    );
  }
}
