import 'package:http/http.dart' as http;

class HttpHelper {
  Future<String> getWeatherData(String apiKey, String cityId) async {
    final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
    final Uri uri = Uri.parse('$baseUrl?id=$cityId&appid=$apiKey');

    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body; // Ini akan berisi data cuaca dalam format JSON.
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}

void main() async {
  HttpHelper helper = HttpHelper();

  String apiKey1 = "API_KEY_1"; // Ganti dengan kunci API pertama
  String apiKey2 = "API_KEY_2"; // Ganti dengan kunci API kedua
  String cityId1 = "CITY_ID_1"; // Ganti dengan ID kota pertama
  String cityId2 = "CITY_ID_2"; // Ganti dengan ID kota kedua

  String weatherData1 = await helper.getWeatherData(apiKey1, cityId1);
  String weatherData2 = await helper.getWeatherData(apiKey2, cityId2);

  print("Weather Data for City 1: $weatherData1");
  print("Weather Data for City 2: $weatherData2");
}
