import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/get_location_service.dart';

class WeatherServices {
  // https://api.openweathermap.org/data/2.5/weather?q=London&appid=5847cdd2ed710d89acc48a13162bc49f&units=metric

  final String apiKey;

  WeatherServices({required this.apiKey});

  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";

  // methode to get a weather data from the city name
  Future<WeatherModel> getWeatherDataFromCityName(String cityName) async {
    try {
      final String url = "$BASE_URL?q=$cityName&appid=$apiKey&units=metric";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return WeatherModel.fromJson(json);
      } else {
        throw Exception("Faild to load the weather Data");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Faild to load the weather Data");
    }
  }

  // methode to get a weather data from the currnt location
  Future<WeatherModel> getWeatherDataFromCurrentLocation() async {
    final location = GetLocationService();
    final cityName = location.getCityNameFromCurrentlocation();

    try {
      final url = "$BASE_URL?q=$cityName&appid=$apiKey&units=metric";
      final responce = await http.get(Uri.parse(url));

      if (responce.statusCode == 200) {
        final json = jsonDecode(responce.body);
        return WeatherModel.fromJson(json);
      } else {
        throw Exception("Faild to load the weather Data");
      }
    } catch (error) {
      print(error.toString());
      throw Exception("Faild to load the weather Data");
    }
  }
}
