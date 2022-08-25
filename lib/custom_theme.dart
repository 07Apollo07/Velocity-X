import 'package:flutter/material.dart';

class Themes {
  static final dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF4784F1),
    secondaryHeaderColor: Color.fromRGBO(255, 255, 255, 1),
    appBarTheme: AppBarTheme(backgroundColor: Color.fromRGBO(36, 36, 36, 1.0)),
    scaffoldBackgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline2: TextStyle(
          fontSize: 50.0, fontWeight: FontWeight.w400, color: Colors.white),
      headline3: TextStyle(fontSize: 24, color: Colors.white),
      headline4: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
      headline5: TextStyle(fontSize: 15, color: Colors.white),
      headline6: TextStyle(fontSize: 10, color: Colors.white),
      bodyText1: TextStyle(letterSpacing: 1.8, color: Colors.white),
      bodyText2: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          letterSpacing: 1.8,
          color: Colors.white),
    ),
    // disabledColor: Color.fromRGBO(255, 0, 0, 1.0),

    // fontFamily: 'Lato', //3
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //     style: ElevatedButton.styleFrom(
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(18.0),
    //             side: const BorderSide(width: 10)),
    //         shadowColor: const Color.fromARGB(117, 74, 141, 255))),
    // buttonTheme: ButtonThemeData(
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(18.0),
    //       side: const BorderSide(width: 10, color: Color(0xFF4784F1))),
    //   splashColor: const Color.fromARGB(148, 46, 161, 255),
    //   buttonColor: const Color(0x0003b2f8),
    // ),
    // listTileTheme: const ListTileThemeData(
    //   contentPadding: EdgeInsets.all(15),
    //   iconColor: Color.fromARGB(117, 74, 141, 255),
    //   textColor: Color.fromARGB(137, 255, 255, 255),
    //   tileColor: Color(0x0003b2f8),
    //   style: ListTileStyle.list,
    // ),
  );

  static final light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF4784F1),
    secondaryHeaderColor: Color.fromRGBO(36, 36, 36, 1.0),
    appBarTheme:
        const AppBarTheme(backgroundColor: Color.fromRGBO(255, 255, 255, 1)),
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.black),
      headline2: TextStyle(
          fontSize: 50.0, fontWeight: FontWeight.w400, color: Colors.black),
      headline3: TextStyle(fontSize: 24, color: Colors.black),
      headline4: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
      headline5: TextStyle(fontSize: 15, color: Colors.black),
      headline6: TextStyle(fontSize: 10, color: Colors.black),
      bodyText1: TextStyle(letterSpacing: 1.8, color: Colors.black),
      bodyText2: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          letterSpacing: 1.8,
          color: Colors.black),
    ),
    // disabledColor: Color.fromRGBO(158, 158, 158, 1),
    // bottomAppBarColor: const Color(0xFF4784F1)
    // fontFamily: 'Lato', //3,
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //     style: ElevatedButton.styleFrom(
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(18.0),
    //             side: const BorderSide(width: 10)),
    //         shadowColor: const Color.fromARGB(117, 74, 141, 255))),
    // buttonTheme: ButtonThemeData(
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(18.0),
    //       side: const BorderSide(width: 10, color: Color(0xFF4784F1))),
    //   splashColor: const Color.fromARGB(148, 46, 161, 255),
    //   buttonColor: const Color(0x0003b2f8),
    // )
  );
}
