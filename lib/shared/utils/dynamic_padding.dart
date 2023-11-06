import 'package:flutter/material.dart';

double paddingWidth(context) {
  double screenWidth = MediaQuery.of(context).size.width;

  double val;
  if (screenWidth < 600) {
    // For smaller screens
    val = 8.0;
  } else if (screenWidth < 1200) {
    // For medium-sized screens
    val = screenWidth * 0.1;
  } else {
    // For larger screens
    val = screenWidth * 0.25;
  }
  return val;
}

double paddingBarWidth(context) {
  double screenWidth = MediaQuery.of(context).size.width;

  double val;
  if (screenWidth < 600) {
    // For smaller screens
    val = 8.0;
  } else if (screenWidth < 1200) {
    // For medium-sized screens
    val = screenWidth * 0.08;
  } else {
    // For larger screens
    val = screenWidth * 0.2;
  }
  return val;
}

double paddingHeight(context) {
  double screenHeight = MediaQuery.of(context).size.height;

  double val;

  if (screenHeight < 600) {
    // For smaller screens
    val = 8.0;
  } else if (screenHeight < 1200) {
    // For medium-sized screens
    val = 70.0;
  } else {
    // For larger screens
    val = screenHeight * 0.2;
  }
  return val;
}
