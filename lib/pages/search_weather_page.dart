import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/weather_display.dart';

class SearchWeatherPage extends StatefulWidget {
  const SearchWeatherPage({super.key});

  @override
  State<SearchWeatherPage> createState() => _SearchWeatherPageState();
}

class _SearchWeatherPageState extends State<SearchWeatherPage> {
  final WeatherServices _weatherServices = WeatherServices(
    apiKey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? "",
  );

  WeatherModel? _weather;
  String? _error;
  final TextEditingController _controller = TextEditingController();

  void _searchWeather() async {
    final city = _controller.text.trim();

    if (city.isEmpty) {
      setState(() {
        _error = "Pleace Enter  City Name";
      });
      return;
    } else {
      try {
        final weather = await _weatherServices.getWeatherDataFromCityName(city);
        setState(() {
          _weather = weather;
          _error = null;
        });
      } catch (error) {
        _error = "Could not find weather data for $city";
        print("Error:${error.toString()}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Serch Weather")),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "City Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _searchWeather,
                    icon: Icon(Icons.light_mode),
                  ),
                ),
                onSubmitted: (value) => _searchWeather(),
              ),
              const SizedBox(height: 15),
              _error != null
                  ? Text(_error!, style: TextStyle(color: Colors.red))
                  : _weather != null
                  ? WeatherDisplay(weather: _weather!)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
