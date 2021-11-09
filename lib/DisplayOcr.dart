import 'dart:io';

import 'package:flutter/material.dart';

class Display1Pic extends StatelessWidget {
  final String imagePath;
  final String imagePath1;
  final String imagePath2;
  final String imagePath3;
  final String imagePath4;
  final String imagePath5;
  final String imagePath6;
  final String imagePath7;
  final String imagePath8;
  final gocr;
  final gocr1;
  final gocr2;
  final gocr3;
  final gocr4;
  final gocr5;
  final gocr6;
  final gocr7;
  final gocr8;
  List? outputs;
  List? outputs1;
  List? outputs2;
  List? outputs3;
  List? outputs4;
  List? outputs5;
  List? outputs6;
  List? outputs7;
  
  Display1Pic({
    Key? key,
    required this.imagePath,
    this.gocr,
    this.gocr1,
    this.gocr2,
    this.gocr3,
    this.gocr4,
    this.gocr5,
    this.gocr6,
    this.gocr7,
    this.gocr8,
    required this.imagePath1,
    required this.imagePath2,
    required this.imagePath3,
    required this.imagePath4,
    required this.imagePath5,
    required this.imagePath6,
    required this.imagePath7,
    required this.imagePath8,
    required this.outputs,
    required this.outputs1,
    required this.outputs2,
    required this.outputs3,
    required this.outputs4,
    required this.outputs5,
    required this.outputs6,
    required this.outputs7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.file(File(imagePath)),
          ), Text("Text with total image"+gocr),
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
          Expanded(
            child: Wrap(
              children: [
                outputs != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            outputs![0]["label"],
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "Con:",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            outputs![0]["confidence"].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      )
                    : Container(child: Text("")),
                outputs1 != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            outputs1![0]["label"],
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "Con:",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            outputs1![0]["confidence"].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      )
                    : Container(child: Text("")),
                outputs2 != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            outputs2![0]["label"],
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "Con:",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            outputs2![0]["confidence"].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      )
                    : Container(child: Text("")),
                outputs3 != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            outputs3![0]["label"],
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "Con:",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            outputs3![0]["confidence"].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      )
                    : Container(child: Text("")),
                outputs4 != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            outputs4![0]["label"],
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "Con:",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            outputs4![0]["confidence"].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      )
                    : Container(child: Text("")),
                outputs5 != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            outputs5![0]["label"],
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "Con:",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            outputs5![0]["confidence"].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      )
                    : Container(child: Text("")),
                outputs6 != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            outputs6![0]["label"],
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "Con:",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            outputs6![0]["confidence"].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      )
                    : Container(child: Text("")),
                outputs7 != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            outputs7![0]["label"],
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "Con:",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            outputs7![0]["confidence"].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      )
                    : Container(child: Text("")),
              ],
            ),
          ),
          Expanded(child: Row(
            children: [
              Text("Divided Images:"),
              (gocr1!="")?Text(gocr1):Text("no"),
              (gocr2!="")?Text(gocr2):Text("no"),
              (gocr3!="")?Text(gocr3):Text("no"),
              (gocr4!="")?Text(gocr4):Text("no"),
              (gocr5!="")?Text(gocr5):Text("no"),
              (gocr6!="")?Text(gocr6):Text("no"),
              (gocr7!="")?Text(gocr7):Text("no"),
              (gocr8!="")?Text(gocr8):Text("no"),
            ],
          )),
          
          ],
        
      ),
    );
  }
}
