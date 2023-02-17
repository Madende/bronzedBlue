
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTextField extends StatelessWidget {
  final String? headingText;
  final String? hintText;
  final bool? obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String? obscureCharacter;
  final EdgeInsets? margin;
  final int? maxLines;
  final double? fieldTopPadding;
  final bool? readOnly;



  const CustomTextField({Key? key,
    this.headingText = 'Heading Text',
    this.hintText = 'Hint Text',
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.obscureCharacter = '*',
    this.margin,
    this.maxLines = 1,
    this.fieldTopPadding = 0.0,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(headingText!,
            style: GoogleFonts.inter().copyWith(
              fontSize: 14.0,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4.0),
          TextFormField(
            style: GoogleFonts.inter(
              fontSize: 14.0,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
            maxLines: maxLines,
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly!,
            obscureText: obscureText!,
            obscuringCharacter: obscureCharacter!,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 16.0, top: fieldTopPadding!, right: 16.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              fillColor: Colors.transparent,
              filled: true,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 14.0,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: prefixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
