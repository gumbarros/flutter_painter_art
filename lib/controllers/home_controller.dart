import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_painter_art/models/drawing_area.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<DrawingArea> points = [];

  final GlobalKey key = GlobalKey();

  Color selectedColor = Colors.black;
  double selectedStrokeWidth = 2.0;

  static HomeController get to => Get.find();

  void setPoints(details) {
    ///Caso o usuário remova o dedo da tela
    if (details.runtimeType == DragEndDetails) {
      points.add(null);
    } else {
      points.add(DrawingArea(
          point: details.localPosition,
          areaPaint: Paint()
            ..color = selectedColor
            ..strokeWidth = selectedStrokeWidth));
    }
    update();
  }

  void showColorDialog() {
    Get.dialog(AlertDialog(
      title: const Text(
        "Choose Color",
        textAlign: TextAlign.center,
      ),
      content: BlockPicker(
          pickerColor: this.selectedColor,
          onColorChanged: (color) {
            this.selectedColor = color;
            update();
          }),
      actions: [Center(child: TextButton(onPressed: Get.back, child: Text("Close")))],
    ));
  }

  void setSelectedStrokeWidth(value) {
    this.selectedStrokeWidth = value;
    update();
  }

  void eraser() {
    this.selectedColor = Colors.white;
    update();
  }

  void clearScreen(){
    this.points.clear();
    update();
  }

  void save()async{
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    await Share.file("Share", "my_drawing_${DateTime.now().toString().replaceAll(':','_')}.png", pngBytes, "image/png");
  }
}
