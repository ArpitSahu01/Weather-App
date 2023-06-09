import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_starter_project/controllers/global_controller.dart';
import 'package:weatherapp_starter_project/models/wheather_data_hourly.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;

  HourlyDataWidget({Key? key, required this.weatherDataHourly})
      : super(key: key);

  // card index
  RxInt cardIndex = GlobalController().getIndex();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: Text(
            'Today',
            style: TextStyle(fontSize: 18),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 150,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherDataHourly.hourly.length > 12
              ? 14
              : weatherDataHourly.hourly.length,
          itemBuilder: (context, index) {
            return Obx(
                () => GestureDetector(
                onTap: (){
                  cardIndex.value = index;
                },
                child: Container(
                  width: 90,
                  margin: EdgeInsets.only(left: 20,right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0.5, 0),
                        blurRadius: 30,
                        spreadRadius: 1,
                        color: CustomColors.dividerLine.withAlpha(150),
                      )
                    ],
                    gradient: cardIndex.value == index ? const LinearGradient(colors: [
                      CustomColors.firstGradientColor,
                      CustomColors.secondGradientColor,
                    ]) : null,
                  ),
                  child: HourlyDetails(
                      temp: weatherDataHourly.hourly[index].temp!,
                      timeStamp: weatherDataHourly.hourly[index].dt!,
                      weatherIcon: weatherDataHourly.hourly[index].weather![0].icon!,
                    index: index,
                    cardIndex: cardIndex.value,
                  ),
                ),
              ),
            );
          }),
    );
  }
}

// hourly details class
class HourlyDetails extends StatelessWidget {
  int temp;
  int timeStamp;
  int index;
  int cardIndex;
  String weatherIcon;

  String getTime(final timeStamp){
   DateTime time =  DateTime.fromMillisecondsSinceEpoch( timeStamp*1000);
   String x = DateFormat('jm').format(time);
   return x;
  }

  HourlyDetails(
      {Key? key,
      required this.temp,
      required this.timeStamp,
      required this.weatherIcon,
      required this.cardIndex,
      required this.index,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(getTime(timeStamp),style:TextStyle(
            color: cardIndex == index? Colors.white:null
          ),),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Image.asset('assets/weather/${weatherIcon}.png',height: 40,width: 40,),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text('${temp}°C',style:TextStyle(
              color: cardIndex == index? Colors.white:null
          ),
          ),
        )

      ],
    );
  }
}
