import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:camera/camera.dart';
import 'package:qr/DisplayOcr.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as imglib;

class object extends StatefulWidget {
  const object({
    Key? key,
    required this.camera,
  }) : super(key: key);
  final CameraDescription camera;

  @override
  _objectState createState() => _objectState();
}

class _objectState extends State<object> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List _outputs = [1];
  List _outputs1 = [1];
  List _outputs2 = [1];
  List _outputs3 = [1];
  List _outputs4 = [1];
  List _outputs5 = [1];
  List _outputs6 = [1];
  List _outputs7 = [1];

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  var avg;
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      // model: "assets/ssd_mobilenet_v1_1_metadata_1.tflite",
      labels: "assets/label_map.pbtxt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    print("Ocr started");

    var output = await Tflite.detectObjectOnImage(
        path: image.path, // required
        model: "ssd_mobilenet_v1_1_metadata_1",
        // ssd_mobilenet_v2_fpnlite_640x640_coco17_tpu-8
        // imageMean: 127.5,
        // imageStd: 127.5,
        // threshold: 0.4, // defaults to 0.1
        // numResultsPerClass: 2, // defaults to 5
        // imageMean: 0.0,
        // imageStd: 255.0,
        // numResults: 10,
        
        threshold: 0.3,
        asynch: true // defaults to true
        );
    print("ResultOne");
    print(output);

    return output;
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    Tflite.close();
    _controller.dispose();
    super.dispose();
  }

//To find the coordinates of the place we touch
  double posx = 100.0;
  double posy = 100.0;

  void onTapDown(BuildContext context, TapDownDetails details) async {
    print('${details.globalPosition}');
    CircularProgressIndicator();
    final RenderBox box = context.findRenderObject() as RenderBox;
    // final RenderBox renderBox = context.currentContext!
    //                                          .findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
    });
    print("x:" + posx.toString());
    print("y:" + posy.toString());

    final image = await _controller.takePicture();

    print("path:" + image.path);
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(image.path);
    print("width" + properties.width.toString());
    print("height" + properties.height.toString());
    // File output = await FlutterNativeImage.cropImage(
    //     image.path, 0, 0, properties.width!, properties.height!);
    var bytes = await File(image.path).readAsBytes();
    imglib.Image? src = imglib.decodeImage(bytes);
    int x = posy.toInt() + 90;
    posy = posy - 40;
// See This Line Once
//40-100

    var split;
    try {
      split = imglib.copyCrop(src!, 0, posy.toInt(), properties.width!, 80);
      
      var jpg = imglib.encodeJpg(split);
      await File(image.path).writeAsBytes(jpg);
      var recognition = await Tflite.detectObjectOnImage(
          path: image.path, // required
          model: "SSDMobileNet",
          threshold: 0.1, // defaults to 0.1
          numResultsPerClass: 2, // defaults to 5
          asynch: true // defaults to true
          );
          print(recognition);
      print("Splitted");
    } catch (e) {
      print("Not splitted" + e.toString());
    }
//Main spilted image is in image.path

    ImageProperties properties1 =
        await FlutterNativeImage.getImageProperties(image.path);

    final int xLength = (properties1.width! / 8).round();
    final int yLength = (properties1.height!).round();
    print("width" + properties1.width.toString());
    print("height" + properties1.height.toString());
    print("xlength" + xLength.toString());
    print("ylength" + yLength.toString());

    File output1 = await FlutterNativeImage.cropImage(
        image.path, 0, 0, properties1.width!, properties1.height!);

    File output2 = await FlutterNativeImage.cropImage(
        image.path, 0, 0, properties1.width!, properties1.height!);

    File output3 = await FlutterNativeImage.cropImage(
        image.path, 0, 0, properties1.width!, properties1.height!);

    File output4 = await FlutterNativeImage.cropImage(
        image.path, 0, 0, properties1.width!, properties1.height!);

    File output5 = await FlutterNativeImage.cropImage(
        image.path, 0, 0, properties1.width!, properties1.height!);

    File output6 = await FlutterNativeImage.cropImage(
        image.path, 0, 0, properties1.width!, properties1.height!);

    File output7 = await FlutterNativeImage.cropImage(
        image.path, 0, 0, properties1.width!, properties1.height!);

    File output8 = await FlutterNativeImage.cropImage(
        image.path, 0, 0, properties1.width!, properties1.height!);
    int y = 0;
    print("List created");
    var bytes1 = await File(image.path).readAsBytes();
    imglib.Image? src1 = imglib.decodeImage(bytes1);
    for (int i = 0; i < 8; i++) {
      // print("path testing:" + output.path);
      var split1;
      try {
        split1 = imglib.copyCrop(src1!, y, 0, xLength, yLength);
        y = y + xLength;
        print("Splitted");
      } catch (e) {
        print("Not splitted" + e.toString());
      }

      var jpg = imglib.encodeJpg(split1);
      print("cropping executed");
      if (i == 0) await File(output1.path).writeAsBytes(jpg);

      if (i == 1) await File(output2.path).writeAsBytes(jpg);

      if (i == 2) await File(output3.path).writeAsBytes(jpg);

      if (i == 3) await File(output4.path).writeAsBytes(jpg);

      if (i == 4) await File(output5.path).writeAsBytes(jpg);

      if (i == 5) await File(output6.path).writeAsBytes(jpg);

      if (i == 6) await File(output7.path).writeAsBytes(jpg);

      if (i == 7) await File(output8.path).writeAsBytes(jpg);
    }
    //Tflite Model
    _outputs = await classifyImage(output1);
    _outputs1 = await classifyImage(output2);
    _outputs2 = await classifyImage(output3);
    _outputs3 = await classifyImage(output4);
    _outputs4 = await classifyImage(output5);
    _outputs5 = await classifyImage(output6);
    _outputs6 = await classifyImage(output7);
    _outputs7 = await classifyImage(output8);
    // //ends here

    GallerySaver.saveImage(image.path, albumName: "Media");

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Display1Pic(
          imagePath: image.path,
          imagePath1: output1.path,
          imagePath2: output2.path,
          imagePath3: output3.path,
          imagePath4: output4.path,
          imagePath5: output5.path,
          imagePath6: output6.path,
          imagePath7: output7.path,
          imagePath8: output8.path,
          outputs: _outputs,
          outputs1: _outputs1,
          outputs2: _outputs2,
          outputs3: _outputs3,
          outputs4: _outputs4,
          outputs5: _outputs5,
          outputs6: _outputs6,
          outputs7: _outputs7,
        ),
      ),
    );
  }

