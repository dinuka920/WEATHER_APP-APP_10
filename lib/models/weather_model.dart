class WeatherModel {
  final String cityName;
  final String description;
  final String condition;
  final double temperature;
  final double pressure;
  final double humidity;
  final double windSpeed;

  WeatherModel({
    required this.cityName,
    required this.description,
    required this.condition,
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
  });

  // methode to convert the JSON data to weather object
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
   return WeatherModel(
      cityName: json["name"],
      description: json["weather"][0]["description"],
      condition: json["weather"][0]["main"],
      temperature: json["main"]["temp"].toDouble(),
      pressure: json["main"]["pressure"].toDouble(),
      humidity: json["main"]["humidity"].toDouble(),
      windSpeed: json["wind"]["speed"].toDouble(),
    );
  }
}
