import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:pomodoro/insert/homepage.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Pomodoro",
        description:
            "ตัวช่วยในการอ่านหนังสือสำหรับคุณ ที่จะเพิ่มประสิทธิภาพในการทำงานของสมอง เพียงแค่การจัดสรรเวลา!",
        pathImage: "resource/timer.png",
        heightImage: 250,
        widthImage: 250,
        colorEnd: Color(0xff6f3d92),
        colorBegin: Color(0xffffbae9),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );
    slides.add(
      new Slide(
        title: "Place",
        description:
            "หากเบื่อกับการอ่านหนังสือที่บ้าน เรามีสถานที่มากมายที่น่าสนใจและเหมาะแก่การอ่านหนังสือรวมไว้ให้คุณได้ลองชม",
        pathImage: "resource/building.png",
        heightImage: 250,
        widthImage: 250,
        colorEnd: Color(0xff6f3d92),
        colorBegin: Color(0xffffbae9),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );
    slides.add(
      new Slide(
        title: "Book",
        description:
            "แหล่งรวบรวมหนังสือคุณภาพ จากทั่วทั้งมุมโลก แนะนำให้คุณได้เพลิดเพลินไปกับมัน",
        pathImage: "resource/book.png",
        heightImage: 250,
        widthImage: 250,
        colorEnd: Color(0xff6f3d92),
        colorBegin: Color(0xffffbae9),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeState(),
      ),
    );
  }

  void onSkipPress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeState(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    );
  }
}
