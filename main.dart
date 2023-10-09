import 'package:http/http.dart' as http;
import 'dart:io';

class HttpHelper {
  final String _urlKey = "?api_key=e074f9ca65bc00321b22666bc51130c9";
  final String _urlBase = "https://api.openweathermap.org/data/2.5/weather?";
  Future<String> getMovie() async {
    var url = Uri.parse(_urlBase + '/3/movie/now_playing' + _urlKey);
    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    return result.statusCode.toString();
  }
}
