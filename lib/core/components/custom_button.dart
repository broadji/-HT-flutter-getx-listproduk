import 'package:flutter/material.dart';
import 'package:ht_flutter_getx_listproduk/core/config/theme/app_fonts.dart';

class CustomButtons{
  static primaryButton(
      bool buttonStatusActiveInactive,
      String textButton,
      bool iconStatusActiveInactive,
      IconData? iconName,
      dynamic onPressedAction,{double? radiusCircular}) {
    Widget iconComponent = Container();

    if (iconStatusActiveInactive == true) {
      if (iconName == null) {
        iconName = Icons.question_mark;
      } else {
        iconName = iconName;
      }

      iconComponent = Row(
        children: <Widget>[
          Icon(
            iconName,
            size: 14,
            color: Colors.white,
          ),
          SizedBox(width: 10)
        ],
      );
    }

    ElevatedButton primaryButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonStatusActiveInactive == true
              ? Colors.green
              : Colors.grey,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusCircular??24),
          ),
          elevation: buttonStatusActiveInactive == true ? 2.0 : 0,
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              iconComponent,
              Text(
                textButton,
                style: AppFonts.bodyTextStyle.copyWith(
                    fontSize: AppFonts.body1TextSize, color: Colors.white),
              )
            ]),
        onPressed: buttonStatusActiveInactive == true ? onPressedAction : null);
    return primaryButton;
  }
}