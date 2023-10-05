import 'package:flutter/material.dart';

var kBoxShadow = BoxDecoration(
    color: Colors.grey[300],
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
          color: Colors.grey.shade400,
          offset: Offset(4, 4),
          blurRadius: 15,
          spreadRadius: 1),
      BoxShadow(
          color: Colors.white,
          offset: Offset(-4, -4),
          blurRadius: 15,
          spreadRadius: 1),
    ]);
const kMargin = EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0);
