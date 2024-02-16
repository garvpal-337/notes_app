
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_assignment/bloc/weather/weather_bloc.dart';
import 'package:notes_assignment/constants/constants.dart';
import 'package:notes_assignment/widgets/weather_card.dart';
import 'package:notes_assignment/widgets/widget_components.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  
 final  PageController _pageController = PageController();
  List<String> cities = [
  'Delhi',
  'Ghaziabad',
  'Noida',
  'Faridabad',
  'Gurgaon',
  'Meerut',
  ];

  @override
  void initState() {
    context.read<WeatherBloc>().add(GetWeatherData());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
     
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          SizedBox(
            height: 80,
            
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: myIconButton(
                     onTap: (){
                      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
                    },
                    icon:const  Icon(Icons.chevron_left_sharp,size: 35,),color: myPrimaryColor.withOpacity(0.2),radius: 30),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: cities.length,
                    onPageChanged: (value) {
                      context.read<WeatherBloc>().add(GetWeatherData(city: cities[value].toLowerCase()));
                    },
                    itemBuilder: (context, index) {
                  
                    return Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(cities[index],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    );
                  },),
                ),
                 Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: myIconButton(
                    onTap: (){
                      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
                    },
                    icon:const  Icon(Icons.chevron_right_rounded,size: 35,),color: myPrimaryColor.withOpacity(0.2),radius: 30),
                ),
               
              ],
            ),
          ),
          const Divider(),
          BlocBuilder<WeatherBloc,WeatherState>(builder: (context, state) {
          if(state is LoadingWeatherData){
           return Container(
            height: 350,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),);
          }
          else if(state is SucceccToGetWeatherData){
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                   WeatherCard(label: state.weatherData.currentSky, icon: state.weatherData.currentSky == 'Clouds' || state.weatherData.currentSky == 'Rain'
                                        ? Icons.cloud
                                        : Icons.sunny, value: "${state.weatherData.currentTemperature} K" ),
                    const SizedBox(height: 20),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        WeatherCard(
                          isSmall: true,
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          value: state.weatherData.currentHumidity.toString(),
                        ),
                        WeatherCard(
                          isSmall: true,
                          icon: Icons.air,
                          label: 'Wind Speed',
                          value: state.weatherData.currentWindSpeed.toString(),
                        ),
                        WeatherCard(
                          isSmall: true,
                          icon: Icons.beach_access,
                          label: 'Pressure',
                          value: state.weatherData.currentPressure.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ); 
          }else if(state is FailedToGetWeatherData){
            return  Center(child: Text(state.error),);
          } else{
            return  const Center(child: Text('somthing went wrong'),);
          }
          
              },
              ),
        ],
      ),
    );
  }
}