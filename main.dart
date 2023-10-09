import 'package:basic/components/htpHelper.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late String result;
  late HttpHelper helper;

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    result = "";
    fetchData(); // Panggil method untuk mengambil data cuaca.
  }

  Future<void> fetchData() async {
    final weatherData = await helper.getWeatherData("NamaKota");
    setState(() {
      result = weatherData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather Data')),
      body: SingleChildScrollView(
        child: Center(
          child: result.isEmpty
              ? CircularProgressIndicator() // Tampilkan loading jika result masih kosong
              : Text(result), // Tampilkan data cuaca jika sudah tersedia
        ),
      ),
    );
  }
}
https://api.openweathermap.org/data/2.5/weather?q=Medan&appid=YOUR_API_KEY

https://api.openweathermap.org/data/2.5/weather?q=nama-kota&appid=YOUR_API_KEY
