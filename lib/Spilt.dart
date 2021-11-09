// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as imglib;

// List<Image> splitImage(List<int> input) {
//   // convert image to image from image package
//   imglib.Image? image = imglib.decodeImage(input);

//   int x = 0, y = 0;
//   int width = (image!.width / 3).round();
//   int height = (image.height / 3).round();

//   // split image to parts
//   // ignore: deprecated_member_use
//   List<imglib.Image> parts = List<imglib.Image>();
//   for (int i = 0; i < 3; i++) {
//     for (int j = 0; j < 3; j++) {
//       parts.add(imglib.copyCrop(image, x, y, width, height));
//       x += width;
//     }
//     x = 0;
//     y += height;
//   }

//   // convert image from image package to Image Widget to display
//   List<Image> output = List<Image>();
//   for (var img in parts) {
//     output.add(Image.memory(imglib.encodeJpg(img)));
//   }

//   return output;
// }

import 'dart:io';
import 'dart:typed_data';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;
import 'package:image_picker/image_picker.dart';

splitImage(
    {Image? inputImage, int? horizontalPieceCount, int? verticalPieceCount}) {
  imglib.Image image = inputImage as imglib.Image;

  final int xLength = (image.width / horizontalPieceCount!).round();
  final int yLength = (image.height / verticalPieceCount!).round();
  List<imglib.Image> pieceList = [];

  for (int y = 0; y < verticalPieceCount; y++)
    for (int x = 0; x < horizontalPieceCount; x++) {
      pieceList.add(
        imglib.copyCrop(image, x, y, x * xLength, y * yLength),
      );
    }

  //Convert image from image package to Image Widget to display
  // List<Image> outputImageList = [];
  // for (imglib.Image img in pieceList) {
  //   outputImageList.add(Image.memory(imglib.encodeJpg(img)));
  // }

  return pieceList;
}

class spilt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: image == null
                  ? Text('No image selected.')
                  : Image.file(image!),
            ),
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  getImage();
                },
                child: Text('Upload Image'),
              ),
              RaisedButton(
                onPressed: () {
                  splitImage(
                    inputImage: Image.asset("image.jpeg"),
                    horizontalPieceCount: 3,
                    verticalPieceCount: 3,
                  );
                },
                child: Text('Split Image'),
              )
            ],
          )
        ],
      ),
    );
  }
}
