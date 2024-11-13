import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/my_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async{
      emit(WeatherLoading());
      try {
        WeatherFactory wf = WeatherFactory(My_New_Api, language: Language.ENGLISH);

        //We are getting the current location of the phone
        //Position position = await Geolocator.getCurrentPosition();
        // ignore: avoid_print
        print('Fetching weather for position: ${event.position.latitude}, ${event.position.longitude}');
        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude);
        print('Weather data: ${weather.temperature}°C'); // Print the weather data
        emit(WeatherSuccess(weather));
        
      } catch (e) 
      {
        print('Error fetching weather: $e'); // Print any errors that occur
        emit(WeatherFailure());
      }
    });
  }
}
