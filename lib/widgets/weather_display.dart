import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/utils_function.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherModel weather;
  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Lottie.asset(
                UtilsFunction().getWeatherAnimation(
                  condition: weather.condition,
                ),
                width: 400,
                height: 400,
              ),
            ),
            Text(
              weather.cityName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 10),
            Text(
              "${weather.temperature.toStringAsFixed(1)}°C",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Text(
                  weather.condition,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  weather.description,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _biuldWeatherDetils("Pressure", "${weather.pressure} hPa"),
                _biuldWeatherDetils("Humidity", "${weather.humidity} %"),
                _biuldWeatherDetils("Wind Speed", "${weather.windSpeed} m/s"),
              ],
            ),
            SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }

  // preshar,hiumidity,windSpeed widget
  Widget _biuldWeatherDetils(String lable, String value) {
    return Column(
      children: [
        Text(lable, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
        ),
      ],
    );
  }
}
