import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final title = [
    'Current Level',
    'Raw Reading',
    'Tank Height',
    'Tank Width',
    'Tank Volume',
    'Last Updated',
  ];
  final value = [
    60,
    60,
    70,
    80,
    90,
    "12:00:00",
  ];
  String recievedText = "";

  void fetchData() async {
    debugPrint("Sending Request......");
    const String url =
        'https://datasquid.mantis360.co/pipe/3dp/1daa6088-434e-4b33-95f3-ae1d86bb45b6/extensions/dataline/ingestion/get_entity_data/ba280f92-6200-4cc1-94b0-92deb171b21d';

    // Define your headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
      // Add any other headers as needed
    };

    // Make the GET request with headers
    final response = await http.get(Uri.parse(url), headers: headers);

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response data
      var data = json.decode(response.body);
      print('Data: $data');
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: true,
        bottom: true,
        left: false,
        right: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "Mantis360",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: LiquidCircularProgressIndicator(
                      value: 0.6, // Defaults to 0.5.
                      valueColor:
                          const AlwaysStoppedAnimation(Colors.blueAccent),
                      backgroundColor: Colors.white,
                      borderColor: Colors.blue,
                      borderWidth: 5.0,
                      direction: Axis.vertical,
                      center: const Text(
                        "60%",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            title[0],
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${value[0]}",
                            style: const TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            title[1],
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${value[1]}",
                            style: const TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            title[2],
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${value[2]}",
                            style: const TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            title[3],
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${value[3]}",
                            style: const TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            title[4],
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${value[4]}",
                            style: const TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            title[5],
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${value[5]}",
                            style: const TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    fetchData();
                  },
                  child: const Text("Update"),
                ),
                Text(recievedText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
