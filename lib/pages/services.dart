import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() {
    return _ServicesState();
  }
}

class _ServicesState extends State<Services> {

  List<String> imageItems = [
    'assets/images/ad1.jpg',
    'assets/images/ad2.jpg',
    'assets/images/ad3.jpg'
  ];

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CarouselSlider(
            items: imageItems.map((e) => Container(
              margin: EdgeInsets.only(top: 12.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(e),
                      fit: BoxFit.fill)),
            )).toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 5),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              viewportFraction: 0.75,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason){
                setState(() {
                  _current = index;
                });
              }
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageItems.map((e) {
                int index = imageItems.indexOf(e);
                return AnimatedContainer(
                  width: _current == index ? 12.0 : 8.0,
                  height: _current == index ? 12.0 : 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Theme.of(context).accentColor
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                  duration: Duration(milliseconds: 500),
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height *0.07,
                width: MediaQuery.of(context).size.width *0.47,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all()
                ),
                child: Center(child: Text('Aerobics')),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height *0.07,
                width: MediaQuery.of(context).size.width *0.47,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all()
                ),
                child: Center(child: Text('Stretching')),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height *0.07,
                width: MediaQuery.of(context).size.width *0.47,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all()
                ),
                child: Center(child: Text('Massages')),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height *0.07,
                width: MediaQuery.of(context).size.width *0.47,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all()
                ),
                child: Center(child: Text('Ab workouts')),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height *0.07,
                width: MediaQuery.of(context).size.width *0.47,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all()
                ),
                child: Center(child: Text('Dance class')),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height *0.07,
                width: MediaQuery.of(context).size.width *0.47,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all()
                ),
                child: Center(child: Text('Weight training')),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height *0.07,
                width: MediaQuery.of(context).size.width *0.47,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all()
                ),
                child: Center(child: Text('Jogging')),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height *0.07,
                width: MediaQuery.of(context).size.width *0.47,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all()
                ),
                child: Center(child: Text('Swimming')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
