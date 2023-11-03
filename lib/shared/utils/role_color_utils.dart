import 'package:flutter/material.dart';

Color roleCardColor(String role) {
  Color? color;
  if (role == 'conductor') {
    color = Colors.green.shade100;
  } else if (role == 'driver') {
    color = Colors.blue.shade100;
  } else {
    color = Colors.grey.shade300;
  }
  return color;
}

Color roleTextColor(String role) {
  Color? color;
  if (role == 'conductor') {
    color = Colors.green;
  } else if (role == 'driver') {
    color = Colors.blue;
  } else {
    color = Colors.grey;
  }
  return color;
}