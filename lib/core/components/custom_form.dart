import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ht_flutter_getx_listproduk/core/config/theme/app_fonts.dart';

class CustomForm{
  static inputForm(BuildContext context,String? hintText, bool? withDecoration,
      TextEditingController inputController,{Function(String)? onChanged, dynamic onUpdateingCompleted, dynamic onFocusChange, bool? disableForm, String? formType="String"}) {
    BoxDecoration decoration;
    double paddingContainer = 0;
    if (withDecoration == true) {
      paddingContainer = 20;
      decoration = BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border:
        Border.all(color: Theme.of(context).dividerColor, width: 1.h),
        borderRadius: BorderRadius.circular(50),
      );
    } else {
      decoration = BoxDecoration(
          color: Colors.transparent,
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).dividerColor, width: 1.h)));
    }
    Widget inputForm =
    Container(
      padding: EdgeInsets.symmetric(horizontal: paddingContainer, vertical: 13),
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        border:
        Border.all(color: Theme.of(context).dividerColor, width: 1.0),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FocusScope(
              onFocusChange: onFocusChange,
              child: TextFormField(
                enabled: disableForm,
                controller: inputController,
                style: AppFonts.bodyTextStyle,
                keyboardType: formType=='double'? TextInputType.number :TextInputType.text,
                decoration: InputDecoration.collapsed(
                    hintText: hintText, hintStyle: AppFonts.bodyTextStyle,),
                onChanged: onChanged,
                onFieldSubmitted: onUpdateingCompleted,
              ),
            ),
          ),
        ],
      ),
    );

    return inputForm;
  }
}