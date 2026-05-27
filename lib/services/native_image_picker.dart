import 'dart:io';
import 'package:flutter/services.dart';

class NativeImagePicker {
  static const _channel = MethodChannel('moodoo/image_picker');

  static Future<File?> pickFromGallery() async {
    try {
      final path = await _channel.invokeMethod<String>('pickFromGallery');
      return path != null ? File(path) : null;
    } on PlatformException {
      return null;
    }
  }

  static Future<File?> pickFromCamera() async {
    try {
      final path = await _channel.invokeMethod<String>('pickFromCamera');
      return path != null ? File(path) : null;
    } on PlatformException {
      return null;
    }
  }
}
