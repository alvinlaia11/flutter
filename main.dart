import 'dart:convert';

import 'package:basic/components/htpHelper.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late HttpHelper helper;
  String resultMedan = "";
  String resultJakarta = "";
  double temperatureMedan = 0.0;
  double temperatureJakarta = 0.0;

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    fetchData(); // Panggil method untuk mengambil data cuaca.
  }

  Future<void> fetchData() async {
    final weatherDataMedan =
        await helper.getWeatherData("Medan");
    final weatherDataJakarta =
        await helper.getWeatherData("Jakarta");

    setState(() {
      resultMedan = weatherDataMedan;
      resultJakarta = weatherDataJakarta;

      temperatureMedan = parseTemperature(resultMedan);
      temperatureJakarta = parseTemperature(resultJakarta);
    });
  }

  double parseTemperature(String jsonData) {
    final data = json.decode(jsonData);
    final temp = data['main']['temp'];
    return temp.toDouble();
  }

  Color getColorBasedOnTemperature(double temperature) {
    if (temperature < 20) {
      return Colors.green; // Suhu rendah, warna hijau.
    } else if (temperature >= 20 && temperature < 30) {
      return Colors.yellow; // Suhu sedang, warna kuning.
    } else {
      return Colors.red; // Suhu tinggi, warna merah.
    }
  }

  @override
  Widget build(BuildContext context) {
    final temperatureColorMedan = getColorBasedOnTemperature(temperatureMedan);
    final temperatureColorJakarta =
        getColorBasedOnTemperature(temperatureJakarta);

    return Scaffold(
      appBar: AppBar(title: Text('Weather Data')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              color: temperatureColorMedan,
              child: Center(
                child: resultMedan.isEmpty
                    ? CircularProgressIndicator()
                    : Text(
                        '$temperatureMedan °C',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
            SizedBox(height: 20), // Spasi antara dua kota
            Container(
              width: 100,
              height: 100,
              color: temperatureColorJakarta,
              child: Center(
                child: resultJakarta.isEmpty
                    ? CircularProgressIndicator()
                    : Text(
                        '$temperatureJakarta °C',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
