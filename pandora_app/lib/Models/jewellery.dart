import 'package:flutter/material.dart';

class JewelleryPiece {
  final int id;
  final String name;
  final String imagePath;
  final String description;
  List<int> fitsBaseDevices;

  JewelleryPiece(this.id, this.name, this.description, this.imagePath);

  getImage() {
    return Image.asset(this.imagePath);
  }
}
