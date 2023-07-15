import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
TextStyle appStyle(
    double fontSize,
    Color fontColor,
    FontWeight fontWeight
    ){
  return GoogleFonts.poppins(
    fontSize: fontSize,
    color: fontColor,
    fontWeight: fontWeight
  );
}

TextStyle appStyleTwo(
    double fontSize,
    double height,
    Color fontColor,
    FontWeight fontWeight,
    ){
  return GoogleFonts.poppins(
      fontSize: fontSize,
      color: fontColor,
      height: height,
      fontWeight: fontWeight
  );
}