import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final List<String> imgList = [
  'assets/images/home1.png',
  'assets/images/home2.png',
  'assets/images/home3.png'
];

class Home extends StatefulWidget {
   Home({Key? key, required this.user}) : super(key: key);

  GoogleSignInAccount user;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 244, 246),
      child: CarouselWithIndicatorDemo(),
    );
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
    const  SizedBox(
        height: 20,
      ),
      CarouselSlider(
        items: imageSliders,
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
   
      homeSection2()
    ]);
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.fill, width: 1000.0),
                  ],
                )),
          ),
        ))
    .toList();

Widget homeSection2() {
  return Column(
    children: [
      Image.asset(
        'assets/images/home_fact_1.png',
        fit: BoxFit.fill,
      ),
      const Text(
        "100",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Text(
            "100% of Sri Lankan blood donors are voluntory non rermunerated donors."),
      ),
      const Padding(
        padding: EdgeInsets.all(15.0),
        child: Divider(
          color: Colors.red,
        ),
      ),
      Image.asset(
        'assets/images/home_fact_4.png',
        fit: BoxFit.fill,
      ),
      const Text(
        "3",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Text(
            "Your precious donation of blood can save as many as 3 lives."),
      ),
      const Padding(
        padding: EdgeInsets.all(15.0),
        child: Divider(
          color: Colors.red,
        ),
      ),
      Image.asset(
        'assets/images/home_fact_2.png',
        fit: BoxFit.fill,
      ),
      const Text(
        "14th JUNE",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Text("World Blood Donor Day."),
      ),
      const Padding(
        padding: EdgeInsets.all(15.0),
        child: Divider(
          color: Colors.red,
        ),
      ),
      Image.asset(
        'assets/images/home_fact_3.png',
        fit: BoxFit.fill,
      ),
      const Text(
        "4",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Text("You can donate blood in every 4 months time."),
      ),
      const Padding(
        padding: EdgeInsets.all(15.0),
        child: Divider(
          color: Colors.red,
        ),
      ),
    ],
  );
  
}
