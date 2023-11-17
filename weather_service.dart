import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';

import 'package:http/http.dart' as http;

class Weatherservice{


  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';

  final String apikey;

  Weatherservice(this.apikey);

  Future<Weather> getWeather(String cityname) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityname&appid=$apikey&units=metric'));
  
    if(response.statusCode ==200){
      return Weather.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to fetch weather data');

    }
  
  }

  Future<String> getcurrentcity() async{

    LocationPermission permission =await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();

    }

    //fetch currennt loc
    Position position=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
    
    // converting location intpo list of placemark objects
    List<Placemark> placemarks=
          await placemarkFromCoordinates(position.latitude, position.longitude);
  


  //exracting city name from first place mark

  String? city = placemarks[0].locality;

  return city?? "";
}
}


