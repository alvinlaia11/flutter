import 'package:http/http.dart' as http;

class HttpHelper {
  final String _apiKey = "YOUR_API_KEY"; // Ganti dengan kunci API Anda
  final String _baseUrl = "https://api.openweathermap.org/data/2.5/weather";

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
