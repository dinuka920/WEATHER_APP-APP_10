import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_weather_page.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/weather_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherServices _weatherServices = WeatherServices(
    apiKey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? "",
  );

  WeatherModel? _weather;
  // methode to fetch the weather
  void fetchWeather() async {
    try {
      final weather = await _weatherServices
          .getWeatherDataFromCurrentLocation();
      setState(() {
        _weather = weather;
      });
    } catch (error) {
      print("Error from the weather data: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Easy Weather",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.light_mode))],
      ),
      body: _weather != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeatherDisplay(weather: _weather!),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchWeatherPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(107, 255, 208, 128),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "search weather",
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
