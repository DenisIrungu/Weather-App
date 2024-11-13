import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class HomeScreen extends StatelessWidget {
  Widget getWeatherIcon(int code){
  switch (code) {
    case >=200 && <300:
    return Image.asset(
      'lib/images/1.png');
    case >=300 && >400:
    return Image.asset(
      'lib/images/2.png');
    case >=500 && <600:
    return Image.asset(
      'lib/images/3.png');
    case >=600 && >700:
    return Image.asset(
      'lib/images/4.png');
    case >=700 && >800:
    return Image.asset(
      'lib/images/5.png');
    case ==800:
    return Image.asset(
      'lib/images/6.png');
    case >=800 && >804:
    return Image.asset(
      'lib/images/7.png');
    default:
    return Image.asset('lib/images/7.png');
  }
}
// Function to get a greeting based on the time of day
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night'; // Late night or early morning
    }
  }


  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0XFF673AB7)),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(color: Color(0XFFFFAB40)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherSuccess){

                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Location
                         Text(
                          '${state.weather.areaName}, Kenya',
                          style:const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          getGreeting(),
                          style:const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        getWeatherIcon(state.weather.weatherConditionCode!),
                        //Weather Icon
                        //Image.asset('lib/images/1.png'),
                        const SizedBox(
                          height: 5,
                        ),
                        //Temperatures
                        Center(
                            child: Text(
                          '${state.weather.temperature!.celsius!.round()}°C',
                          style:const TextStyle(fontSize: 25, color: Colors.white),
                        )),
                        const SizedBox(
                          height: 5,
                        ),
                        //Weather condition
                         Center(
                          child: Text(
                            state.weather.weatherMain!.toUpperCase(),
                            style:const TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        //Date
                         Center(
                          child: Text(
                            DateFormat('EEEE dd .').add_jm().format(state.weather.date!),
                            //'Monday , 11 13:20',
                            style:const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'lib/images/6.png',
                                  scale: 8,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'SunRise',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      DateFormat ().add_jm().format(state.weather.sunrise!),
                                      style:const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'lib/images/10.png',
                                  scale: 8,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'SunSet',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      DateFormat().add_jm().format(state.weather.sunset!),
                                      style:const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'lib/images/12.png',
                                  scale: 8,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Max Temp',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${state.weather.tempMax!.celsius!.round()}°C',
                                      style:const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'lib/images/13.png',
                                  scale: 8,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Min Temp',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${state.weather.tempMin!.celsius!.round()}°C',
                                      style:const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                  } else {
                    return Container();
                  }
                },
                
              )
            ],
          ),
        ),
      ),
    );
  }
}
