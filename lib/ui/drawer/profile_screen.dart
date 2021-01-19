import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shadow/config/config.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.white,
        body: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appBar(),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2020/12/15/15/36/gel-capsules-5834023_960_720.jpg',
                      ),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    alignment: Alignment(0.0, 2.5),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://avatars3.githubusercontent.com/u/55433102?s=400&u=834d471a7d5620db7a301ca2cf644324d8957ccf&v=4'),
                      radius: 60.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Align(
                child: Text(
                  "Sharad",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                child: Text(
                  "Pune, India",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                child: Text(
                  "Software Engineer",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    child: Text('Skill Sets'),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Projects',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "25",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Followers",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "2000",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  AppConstant.Profile,
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
