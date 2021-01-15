import 'package:flutter/material.dart';
import 'package:shadow/config/config.dart';

Widget appBarTitle({String title}) {
  return

    // SizedBox(
    // height: AppBar().preferredSize.height,
    // child:

    // Expanded(
      // child:
      //
      Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              color: AppTheme.darkText,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    // ),
  // );


}
