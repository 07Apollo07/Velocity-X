import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darkTheme {
    //1
    return ThemeData(
      //2
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF4784F1),
      appBarTheme:
          AppBarTheme(backgroundColor: Color.fromRGBO(36, 36, 36, 1.0)),
      scaffoldBackgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline3: TextStyle(fontSize: 24),
        bodyText1: TextStyle(letterSpacing: 1.8),
      ),
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
  }

  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      brightness: Brightness.light,
      primaryColor: const Color(0xFF4784F1),
      appBarTheme:
          const AppBarTheme(backgroundColor: Color.fromRGBO(255, 255, 255, 1)),
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      // textTheme: const TextTheme(
      //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      //   headline3: TextStyle(fontSize: 24),
      //   bodyText1: TextStyle(letterSpacing: 1.8),
      //   bodyText2: TextStyle(
      //       fontSize: 27, letterSpacing: 1.8, fontWeight: FontWeight.bold),
      // ),
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
}
