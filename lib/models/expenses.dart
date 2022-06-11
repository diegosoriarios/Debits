import 'package:flutter/material.dart';

enum MoneyType { GASTO, RECEBIMENTO }

class Expenses {
  String id;
  String icon;
  String text;
  double value;
  Color color;
  MoneyType type;
  DateTime? createdAt = DateTime.now();

  Expenses({
    required this.id,
    required this.icon,
    required this.text,
    required this.value,
    required this.color,
    required this.type,
    this.createdAt,
  });
}
