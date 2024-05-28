import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/game_screen.dart';
import 'package:flutter_application_1/views/start_game_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final levelProvider = StateProvider<int>((ref) => -1);

class CookDiaryScreen extends StatefulWidget {
  // final int duration;
  // const GameOverScreen({super.key, required this.duration});

  @override
  State<CookDiaryScreen> createState() => _CookDiaryScreenState();
}

class _CookDiaryScreenState extends State<CookDiaryScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to the previous screen by popping the current route
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          title: const Text(
            "我的料理日記",
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: EasyDateTimeLine(
                locale: "zh-TW",
                initialDate: DateTime.now(),
                onDateChange: (selectedDate) {
                  setState(() {
                    selectedDate = selectedDate;
                  });
                  //`selectedDate` the new date selected.
                },
                activeColor: const Color(0xffD6C3B4),
                headerProps: const EasyHeaderProps(
                  monthPickerType: MonthPickerType.switcher,
                  dateFormatter: DateFormatter.fullDateDayAsStrMY(),
                ),
                dayProps: const EasyDayProps(
                  activeDayStyle: DayStyle(
                    borderRadius: 32.0,
                  ),
                  inactiveDayStyle: DayStyle(
                    borderRadius: 32.0,
                  ),
                ),
                timeLineProps: const EasyTimeLineProps(
                  hPadding: 16.0, // padding from left and right
                  separatorPadding: 16.0, // padding between days
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Color(0xffffffff),
                child: CookList(meal: '早餐', date: selectedDate),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Color(0xffffffff),
                child: CookList(meal: '午餐', date: selectedDate),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Color(0xffffffff),
                child: CookList(meal: '晚餐', date: selectedDate
                    // date:''
                    // dish:['a','b','c']
                    ),
              ),
              flex: 1,
            )
          ],
        ));
  }

  // SizedBox(height: 16),
}

class CookList extends StatefulWidget {
  final String meal;
  final DateTime date;
  // final String dish;
  // final String date;

  CookList({required this.meal, required this.date});
  // , required this.dish, required this.date

  @override
  _CookListState createState() => _CookListState();
}

class _CookListState extends State<CookList> {
  final List<String> entries = <String>[
    '三杯雞',
    '藥燉排骨',
    '宮保雞丁',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            // margin: EdgeInsets.only(bottom: 20), // 設置底部 margin
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xffF2D5CF), // 設置背景顏色
              borderRadius: BorderRadius.circular(10), // 設置圓角
            ),
            child: Text(
              widget.meal + widget.date.toString(),
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF705E51),
              ),
            ),
          ),
          flex: 0,
        ),
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 6),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 6),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffFEF4F4), // 設置背景顏色
                        borderRadius: BorderRadius.circular(10), // 設置圓角
                      ),
                      // height: 50,

                      child: Text(
                        entries[index],
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF705E51),
                        ),
                      ));
                }))
      ],
    );
  }
}


// class CookDetailList extends StatelessWidget {
//   final List<String> entries = <String>['鹹酥雞', '三杯雞', '紅燒魚'];
//   final List<int> colorCodes = <int>[600, 500, 100];

//   Widget build(BuildContext context) {
//     return ListView.builder(
//         padding: const EdgeInsets.all(8),
//         itemCount: entries.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             height: 50,
//             color: Color(0xffFEF4F4),
//             child: Center(child: Text('${entries[index]}')),
//           );
//         });
//   }
// }