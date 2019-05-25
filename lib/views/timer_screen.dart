import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pomodoro/fonts/fonts.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TimerScreen extends StatefulWidget {
  TimerScreen({
    Key key,
  }) : super(key: key);

  @override
  TimerState createState() => TimerState();
}

enum ActualEvent { pomodoro, shortBreak, longBreak }

class TimerState extends State<TimerScreen> with TickerProviderStateMixin {
  AnimationController controller;

  var actualEvent;
  int pomodoroCounter = 1;
  static int pomodoroTime = 25;

  static Duration pomodoroDuration = Duration(seconds: pomodoroTime);
  static Color pomodoroColor = Colors.redAccent;

  static Duration shortBreakDuration = Duration(seconds: 5);
  static Duration longBreakDuration = Duration(seconds: 20);
  static Color breakColor = Colors.greenAccent;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inMinutes).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // var android = AndroidInitializationSettings('mipmap/ic_launcher');
    // var ios = IOSInitializationSettings();
    // var platform = InitializationSettings(android, ios);
    // flutterLocalNotificationsPlugin.initialize(platform);

    actualEvent = ActualEvent.pomodoro;

    controller = AnimationController(vsync: this, duration: pomodoroDuration);
    resetController();

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.dismissed) {
        switch (actualEvent) {
          case ActualEvent.pomodoro:
            if (pomodoroCounter % 4 == 0) {
              actualEvent = ActualEvent.longBreak;
              controller.duration = longBreakDuration;
              showNotification("Longbreak Started!");
            } else {
              actualEvent = ActualEvent.shortBreak;
              controller.duration = shortBreakDuration;
              showNotification("Shortbreak Started!");
            }
            pomodoroCounter++;
            print('Pomodoro finished');
            resetController();
            controller.reverse(
                from: controller.value == 0.0 ? 1.0 : controller.value);
            break;
          case ActualEvent.shortBreak:
            actualEvent = ActualEvent.pomodoro;
            controller.duration = pomodoroDuration;
            print('Shortbreak finished');
            resetController();
            break;
          case ActualEvent.longBreak:
            actualEvent = ActualEvent.pomodoro;
            controller.duration = pomodoroDuration;
            print('Longbreak finished');
            resetController();
            break;
        }
      }
    });
  }

  resetController() {
    controller.value = 1.0;
  }

  showNotification(String message) async {
    // var android = AndroidNotificationDetails(
    //     'CHANNEL ID', "CHANNEL NAME", "CHANNEL DESCRIPTION",
    //     importance: Importance.High);
    // var iOS = IOSNotificationDetails();
    // var platform = NotificationDetails(android, iOS);

    // await flutterLocalNotificationsPlugin.show(
    //     0, "Breaktime", "$message", platform);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    debugPrint('screenWidth: $screenWidth * ');
    return Scaffold(
        // backgroundColor: Color(0xFF5690B5),
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.0, 0.7, 0.9, 1.0],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Color(0xFF5690B5),
                Color(0xFFB4DFF6),
                Color(0xFF82B9D5),
                Color(0xFF5690B5),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.1,
              left: screenWidth * 0.04,
              bottom: screenHeight * 0.02,
              right: screenWidth * 0.04,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: FractionalOffset.center,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                controller.isAnimating
                                    ? Container()
                                    : IconButton(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: screenWidth * 0.08,
                                        ),
                                        onPressed: pomodoroTime > 20
                                            ? () async {
                                                if (pomodoroTime > 20) {
                                                  pomodoroTime -= 5;
                                                  controller.duration =
                                                      Duration(
                                                          seconds:
                                                              pomodoroTime);
                                                  resetController();
                                                }
                                              }
                                            : null,
                                      ),
                                Text(
                                  timerString,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.18,
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: screenWidth * 0.01,
                                  ),
                                ),
                                controller.isAnimating
                                    ? Container()
                                    : IconButton(
                                        icon: Icon(
                                          Icons.keyboard_arrow_up,
                                          size: screenWidth * 0.08,
                                        ),
                                        onPressed: pomodoroTime < 55
                                            ? () async {
                                                if (pomodoroTime < 55) {
                                                  pomodoroTime += 5;
                                                  controller.duration =
                                                      Duration(
                                                          seconds:
                                                              pomodoroTime);
                                                  resetController();
                                                }
                                              }
                                            : null,
                                      ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          // new AspectRatio(
                          //   aspectRatio: 487 / 487,
                          //   child: new Container(
                          //     decoration: new BoxDecoration(
                          //         image: new DecorationImage(
                          //       fit: BoxFit.fitWidth,
                          //       alignment: FractionalOffset.topCenter,
                          //       image: new NetworkImage(
                          //           'https://38.media.tumblr.com/3b739d7aba1f6b153a47fce93b309dbd/tumblr_njltngm1Qw1rn9vmdo1_500.gif'),
                          //     )),
                          //   ),
                          // ),
                          Image.asset(
                            "assets/animated/train_animated_circle.gif",
                            width: screenWidth,
                            height: screenHeight,
                          ),
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (BuildContext context, Widget child) {
                                return CustomPaint(
                                    painter: TimerPainter(
                                  animation: controller,
                                  backgroundColor: Colors.white,
                                  color: actualEvent == ActualEvent.pomodoro
                                      ? pomodoroColor
                                      : breakColor,
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, Widget child) {
                          return FlatButton(
                            color: controller.isAnimating
                                ? Color(0xFFE47172)
                                : Color(0xFF5171C4),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            padding: EdgeInsets.symmetric(
                                horizontal: controller.isAnimating
                                    ? screenWidth * 0.08
                                    : screenWidth * 0.075),
                            child: Text(
                              controller.isAnimating ? "Skip" : "Start",
                              style: TextStyle(
                                fontFamily: GetTextStyle(),
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            // AnimatedBuilder(
                            //   animation: controller,
                            //   builder: (BuildContext context, Widget child) {
                            //     return Icon(controller.isAnimating
                            //         ? Icons.pause
                            //         : Icons.play_arrow);
                            //   },
                            // ),
                            onPressed: () async {
                              if (controller.isAnimating) {
                                controller.stop();
                                resetController();
                                setState(() {});
                              } else {
                                // await Future.delayed(
                                //     const Duration(seconds: 1), () {});
                                controller.reverse(
                                    from: controller.value == 0.0
                                        ? 1.0
                                        : controller.value);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 7.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
