import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/views/game_screen.dart';
import 'package:flutter_application_1/views/start_game_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_application_1/db/dishDiary_db_helper.dart';
import 'package:flutter_application_1/model/cook_diary_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/model/levelInfo_provider.dart';

// final levelProvider = StateProvider<int>((ref) => -1);
// final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());


class SelectedDateNotifier extends StateNotifier<DateTime> {
  SelectedDateNotifier() : super(DateTime.now());

  void updateDate(DateTime newDate) {
    // print("update");
    state = newDate;
  }
}

final selectedDateProvider =
    StateNotifierProvider<SelectedDateNotifier, DateTime>(
        (ref) => SelectedDateNotifier());
// final SelectedDateProvider = StateNotifierProvider<SelectedDateNotifier, List<Todo>>((ref) {
//   return TodosNotifier();
// });

class CookDiaryScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<CookDiaryScreen> createState() => _CookDiaryScreenState();
}

class _CookDiaryScreenState extends ConsumerState<CookDiaryScreen> {
  // DateTime selectedDate = DateTime.now();
  final DishDiaryDbHelper dbHelper = DishDiaryDbHelper();

  // List<CookDiaryModel> breakfast = dbHelper.getCookDiaries("早餐");
  List<CookDiaryModel> breakfastDiaries = [];
  List<CookDiaryModel> lunchDiaries = [];
  List<CookDiaryModel> dinnerDiaries = [];
  // final

  @override
  void initState() {
    super.initState();
    print("init");
    retrieveDiaries();
  }

