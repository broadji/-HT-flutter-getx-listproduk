import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ht_flutter_getx_listproduk/core/components/custom_button.dart';
import 'package:ht_flutter_getx_listproduk/core/config/theme/app_fonts.dart';

class AlertCostume{
 static alertDialogConfirmation(BuildContext context, String title,
      String contentMessage, dynamic onPressedActionTrue,
      {dynamic onPressedActionFalse}) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0.0.h,
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppFonts.bodyTextStyle.copyWith(
                  color: Colors.black,
                    fontSize: AppFonts.appBarTittleSize,
                    fontWeight: FontWeight.w700,
              ),),
              SizedBox(height: 10),
              Text(contentMessage,
                  textAlign: TextAlign.center,
                  style: AppFonts.bodyTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: AppFonts.body1TextSize)),
              SizedBox(height: 18),
              Container(
                width: double.infinity,
                child: CustomButtons.primaryButton(
                    true, 'Iya', false, null, onPressedActionTrue),
              ),
              Container(
                child: Center(
                  child: TextButton(
                    child: Text("Tidak", style: AppFonts.bodyTextStyle.copyWith(
                        fontSize: AppFonts.body1TextSize, color:Colors.grey)),
                    onPressed: onPressedActionFalse != null
                        ? onPressedActionFalse
                        : () => Navigator.pop(context),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}