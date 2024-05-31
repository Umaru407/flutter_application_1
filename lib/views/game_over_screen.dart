import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/levelInfo_provider.dart';
import 'package:flutter_application_1/views/cook_diary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/db/dishDiary_db_helper.dart';
import 'package:flutter_application_1/model/cook_diary_model.dart';

import 'dart:convert';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

import 'package:flutter/services.dart';

class GameOverScreen extends ConsumerStatefulWidget {
  final int duration;
  const GameOverScreen({super.key, required this.duration});

  @override
  ConsumerState<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends ConsumerState<GameOverScreen> {
  final DishDiaryDbHelper dbHelper = DishDiaryDbHelper();
  void addCookDiary(newDiary) async {
    await dbHelper.insertCookDiary(newDiary);
  }

  String getMealTime() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 3 && hour < 11) {
      return '早餐';
    } else if (hour >= 11 && hour < 16) {
      return '午餐';
    } else {
      return '晚餐';
    }
  }

  Future<String> imageToBase64(
      String imagePath, int newWidth, int newHeight) async {
    // 从 assets 中加载图片
    final ByteData bytes = await rootBundle.load(imagePath);

    // 将 ByteData 转换为 Uint8List
    final Uint8List buffer = bytes.buffer.asUint8List();

    // 使用 image 库将 Uint8List 解码为 Image
    img.Image? originalImage = img.decodeImage(buffer);
    if (originalImage == null) {
      throw Exception('无法解码图片');
    }

    // 缩小图片大小
    img.Image resizedImage =
        img.copyResize(originalImage, width: newWidth, height: newHeight);

    // 将缩小后的图片编码为 Uint8List
    Uint8List resizedBuffer = Uint8List.fromList(img.encodeJpg(resizedImage));

    // 将 Uint8List 转换为 Base64 字符串
    String base64String = base64Encode(resizedBuffer);

    return base64String;
  }

  bool isConfettiPlaying = true;
  final _confettiController = ConfettiController(
    duration: const Duration(seconds: 12),
  );

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final levelInfo = ref.watch(nowLevelProvider);

    // print(img64.substring(0, 100));
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/complete_dish.png"),
                      SizedBox(width: 30),
                      Text(
                        "料理完成！",
                        style:
                            TextStyle(fontSize: 32, color: Color(0XFF5F4D37)),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    color: Color(0XFFFFFFFF),
                    padding: EdgeInsets.all(60),
                    child: Column(
                      children: [
                        Image.asset(levelInfo?['dish_img_url']),
                        Text(
                          levelInfo?['dish'],
                          style:
                              TextStyle(fontSize: 32, color: Color(0XFF5F4D37)),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Navigator.popUntil(context, (route) => route.isFirst);

                  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            String image64bit = await imageToBase64(
                                levelInfo?['dish_img_url'], 200, 200);

                            CookDiaryModel newDiary = CookDiaryModel(
                              dishName: levelInfo?['dish'],
                              mealType: getMealTime(),
                              dateTime: DateTime.now(),
                              image64bit: image64bit,
                            );

                            addCookDiary(newDiary);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CookDiaryScreen(),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC6CCC0),
                            foregroundColor: Color(0xFF705E51),

                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15), // 調整內邊距
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // 調整圓角
                            ),
                          ),
                          child: Text(
                            '記錄到料理日記',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            // Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE2C6C4),
                            foregroundColor: Color(0xFF705E51),

                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15), // 調整內邊距
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // 調整圓角
                            ),
                          ),
                          child: Text(
                            '回主頁',
                            style: TextStyle(fontSize: 24),
                          ),
                        )
                      ])
                ]),
          ),
          ConfettiWidget(
            numberOfParticles: 30,
            minBlastForce: 10,
            maxBlastForce: 20,
            blastDirectionality: BlastDirectionality.explosive,
            confettiController: _confettiController,
            gravity: 0.1,
          ),
        ],
      ),
    );
  }
}
