import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Layout'),
        ),
        body: Column(
          children: [
            //top container
            Center(
              child: Container(
                height: 170.0,
                width: 320.0,
                color: Colors.blue,
              ),
            ),

            //first row
            Padding(
              padding: const EdgeInsets.fromLTRB(35.0, 35.0, 35.0, 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //first container
                  Container(
                    height: 50.0,
                    width: 140.0,
                    color: Colors.blue,
                  ),

                  //second container
                  Container(
                    height: 50.0,
                    width: 140.0,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),

            //second row
            Padding(
              padding: const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //first container
                  Container(
                    height: 50.0,
                    width: 140.0,
                    color: Colors.blue,
                  ),

                  //second container
                  Container(
                    height: 50.0,
                    width: 140.0,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),

            //third row
            Padding(
              padding: const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //first container
                  Container(
                    height: 280.0,
                    width: 140.0,
                    color: Colors.blue,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //second container
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          height: 140.0,
                          width: 140.0,
                          color: Colors.blue,
                        ),
                      ),

                      //third container
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          height: 100.0,
                          width: 140.0,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
