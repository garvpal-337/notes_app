
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_assignment/constants/constants.dart';
import 'package:notes_assignment/widgets/submit_button.dart';

PreferredSize myAppBar(
    {required context,
    required String title,
    String? subtitle,
    leading = true,
    bool centerTitle = false,
    trailing,
    buttoncolor = Colors.white,
    void Function()? onBackButton,
    Color backgroundColor = Colors.white,
    Color forgroundColor = Colors.black,
    double elevation = 0}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: AppBar(
      backgroundColor: backgroundColor,
      leadingWidth: leading ? null : 1,
      leading: leading
          ? IconButton(
              onPressed: onBackButton ??
                  () {
                    Navigator.pop(context);
                  },
              icon: Icon(
                CupertinoIcons.arrow_left,
                color: forgroundColor,
              ))
          : null,
      elevation: elevation,
      actions: [
        Container(
          child: trailing,
        )
      ],
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title),
        if (subtitle != null)
          const SizedBox(
            height: 7,
          ),
        if (subtitle != null)
          Text(
            subtitle,
            style:
                TextStyle(color: forgroundColor.withOpacity(0.8), fontSize: 15),
          )
      ]),
      centerTitle: centerTitle,
      titleTextStyle: TextStyle(
          fontFamily: 'Urbanist',
          color: forgroundColor,
          fontSize: 18,
          fontWeight: FontWeight.w500),
    ),
  );
}



Widget myIconButton({
  required dynamic icon,
  color,
  onTap,
  double size = 50,
  double radius = 5,
  double margin = 0,
  borderColor = Colors.transparent,
}) {
  return InkWell(
    splashColor: Colors.white,
    borderRadius: BorderRadius.circular(radius),
    onTap: onTap,
    child: Container(
      height: size,
      width: size,
      margin: EdgeInsets.all(margin),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: icon,
    ),
  );
}




showMyDialoge({
  required context,
  Widget? title,
  required Widget content,
  yes = 'YES',
  no = 'NO',
  onYes,
}) {
  return showDialog(
      barrierDismissible: false,
      useSafeArea: false,
      context: context,
      builder: (context) { 
          return AlertDialog(
            alignment: Alignment.center,
            titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            content: content == const Text('') ? null : content,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (no != '/null')
                    Expanded(
                        flex: 1,
                        child: no == ''
                            ? Container()
                            : SubmitButton(
                                labelsize: 14,
                                height: 35,
                                color: Colors.transparent,
                                labelColor: myPrimaryColor,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                lable: no)),
                  if (no != '/null')
                    Expanded(
                        flex: 1,
                        child: yes == ''
                            ? Container()
                            : SubmitButton(
                                labelsize: 14,
                                height: 35,
                                onTap: onYes,
                                lable: yes)),
                  if (no == '/null')
                    yes == ''
                        ? Container()
                        : SubmitButton(
                            labelsize: 14,
                            height: 35,
                            width: 150,
                            onTap: onYes,
                            lable: yes)
                ],
              )
            ],
          );
        
      });
}
