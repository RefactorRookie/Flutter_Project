import 'package:e_shop_flutter/utils/app_colors.dart';
import 'package:e_shop_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = 150;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(text: firstHalf, color: AppColors.paraColor, size: 18,)
          : Column(
              children: [
                SmallText(
                  text: hiddenText
                      ? (firstHalf + '...')
                      : (firstHalf + secondHalf),
                  size : 18,
                  color: AppColors.paraColor,
                  height: 1.8,
                ),

                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText ? 'Show more' : 'Show less',
                        color: AppColors.mainColor,
                        size : 18,
                      ),

                      Icon(hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up, color: AppColors.mainColor,)
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
