import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/components/custom_text.dart';
import 'package:travel_app_flutter/helpers/constants.dart';



class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color = k_primaryColor,
    this.width,
    this.radius = 15,
  }) : super(key: key);
  final String text;
  final Color color;
  final void Function()? onPressed;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57,
      width: width ?? Get.width * 0.85,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0, backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: onPressed,
        child: CustomText(
          text: text,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
