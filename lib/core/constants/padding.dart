import 'package:flutter/material.dart';

class PagePaddings extends EdgeInsets {
  const PagePaddings.all20() : super.all(20);
  const PagePaddings.all15() : super.all(15);
  const PagePaddings.vertical10() : super.symmetric(vertical: 10);
  const PagePaddings.horizontal10() : super.symmetric(horizontal: 10);
}