  Future<void> retrieveDiaries() async {
    print("reset");
    print(ref.read(selectedDateProvider));

    final breakfast =
        await dbHelper.getCookDiaries("早餐", ref.read(selectedDateProvider));
    final lunch =
        await dbHelper.getCookDiaries("午餐", ref.read(selectedDateProvider));
    final dinner =
        await dbHelper.getCookDiaries("晚餐", ref.read(selectedDateProvider));
    setState(() {
      breakfastDiaries = breakfast;
      lunchDiaries = lunch;
      dinnerDiaries = dinner;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("@@@");
    // print(selectedDate);
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
                onDateChange: (d) {
                  print(d);
                  ref.read(selectedDateProvider.notifier).updateDate(d);
                  retrieveDiaries();
                },
                activeColor: const Color(0xffD6C3B4),
                headerProps: const EasyHeaderProps(
                  selectedDateStyle: TextStyle(fontSize: 24),
                  monthStyle: TextStyle(fontSize: 24),
                  monthPickerType: MonthPickerType.switcher,
                  dateFormatter: DateFormatter.fullDateMonthAsStrDY(),
                ),
                dayProps: const EasyDayProps(
                  activeDayStyle: DayStyle(
                    dayNumStyle:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    dayStrStyle: TextStyle(fontSize: 18),
                    monthStrStyle: TextStyle(fontSize: 18),
                  ),
                  landScapeMode: true,
                ),
                timeLineProps: const EasyTimeLineProps(
                  hPadding: 16.0, // padding from left and right
                  separatorPadding: 8.0, // padding between days
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Color(0xffffffff),
                child: CookListScreen(
                    meal: '早餐',
                    diary: breakfastDiaries,
                    retrieveDiaries: retrieveDiaries),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Color(0xffffffff),
                child: CookListScreen(
                    meal: '午餐',
                    diary: lunchDiaries,
                    retrieveDiaries: retrieveDiaries),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Color(0xffffffff),
                child: CookListScreen(
                    meal: '晚餐',
                    diary: dinnerDiaries,
                    retrieveDiaries: retrieveDiaries
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

class CookListScreen extends ConsumerStatefulWidget {
  final String meal;
  List<CookDiaryModel> diary = []; // date is mutable and nullable
  Function retrieveDiaries;

  CookListScreen({
    required this.meal,
    required this.diary,
    required this.retrieveDiaries,
  });

  @override
  ConsumerState<CookListScreen> createState() => _CookListState();
}

class _CookListState extends ConsumerState<CookListScreen> {
  final DishDiaryDbHelper dbHelper = DishDiaryDbHelper();

  bool update = false;

  void addCookDiary(newDiary) async {
    await dbHelper.insertCookDiary(newDiary);
    widget.retrieveDiaries();
  }

  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.black,
              child: InteractiveViewer(
                child: Image.asset(imagePath),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAddCookDiaryDialog(BuildContext context) async {
    String name = '';
    String? image64bit = null;
    String? mealType;
    String? dateTime;
    final mealTypes = ['早餐', '午餐', '晚餐'];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('新增料理日記'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: '料理名稱'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                Container(
                    margin: EdgeInsets.only(top: 8, bottom: 4),
                    padding: EdgeInsets.all(8), // 添加10像素的填充
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), // 圆角半径
                      border: Border.all(
                        color: const Color.fromARGB(255, 115, 115, 115), // 边框颜色
                        width: 1, // 边框宽度
                      ),
                    ),
                    child: Center(
                      child: ref.watch(imageProvider) != null
                          ? Image.memory(
                              base64Decode(image64bit!),
                              width: 100,
                              height: 100,
                            )
                          : Text('Upload Image'),
                    )),
                ElevatedButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (pickedFile != null) {
                      List<int> imageBytes = await pickedFile.readAsBytes();
                      image64bit = base64Encode(imageBytes);
                      ref.read(imageProvider.notifier).state = image64bit;

                      // Update the UI to display the image
                      setState(() {}); // Update dialog state
                    }
                  },
                  child: Text('打開相簿'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(
                      source: ImageSource.camera,
                    );

                    if (pickedFile != null) {
                      List<int> imageBytes = await pickedFile.readAsBytes();
                      image64bit = base64Encode(imageBytes);
                      ref.read(imageProvider.notifier).state = image64bit;

                      // Update the UI to display the image
                      setState(() {}); // Update dialog state
                    }
                  },
                  child: Text('拍照'),
                ),
              ],
            );
          }),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: Text('取消'),
                  onPressed: () {
                    ref.read(imageProvider.notifier).state = null;
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: Text('加入'),
                  onPressed: () async {
                    if (name != '') {
                      CookDiaryModel newDiary = CookDiaryModel(
                        dishName: name,
                        mealType: widget.meal,
                        dateTime: ref.read(selectedDateProvider),
                        image64bit: ref.read(imageProvider),
                      );

                      addCookDiary(newDiary);

                      ref.read(imageProvider.notifier).state = null;
                      // await dbHelper.insertCookDiary(newDiary);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('成功新增料理')),
                      );
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('請輸入料理名稱')),
                      );
                    }
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectDate = ref.watch(selectedDateProvider);

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // selectDate.toIso8601String(),
                    widget.meal,
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF705E51), //add ntb
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _showAddCookDiaryDialog(context),
                    child: Icon(
                      Icons.add,
                      color: Color(0xFF705E51),
                    ),
                  ),
                ],
              )),
          flex: 0,
        ),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 6),
                itemCount: widget.diary.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(right: 6),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffFEF4F4), // 設置背景顏色
                        borderRadius: BorderRadius.circular(10), // 設置圓角
                      ),
                      // height: 50,

                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: InteractiveViewer(
                                  child:
                                      Image.asset('assets/images/chicken.png'),
                                ),
                              );
                            },
                          );
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: widget.diary[index].image64bit != null
                                  ? Image.memory(
                                      base64Decode(
                                          widget.diary[index].image64bit!),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/chef1.png',
                                      fit: BoxFit.cover,
                                    ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Text(
                                widget.diary[index].dishName,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFF705E51),
                                ),
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                      ));
                }))
      ],
    );
  }
}

class ImageDialog extends StatelessWidget {
  final String img;
  ImageDialog({required this.img});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(img), fit: BoxFit.cover)),
      ),
    );
  }
}
