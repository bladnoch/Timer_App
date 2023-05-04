import 'dart:async';
import 'package:flutter/material.dart';

/// home_screen.dart : includes timer functions
/// @version v0.1
/// @since 5/2/2023
/// @author Dounguk Kim

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const staticNum=3000;
  int totalSeconds=staticNum;
  bool isRunning =false;
  int totalPomodoros=0;
  late Timer timer;

  void onTick(Timer timer){
    if(totalSeconds==0){
      setState(() {
        totalPomodoros+=1;
        isRunning=false;
        totalSeconds=staticNum;
      });
      timer.cancel();
    } else{
      setState(() {
        totalSeconds-=1;
      });

    }
  }

  void onStartPressed(){
    timer=Timer.periodic(
      Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning=true;
    });
  }

  void onPausePressed(){
    timer.cancel();
    setState(() {
      isRunning=false;
    });
  }

  void reStart(){
    setState(() {
      totalSeconds=staticNum;
      format(totalSeconds);
      totalPomodoros=0;
      onPausePressed();
    });


  }

  String format(int seconds){
    var duration =Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2,7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(color: Theme.of(context).cardColor,
                fontSize: 90,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Center(
                  child: IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ?
                    onPausePressed :
                    onStartPressed,
                    icon: Icon(isRunning ?
                    Icons.pause_circle_filled_outlined :
                    Icons.play_circle_fill_outlined),
                  ),
                ),
                Center(
                  child: IconButton(
                    iconSize: 100,
                    color: Theme.of(context).cardColor,
                    onPressed: reStart,
                    icon: Icon(
                    Icons.restart_alt_outlined),
                  ),
                ),
              ],
            )
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pomodoro',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.displayLarge!.color
                        ),),
                        Text('$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.displayLarge!.color
                        ),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
