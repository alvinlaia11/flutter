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
  double temperature = 0.0; // Suhu default, Anda dapat menggantinya sesuai data yang diterima.

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    result = "";
    fetchData(); // Panggil method untuk mengambil data cuaca.
  }

  Future<void> fetchData() async {
    final weatherData = await helper.getWeatherData("Medan"); // Ganti "Medan" dengan nama kota yang sesuai
    setState(() {
      result = weatherData;
      temperature = parseTemperature(weatherData);
    });
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

  double parseTemperature(String jsonData) {
    final data = json.decode(jsonData);
    final temp = data['main']['temp'];
    return temp.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final temperatureColor = getColorBasedOnTemperature(temperature);

    return Scaffold(
      appBar: AppBar(title: Text('Weather Data')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: 150,
                height: 150,
                color: temperatureColor,
                child: Center(
                  child: result.isEmpty
                      ? CircularProgressIndicator()
                      : Text(
                          '$temperature °C', // Menampilkan suhu dalam kotak.
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              SizedBox(height: 20), // Spasi antara dua bagian tampilan
              Text(
                'Medan', // Menampilkan nama kota.
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
