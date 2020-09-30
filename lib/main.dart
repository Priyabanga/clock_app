import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  currentTime() {
    return "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
  }

  @override
  void initState() {
    super.initState();
    controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.addListener(() {
      if (controller.isCompleted) {
        controller.reverse();
      } else if (controller.isDismissed) {
        controller.forward();
      }
      setState(() {});
      print(controller.value);
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation = Tween(begin: -0.5, end: 0.5).animate(animation);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Clock",
            style: TextStyle(
              fontSize: 38,
              fontFamily: 'times new roman',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.yellowAccent,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.purpleAccent,
        child: Center(
          child: Column(
            children: <Widget>[
              Material(
                borderRadius: BorderRadius.circular(50),
                elevation: 25.0,
                color: Colors.brown,
                child: Container(
                  width: 320,
                  height: 320,
                  child: Center(
                    child: Text(
                      currentTime(),
                      style: TextStyle(
                        fontSize: 58,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cursive',
                      ),
                    ),
                  ),
                ),
              ),
              Transform(
                alignment: FractionalOffset(0.5, 0.1),
                transform: Matrix4.rotationZ(animation.value),
                child: Container(
                  child: Image.asset(
                    "images/pendulum7.png",
                    width: 350,
                    height: 250,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
