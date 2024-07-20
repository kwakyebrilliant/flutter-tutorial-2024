import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/Week_Screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variable
  Map<String, dynamic>? data;
  List<dynamic>? hourlyTimes;
  List<dynamic>? hourlyTemperatures;
  List<dynamic>? hourlyHumidities;
  String? timezone;
  String? greeting;
  String? formattedDate;
  String? formattedTime;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // fetchData function to make HTTP GET request to the provided API
  void fetchData() async {
    // Convert URL string to Uri object
    Uri url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,relative_humidity_2m&hourly=temperature_2m,relative_humidity_2m');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        hourlyTimes = data!['hourly']['time'].sublist(0, 24);
        hourlyTemperatures = data!['hourly']['temperature_2m'].sublist(0, 24);
        hourlyHumidities =
            data!['hourly']['relative_humidity_2m'].sublist(0, 24);
        timezone = data!['timezone'];

        // Determine the greeting and format the date and time
        DateTime currentTime = DateTime.parse(data!['current']['time']);
        int currentHour = currentTime.hour;
        if (currentHour < 12) {
          greeting = 'Good Morning';
        } else if (currentHour < 17) {
          greeting = 'Good Afternoon';
        } else {
          greeting = 'Good Evening';
        }

        // Formatted date
        formattedDate = DateFormat('EEEE d').format(currentTime);

        // Formatted time
        formattedTime = DateFormat('h:mm a').format(currentTime);
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  // Function to create gradient text for hourly forecast text
  Widget gradientText(String text, double fontSize, FontWeight fontWeight) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFFFA500), Color(0xFFFFFFFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: GoogleFonts.openSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data == null
          // Container serving as background to container containing circularprogressindicator
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFFA500),
                    const Color(0xFF8A2BE2).withOpacity(0.6),
                    const Color(0xFF000000),
                  ],
                ),
              ),
              // Container containing circularprogressindicator centered
              child: Center(
                // Container containing circularprogressindicator
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: const CircularProgressIndicator(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            )

          // Container for all contents
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFFA500),
                    const Color(0xFF8A2BE2).withOpacity(0.6),
                    const Color(0xFF000000),
                  ],
                ),
              ),

              // Padding around contents
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 60.0, left: 16.0, right: 16.0),

                // Column starts here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Timezone, greet and more icon in a container wrapped in a row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Timezone and greet in a richtext
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.openSans(
                              height: 1.1,
                            ),
                            children: <TextSpan>[
                              // Timezone in a textspan
                              TextSpan(
                                text: '$timezone \n',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w100,
                                  color:
                                      const Color(0xFFFFFFFF).withOpacity(0.7),
                                ),
                              ),

                              // greet in a textspan
                              TextSpan(
                                text: '$greeting',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Conatiner for more icon in a GestureDetector
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const WeekScreen(),
                              ),
                            );
                          },

                          // Conatiner for more icon
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                width: 0.4,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                            child: const Icon(
                              Icons.more_vert_outlined,
                              color: Color(0xFFFFFFFF),
                            ),
                            // More icon
                          ),
                        ),
                      ],
                    ),

                    // Container for image in a padding
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),

                      // Container for image
                      child: Container(
                        height: 300.0,
                        width: 300.0,
                        decoration: const BoxDecoration(
                          // Image here
                          image: DecorationImage(
                            image: AssetImage("assets/images/image.png"),
                          ),
                        ),
                      ),
                    ),

                    // Temperature, humidity, date and time in a richtext wrapped in padding
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),

                      // Temperature, humidity, date and time in a richtext
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.openSans(
                            height: 1.2,
                          ),
                          children: <TextSpan>[
                            // Temperature in a textspan
                            TextSpan(
                              text:
                                  '${data!['current']['temperature_2m'].toString().substring(0, 2)}°C \n',
                              style: const TextStyle(
                                fontSize: 75.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),

                            // Humidity in a textspan
                            TextSpan(
                              text:
                                  'Humidity ${data!['current']['relative_humidity_2m']}% \n',
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),

                            // current date and time in a textspan
                            TextSpan(
                              text: '$formattedDate . $formattedTime',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: const Color(0xFFFFFFFF).withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Hourly forecast text and keyboard arrow down icon in a container wrapped in a padding
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),

                      // Hourly forecast text and keyboard arrow down icon in a container
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Hourly forecast text
                          gradientText(
                            'Hourly Forecast',
                            20.0,
                            FontWeight.bold,
                          ),

                          // Container for keyboard arrow down
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(100.0),
                            ),

                            // keyboard arrow down icon
                            child: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Expanded
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0.0),
                        itemCount: hourlyTimes?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Container(
                            padding:
                                const EdgeInsets.only(bottom: 12.0, top: 5.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 0.4,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),

                            // Hour, Humidity and temperature using text in a row
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Hour
                                Text(
                                  DateFormat('h a').format(
                                      DateTime.parse(hourlyTimes![index])),
                                  style: GoogleFonts.openSans(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),

                                // Column for humidity
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Humidity Text
                                    Text(
                                      'Humidity',
                                      style: GoogleFonts.openSans(
                                        fontSize: 14.0,
                                        color: const Color(0xFFFFFFFF)
                                            .withOpacity(0.7),
                                      ),
                                    ),

                                    // Humidity value
                                    Text(
                                      '${hourlyHumidities![index].toString()}%',
                                      style: GoogleFonts.openSans(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ],
                                ),

                                // Tmeperature
                                Text(
                                  '${hourlyTemperatures![index].toString()}°C',
                                  style: GoogleFonts.openSans(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                // Column ends here
              ),
            ),
    );
  }
}