//Ends Here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cropping"),
      ),
      // bottomNavigationBar: Image.asset("assets/new1.jpeg"),
      body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GestureDetector(
                onTapDown: (TapDownDetails details) =>
                    onTapDown(context, details),
                child: Stack(fit: StackFit.expand, children: [
                  CameraPreview(_controller),
                  // cameraOverlay(
                  //     padding: 0, aspectRatio: 50, color: Colors.white)
                ]),
              );
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String imagePath1;
  final String imagePath2;
  final String imagePath3;
  final String imagePath4;
  final String imagePath5;
  final String imagePath6;
  final String imagePath7;
  final String imagePath8;
  

  DisplayPictureScreen({
    Key? key,
    required this.imagePath,
    required this.imagePath1,
    required this.imagePath2,
    required this.imagePath3,
    required this.imagePath4,
    required this.imagePath5,
    required this.imagePath6,
    required this.imagePath7,
    required this.imagePath8,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Image.file(File(imagePath)),
          Padding(padding: EdgeInsets.all(10)),
          Expanded(
            child: GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 4,
              children: <Widget>[
                Image.file(
                  File(imagePath1),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(imagePath2),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(imagePath3),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(imagePath4),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(imagePath5),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(imagePath6),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(imagePath7),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(imagePath8),
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: Wrap(
          //     children: [
          //       outputs != null
          //           ? Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text(
          //                   outputs![0]["label"],
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   "Con:",
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   outputs![0]["confidence"].toString(),
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //               ],
          //             )
          //           : Container(child: Text("")),
          //       outputs1 != null
          //           ? Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text(
          //                   outputs1![0]["label"],
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   "Con:",
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   outputs1![0]["confidence"].toString(),
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //               ],
          //             )
          //           : Container(child: Text("")),
          //       outputs2 != null
          //           ? Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text(
          //                   outputs2![0]["label"],
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   "Con:",
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   outputs2![0]["confidence"].toString(),
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //               ],
          //             )
          //           : Container(child: Text("")),
          //       outputs3 != null
          //           ? Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text(
          //                   outputs3![0]["label"],
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   "Con:",
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   outputs3![0]["confidence"].toString(),
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //               ],
          //             )
          //           : Container(child: Text("")),
          //       outputs4 != null
          //           ? Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text(
          //                   outputs4![0]["label"],
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   "Con:",
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   outputs4![0]["confidence"].toString(),
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //               ],
          //             )
          //           : Container(child: Text("")),
          //       outputs5 != null
          //           ? Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text(
          //                   outputs5![0]["label"],
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   "Con:",
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   outputs5![0]["confidence"].toString(),
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //               ],
          //             )
          //           : Container(child: Text("")),
          //       outputs6 != null
          //           ? Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text(
          //                   outputs6![0]["label"],
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   "Con:",
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   outputs6![0]["confidence"].toString(),
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //               ],
          //             )
          //           : Container(child: Text("")),
          //       outputs7 != null
          //           ? Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text(
          //                   outputs7![0]["label"],
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   "Con:",
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //                 Text(
          //                   outputs7![0]["confidence"].toString(),
          //                   style: TextStyle(color: Colors.black, fontSize: 20),
          //                 ),
          //               ],
          //             )
          //           : Container(child: Text("")),
          //     ],
          //   ),
          // ),
          // outputs != null
          //     ? Text(
          //         "Atsuya",
          //         style: TextStyle(color: Colors.black, fontSize: 20),
          //       )
          //     : Container(child: Text("Atsuya"))
        ],
      ),
    );
  }
}
