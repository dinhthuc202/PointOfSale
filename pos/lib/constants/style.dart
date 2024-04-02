import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

const light = Color(0xFFF7F8FC);
const lightGrey = Color(0xFFA4A6B3);
const dark = Color(0xFF363740);
const active = Color(0xFF3C19C0);
const nameApp = "Pos";
final formatMoney = NumberFormat("#,##0", "vi_VN");
List<TextInputFormatter> inputFormattersDecimal = [
  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
];
List<TextInputFormatter> inputFormattersDouble = [
  FilteringTextInputFormatter.allow(RegExp(r'^[1-9]\d*\.?\d{0,2}|0?\.\d{0,2}$'))
];
List<TextInputFormatter> inputFormattersInt = [
  FilteringTextInputFormatter.allow(RegExp(r'^[1-9]\d*|0$')),
];
