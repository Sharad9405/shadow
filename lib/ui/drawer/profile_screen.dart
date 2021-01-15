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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_appBar()],
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
          // Padding(
          //   padding: const EdgeInsets.only(top: 8, left: 8),
          //   child: Container(
          //     width: AppBar().preferredSize.height - 8,
          //     height: AppBar().preferredSize.height - 8,
          //   ),
          // ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
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
          // Padding(
          //   padding: const EdgeInsets.only(top: 8, right: 8),
          //   child: Container(
          //     width: AppBar().preferredSize.height - 8,
          //     height: AppBar().preferredSize.height - 8,
          //     color: Colors.white,
          //     child: Material(
          //       color: Colors.transparent,
          //       child: InkWell(
          //         borderRadius:
          //             BorderRadius.circular(AppBar().preferredSize.height),
          //         child: Icon(
          //           Icons.dashboard,
          //           color: AppTheme.dark_grey,
          //         ),
          //         onTap: () {},
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
