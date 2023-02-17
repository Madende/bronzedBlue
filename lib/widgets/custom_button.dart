import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomButton extends StatelessWidget {
  final String? btnText;
  final double? btnTextSize;
  final Color? btnColor;
  final Color? btnTextColor;
  final VoidCallback? onTap;
  final EdgeInsets? margin;
  final double? btnWidth;
  final double? btnHeight;

  const CustomButton({Key? key,
    required this.onTap,
    this.btnTextSize = 16.0,
    this.btnText = 'Button Text',
    this.btnTextColor = Colors.white,
    this.margin,
    this.btnColor = Colors.black,
    this.btnWidth,
    this.btnHeight,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: btnColor!,
          elevation: 1.0,
          onPrimary: Colors.white,
          /*side: BorderSide(
            color: borderColor!,
            width: 1.0,
          ),*/
          shadowColor: Colors.black.withOpacity(0.1),
          minimumSize: Size(btnWidth ?? MediaQuery.of(context).size.width, btnHeight ?? 45.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Center(
          child: Text(
            btnText!, textAlign: TextAlign.center,
            style: GoogleFonts.workSans().copyWith(
              fontSize: btnTextSize,
              fontWeight: FontWeight.w600,
              color: btnTextColor,
            ),
          ),
        ),
      ),
    );
  }
}