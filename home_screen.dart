import 'package:flutter/material.dart';
import 'package:weather_app_youtube/models/weather_model.dart';
import 'package:weather_app_youtube/services/weather_service.dart';
import 'package:lottie/lottie.dart';


class Weatherpage extends StatefulWidget{ 



  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<Weatherpage>{


//api key
final _weatherService = Weatherservice('06e67de3f0f51e9510e86c90aa9ba9b0');
Weather? _weather;

//fetch weather
_fetchWeather() async{

  // get current city

  String cityname=await _weatherService.getcurrentcity();

  // get weather for city
  try{

    final weather = await _weatherService.getWeather(cityname);
    setState((){
      _weather = weather;

    });
  }

  //any errors
  catch (e){
    print(e);

  }
}

// weather animations

String getWeatherAnimation(String ? maincondition){

  if(maincondition==null) return 'assets/sunny.json';  //by default
  
  switch(maincondition.toLowerCase()){

    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    
    case 'dust':
    case 'fog':
    return 'assets/cloud.json';
    case 'rain':
    case 'drizzle':
      return 'assets/rainy.json';
    case 'thunderstorm':
    return 'assets/thunder.json';
    case 'clear':
    
    return 'assets/sunny.json';
    default:
         return 'assets/sunny.json';


  }


}



//init state


  @override
  void initState(){
    super.initState();
    
  // fetch weather on startup
  _fetchWeather();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //city name
            Text(_weather?.cityname?? "loading city...."),

           //animation
           Lottie.asset(getWeatherAnimation(_weather?.maincondition)),
            //temperature
            Text('${_weather?.temperature.round()}C'),
           

           Text(_weather?.maincondition ?? "")
          ],
          ),
    ),
    );
  }
}