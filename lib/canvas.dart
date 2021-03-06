import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CustomImageCanvas extends StatefulWidget {
  CustomImageCanvas({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CustomImageCanvasState createState() => _CustomImageCanvasState();
}

class _CustomImageCanvasState extends State<CustomImageCanvas> {
  ui.Image? image;
  bool isImageloaded = false;
  void initState() {
    super.initState();
    init();
  }

  Future<Null> init() async {
    final ByteData data = await rootBundle.load('assets/new1.jpeg');
    image = await loadImage(Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(img) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  Widget _buildImage() {
    if (this.isImageloaded) {
      return CustomPaint(
        painter: PngImagePainter(image: image!),
      );
    } else {
      return Center(child: Text('loading'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: _buildImage(),
        ));
  }
}

class PngImagePainter extends CustomPainter {
  PngImagePainter({
    required this.image,
  });

  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    _drawCanvas(size, canvas);
    _saveCanvas(size);
  }

  Canvas _drawCanvas(Size size, Canvas canvas) {
    final center = Offset(150, 50);
    final radius = math.min(size.width, size.height) / 8;

    // The circle should be paint before or it will be hidden by the path
    Paint paintCircle = Paint()..color = Colors.black;
    Paint paintBorder = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width / 36
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, radius, paintBorder);

    double drawImageWidth = 0;
    var drawImageHeight = 0.0;

    // -size.height * 0.8;

    Path path = Path()
      ..addRect(Rect.fromLTWH(
          drawImageWidth, drawImageHeight, image.width.toDouble(), 90));
    // ..addOval(Rect.fromLTWH(
    // drawImageWidth, drawImageHeight, image.width.toDouble(), 90));

    canvas.clipPath(path);

    canvas.drawImage(image, Offset(drawImageWidth, drawImageHeight), Paint());
    return canvas;
  }

  _saveCanvas(Size size) async {
    var pictureRecorder = ui.PictureRecorder();
    var canvas = Canvas(pictureRecorder);
    var paint = Paint();
    paint.isAntiAlias = true;

    _drawCanvas(size, canvas).save();

    var pic = pictureRecorder.endRecording();
    ui.Image img = await pic.toImage(image.width, image.height);
    var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    var buffer = byteData!.buffer.asUint8List();

    // var response = await get(imgUrl);
    var documentDirectory = await getApplicationDocumentsDirectory();
    File file = File(join(documentDirectory.path,
        '${DateTime.now().toUtc().toIso8601String()}.png'));
    file.writeAsBytesSync(buffer);
    try {
      GallerySaver.saveImage(file.path, albumName: "Media");
      print("Uploaded");
    } catch (e) {
      print("Error");
    }

    print(file.path);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
