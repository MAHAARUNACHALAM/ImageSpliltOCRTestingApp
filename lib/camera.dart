import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image/image.dart' as IMG;

final albumName = 'Media';

Future cropSquare(String srcFilePath, String destFilePath, bool flip) async {
  var bytes = await File(srcFilePath).readAsBytes();
  IMG.Image? src = IMG.decodeImage(bytes);
  print("Height" + src!.height.toString());
  print("width" + src.width.toString());

  var cropSize = min(src.width, src.height);
  int offsetX = (src.width - min(src.width, src.height)) ~/ 2;
  int offsetY = (src.height - min(src.width, src.height)) ~/ 2;
  print("X:" + offsetX.toString());
  print("Y:" + offsetY.toString());

  IMG.Image destImage =
      IMG.copyCrop(src, offsetX, offsetY, src.height, src.width);

  // if (flip) {
  //   destImage = IMG.flipVertical(destImage);
  // }

  var jpg = IMG.encodeJpg(destImage);
  await File(destFilePath).writeAsBytes(jpg);
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            // return CameraPreview(_controller);
            return Stack(fit: StackFit.expand, children: [
              CameraPreview(_controller),
              cameraOverlay(
                  padding: 10, aspectRatio: 6, color: Color(0x55000000))
            ]);
            // Color(0x55000000)
            // return Container(
            //   alignment: Alignment.center,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            // CustomPaint(
            //   foregroundPainter: OutlinePainter(),
            //   child: CameraPreview(_controller),
            // ),
            //     ],
            //   ),
            // );
            // return Container(
            //   width: size,
            //   height: size,
            //   child: ClipRect(
            //     child: OverflowBox(
            //       alignment: Alignment.center,
            //       child: FittedBox(
            //         fit: BoxFit.fitWidth,
            //         child: Container(
            //           width: size,
            //           height: 70,
            //           //  size / _controller.value.aspectRatio,
            //           //  widget.cameraController.value.aspectRatio,
            //           child: CameraPreview(
            //               _controller), // this is my CameraPreview
            //         ),
            //       ),
            //     ),
            //   ),
            // );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
            GallerySaver.saveImage(image.path, albumName: albumName);

            File imageFile = File(image.path);
            await cropSquare(imageFile.path, image.path, false);

            // IMG.copyCrop(image, 0, 0, 200, 90);
            // _imageFile = await _resizePhoto(image.path);
            // print("Image Propertiesstarted");
            // ImageProperties properties =
            //     await FlutterNativeImage.getImageProperties(image.path);
            // print("Image Properties completed");

            // int? width = properties.width;
            // int? height = properties.height;
            // print("width:" + width.toString());
            // print("height:" + height.toString());
            // var offset;
            // if (properties.height! > properties.width!) {
            //   offset = (properties.height! - properties.width!) / 2;
            // } else {
            //   offset = (-properties.height! + properties.width!) / 2;
            // }

            // print("Offset:" + offset.toString());

            // File croppedFile =
            //     await FlutterNativeImage.cropImage(image.path, 0, 0, 0, 330);

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // GallerySaver.saveImage(image!.path, albumName: albumName);
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                  imagePath1: imageFile.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Widget cameraOverlay({double? padding, double? aspectRatio, Color? color}) {
    return LayoutBuilder(builder: (context, constraints) {
      double parentAspectRatio = constraints.maxWidth / constraints.maxHeight;
      double horizontalPadding;
      double verticalPadding;

      if (parentAspectRatio < aspectRatio!) {
        horizontalPadding = padding!;
        verticalPadding = (constraints.maxHeight -
                ((constraints.maxWidth - 2 * padding) / aspectRatio)) /
            2;
      } else {
        verticalPadding = padding!;
        horizontalPadding = (constraints.maxWidth -
                ((constraints.maxHeight - 2 * padding) * aspectRatio)) /
            2;
      }
      return Stack(fit: StackFit.expand, children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Container(width: horizontalPadding, color: color)),
        Align(
            alignment: Alignment.centerRight,
            child: Container(width: horizontalPadding, color: color)),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: color)),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: color)),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.orange, style: BorderStyle.solid, width: 5),
          ),
        )
      ]);
    });
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String imagePath1;

  const DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.imagePath1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(File(imagePath)),
            Padding(padding: EdgeInsets.all(10)),
            Image.file(File(imagePath1)),
          ],
        ),
      ),
    );
  }
}

class OutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.orange;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(10, 20, 325, 50), Radius.circular(0)),
      paint,
    );
  }

  @override
  bool shouldRepaint(OutlinePainter oldDelegate) => false;
}
