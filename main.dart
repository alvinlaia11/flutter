import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {
  final String apiKey;

  HttpHelper(this.apiKey);

  Future<String> getWeatherData(String cityName) async {
    final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
    final Uri uri = Uri.parse('$baseUrl?q=$cityName&appid=$apiKey');

    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body; // Ini akan berisi data cuaca dalam format JSON.
    } else {
      throw Exception('Gagal mengambil data cuaca');
    }
  }
}

void main() async {
  String apiKey = "YOUR_API_KEY"; // Ganti dengan kunci API OpenWeather Anda
  String cityName = "Medan"; // Ganti dengan nama kota yang Anda inginkan

  HttpHelper helper = HttpHelper(apiKey);
  String weatherData = await helper.getWeatherData(cityName);

  print("Data Cuaca untuk $cityName:\n$weatherData");
}
