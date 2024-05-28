import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/cook_diary.dart';
import 'package:flutter_application_1/views/game_screen.dart';
import 'package:flutter_application_1/views/start_game_screen.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final levelProvider = StateProvider<int>((ref) => -1);

class AppHomeScreen extends StatefulWidget {
  // final int duration;
  // const GameOverScreen({super.key, required this.duration});

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF4EBE4),
            ),
            child: SafeArea(
                child: Center(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 260,
                          height: 260,
                          // color: const Color.fromARGB(255, 15, 93, 148),
                        ),
                        Positioned(
                            top: 20,
                            child: CircleAvatar(
                              backgroundColor: Color(0XFFFFFFFF),
                              radius: 130,
                              backgroundImage: AssetImage(
                                  'assets/images/avatar.png'), // Replace with your avatar image
                            )),
                      ],
                    ),
                    // Container(
                    //     child: CircleAvatar(
                    //   radius: 130,
                    //   backgroundImage: AssetImage(
                    //       'assets/avatar.jpg'), // Replace with your avatar image
                    // )),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 28, vertical: 26),
                      decoration: BoxDecoration(
                        color: Color(0xffFDF9F7), // 設置背景顏色
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)), // 設置圓角
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Jim',
                            style: TextStyle(
                                fontSize: 32, color: Color(0xff806E63)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // Text("111"),
                          MainMenuList(),
                          Container(
                            margin: EdgeInsets.only(bottom: 20, top: 20),
                            child: const MySeparator(color: Color(0xFFC2ADAD)),
                          ),

                          BottomMenuList()
                        ],
                      ),
                    ),
                  ],

                  //   children: [
                  //     Container(
                  //       child: CircleAvatar(
                  //         radius: 130,
                  //         backgroundImage: AssetImage(
                  //             'assets/avatar.jpg'), // Replace with your avatar image
                  //       ),Container()]
                ),
              ],
            )))));
  }

  // SizedBox(height: 16),
}

class MainMenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StartGameScreen(),
                    ),
                  );
                  // print("nav to 家族時光");
                },
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                      child: Image.asset(
                        'assets/images/logo3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      // color: Colors.black12,
                      // width: double.infinity,
                      // margin: EdgeInsets.only(bottom: 20), // 設置底部 margin
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffF2D5CF), // 設置背景顏色
                        borderRadius: BorderRadius.circular(10), // 設置圓角
                      ),
                      child: Text(
                        "家庭食光",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF705E51),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              flex: 1,
            ),

            // Text("12"),

            Expanded(
              child: GestureDetector(
                
                onTap: () {
                  print("料理日記");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CookDiaryScreen(),
                      ));
                },
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                      child: Image.asset(
                        'assets/images/dishDiary.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(bottom: 20), // 設置底部 margin
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffEBD8C9), // 設置背景顏色
                        borderRadius: BorderRadius.circular(10), // 設置圓角
                      ),
                      child: Text(
                        "料理日記",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF705E51),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              flex: 1,
            )

            // Column(
            //   children: [
            //     Image.asset('assets/images/chicken.png',fit: BoxFit.cover,), //1
            //     Text("料理日記")
            //   ],
            // )
          ],
        ));
  }
}

class BottomMenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFC6CCC0),
              foregroundColor: Color(0xFF705E51),

              padding:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 15), // 調整內邊距
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 調整圓角
              ),
            ),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisSize: MainAxisSize.min, // 使按鈕寬度為內容的寬度
              children: [
                Image.asset(
                  'assets/images/contact_icon.png', // 圖像的路徑
                  width: 48,
                  height: 48,
                ),
                SizedBox(width: 8),
                // 圖像和文字之間的間距
                Text(
                  '家人聯絡',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFBFC2CB),
              foregroundColor: Color(0xFF705E51),

              padding:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 15), // 調整內邊距
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 調整圓角
              ),
            ),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisSize: MainAxisSize.min, // 使按鈕寬度為內容的寬度
              children: [
                Image.asset(
                  'assets/images/health_icon.png', // 圖像的路徑
                  width: 48,
                  height: 48,
                ),
                SizedBox(width: 8), // 圖像和文字之間的間距
                Text(
                  '健康資訊',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ]));
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

// Padding(child: Column(children: [Text("111"),Text("222")],)
// Text(
//                             'Jim',
//                             style: TextStyle(
//                                 fontSize: 24, fontWeight: FontWeight.bold),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text("1"), Text("2"), Text("3"), Text("4")
//                               // IconAndLabel(icon: Icons.food_bank, label: '家庭食光'),
//                               // IconAndLabel(icon: Icons.book, label: '料理日記'),
//                               // IconAndLabel(icon: Icons.people, label: '與家人聯絡'),
//                               // IconAndLabel(icon: Icons.favorite, label: '健康資訊'),
//                             ],
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Handle button press for '家庭定位'
//                                   },
//                                   child: Text('家庭定位'),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Handle button press for '料理食譜'
//                                   },
//                                   child: Text('料理食譜'),
//                                 ),
//                               ],
//                             ),