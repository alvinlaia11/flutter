import 'package:http/http.dart' as http;

class HttpHelper {
  final String _apiKey =
      "439d4b804bc8187953eb36d2a8c26a02"; // Ganti dengan kunci API Anda
  final String _baseUrl =
      "https://openweathermap.org/data/2.5/weather?id=1214520&appid=439d4b804bc8187953eb36d2a8c26a02";
      
      

  Future<String> getWeatherData(String cityName) async {
    final Uri uri = Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey');
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body; // Ini akan berisi data cuaca dalam format JSON.
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
