import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(
    firstText: 'First Text',
    secontText: 'Second Text',
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.firstText, required this.secontText});

  final String firstText;
  final String secontText;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
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
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Text(
                    'Top Container',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
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
                    child: Text(firstText),
                  ),

                  //second container
                  Container(
                    height: 50.0,
                    width: 140.0,
                    color: Colors.blue,
                    child: Text(secontText),
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
