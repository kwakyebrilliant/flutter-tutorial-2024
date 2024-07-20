import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WeekScreen extends StatefulWidget {
  const WeekScreen({super.key});

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  // variables
  Map<String, dynamic>? data;
  List<dynamic>? dailyTemperatures;
  List<dynamic>? dailyDates;
  List<dynamic>? dailyWeatherCodes;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // fetchData function to make HTTP GET request to the provided API
  void fetchData() async {
    // Convert URL string to Uri object
    Uri url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&daily=temperature_2m_max,weathercode');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        dailyTemperatures = data!['daily']['temperature_2m_max'];
        dailyDates = data!['daily']['time'];
        dailyWeatherCodes = data!['daily']['weathercode'];
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  // Weather condition variables using switch statements
  String getWeatherDescription(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return 'Clear';
      case 1:
      case 2:
      case 3:
        return 'Partly Cloudy';
      case 45:
      case 48:
        return 'Fog';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 56:
      case 57:
        return 'Freezing Drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rain';
      case 66:
      case 67:
        return 'Freezing Rain';
      case 71:
      case 73:
      case 75:
        return 'Snow';
      case 77:
        return 'Snow Grains';
      case 80:
      case 81:
      case 82:
        return 'Showers';
      case 85:
      case 86:
        return 'Snow Showers';
      case 95:
        return 'Thunderstorm';
      case 96:
      case 99:
        return 'Thunderstorm with Hail';
      default:
        return 'Unknown';
    }
  }

  // Function to navigate back
  void navigateBackFunction() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data == null
          // Container serving as background to container containing circularprogressindicator
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF4B0082),
                    Color(0xFF9370DB),
                    Color(0xFF000000),
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

          // Container for contents
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF4B0082),
                    Color(0xFF9370DB),
                    Color(0xFF000000),
                  ],
                ),
              ),

              // Padding around the contents
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 60.0, left: 16.0, right: 16.0),

                // Column starts here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Container for keyboard arrow left in GestureDetector
                            GestureDetector(
                              onTap: () {
                                navigateBackFunction();
                              },
                              // Container for keyboard arrow left
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(100.0),
                                ),

                                // Keyboard arrow left
                                child: const Icon(
                                  Icons.keyboard_arrow_left_outlined,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),

                            // Back text in a padding
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),

                              // Back text
                              child: Text(
                                'Back',
                                style: GoogleFonts.openSans(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Container for image
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: const BoxDecoration(
                            // Image here
                            image: DecorationImage(
                              image: AssetImage("assets/images/cloud.png"),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Row for calendar and this week text in a padding
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),

                      // Row for calendar and this week text
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Calendar icon
                          const Icon(
                            Icons.calendar_month_rounded,
                            color: Color(0xFFFFFFFF),
                            size: 30.0,
                          ),

                          // This week text in a padding
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),

                            // This week text
                            child: Text(
                              'This Week',
                              style: GoogleFonts.openSans(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Expanded
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0.0),
                        itemCount: dailyDates?.length ?? 0,
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

                            // Day, weather condition and temperature text
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Day text
                                Text(
                                  DateFormat('EEE').format(
                                      DateTime.parse(dailyDates![index])),
                                  style: GoogleFonts.openSans(
                                    fontSize: 14.0,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),

                                // Weather condition text
                                Text(
                                  getWeatherDescription(
                                      dailyWeatherCodes![index]),
                                  style: GoogleFonts.openSans(
                                    fontSize: 14.0,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),

                                // Temperature text
                                Text(
                                  '${dailyTemperatures![index].toString().substring(0, 2)}°C',
                                  style: GoogleFonts.openSans(
                                    fontSize: 65.0,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),

                //Column ends here
              ),
            ),
    );
  }
}
