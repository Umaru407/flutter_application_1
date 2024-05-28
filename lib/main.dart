import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/cook_diary.dart';
import 'package:flutter_application_1/views/game_over_screen.dart';
import 'package:flutter_application_1/views/homepage.dart';
import 'package:flutter_application_1/views/photo_screen.dart';
import 'package:flutter_application_1/views/start_game_screen.dart';
import 'package:flutter_application_1/views/app_home.dart';
import 'package:flutter_application_1/views/student.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Memory Game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: GameOverScreen(duration: 10,),
        // home: StartGameScreen(),
        home: AppHomeScreen(),
        // home: CookDiaryScreen(),
        // home: HomePage()
        // home:SaveImageDemoSQLlite()
        //
        );
  }
}
