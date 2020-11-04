import 'package:flutter/material.dart';

class BaseDevice {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  List<int> fitsBaseDevices;
  int battery = -1;

  BaseDevice(
      this.id, this.name, this.description, this.imagePath, this.battery);

  getBatteryIcon(double size) {
    IconData icon;
    if (battery > 0 && battery < 20) {
      icon = Icons.battery_alert;
    } else if (battery >= 20 && battery < 90) {
      icon = Icons.battery_std;
    } else if (battery >= 90 && battery <= 100) {
      icon = Icons.battery_full;
    } else {
      icon = Icons.battery_unknown;
    }
    return Icon(icon, size: size);
  }

  getBatteryStr() {
    return this.battery.toString() + " %";
  }

  getImage() {
    return Image.asset(this.imagePath);
  }
}
