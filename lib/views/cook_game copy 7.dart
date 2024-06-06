import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/game_over_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/model/levelInfo_provider.dart';
import 'dart:math';

class CookGameScreen extends ConsumerStatefulWidget {
  final int levelIndex;
  const CookGameScreen({required this.levelIndex}); //
  @override
  ConsumerState<CookGameScreen> createState() => _CookGameScreenState();
}

class _CookGameScreenState extends ConsumerState<CookGameScreen> {
  final List<String> allIngredients = [
    "九層塔",
    "大白菜",
    "五花肉",
    "太白粉水",
    "牛肉片",
    "白飯",
    "皮蛋",
    "冰糖",
    "米",
    "米粉",
    "米酒",
    "豆皮",
    "豆腐",
    "豆瓣醬",
    "空心菜",
    "虱目魚肚",
    "青蔥",
    "洋蔥末",
    "紅蘿蔔",
    "苦瓜",
    "茄子",
    "香油",
    "香菇",
    "粉絲",
    "高湯",
    "高麗菜絲",
    "甜辣醬",
    "蚵仔",
    "麻油",
    "番茄",
    "嫩豆腐",
    "蒜",
    "辣油",
    "蔥",
    "蝦仁",
    "豬大腸",
    "豬肉絲",
    "豬絞肉",
    "醋",
    "糖",
    "薑",
    "醬油",
    "雞蛋",
    "雞腿肉",
    "鹽"
  ];

  late List<String> requiredIngredients;

  late List<String> possibleIngredients = [];

  List<String> _selectedIngredients = [];
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    //   _isFinished = false;
    final nowInfo = ref.read(nowLevelProvider);

    requiredIngredients = nowInfo?['recipe']['ingredients'];
    // possibleIngredients = nowInfo?['recipe']['ingredients'];
    possibleIngredients = selectRandomIngredients(nowInfo);

    print("@@@");
    print(possibleIngredients);
  }

  List<String> selectRandomIngredients(nowInfo) {
    List<String> remainingIngredients = List.from(allIngredients);
    remainingIngredients.removeWhere(
        (item) => nowInfo?['recipe']['ingredients'].contains(item));

    Random random = Random();
    while (possibleIngredients.length <
        12 - nowInfo?['recipe']['ingredients'].length) {
      String randomIngredient =
          remainingIngredients[random.nextInt(remainingIngredients.length)];
      if (!possibleIngredients.contains(randomIngredient)) {
        possibleIngredients.add(randomIngredient);
      }
    }

    possibleIngredients.addAll(nowInfo?['recipe']['ingredients']);
    possibleIngredients.shuffle();

    return possibleIngredients;
  }

  // final List<String> _ingredients = ['蔥', '薑', '鹽', '苦瓜', '空心菜'];
  // List<String> allIngredients = [

  // ];
  // late List<String> _ingredients;

  // late List<String> requiredIngredients;
  // List<String> selectedIngredients = [];

  // // List<String> filteredIngredients = ingredients
  // //       .where((ingredient) => !excludedIngredients.contains(ingredient))
  // //       .toList();
  // //   filteredIngredients.shuffle();
  // //   setState(() {
  // //     selectedIngredients = filteredIngredients.take(12).toList();
  // //   });

  // final List<String> _selectedIngredients = [];
  // late bool _isFinished;

  // @override
  // void initState() {
  //   _isFinished = false;
  //   final nowInfo = ref.read(nowLevelProvider);
  //   requiredIngredients = nowInfo?['recipe']['ingredients'];
  //   _ingredients =
  //       selectRandomIngredients(_ingredients, allIngredients, requiredIngredients);

  //   // final levelIndex = ref.read(levelProvider);
  //   // startTimer();
  //   // startDuration();
  //   // startGameAfterDelay();
  //   // initializeGameData(nowLevel);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return _isFinished
        ? GameOverScreen()
        : Scaffold(
            appBar: AppBar(
              title: Text('料理記憶遊戲'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: possibleIngredients.map((ingredient) {
                      print("!!!");
                      print(ingredient);
                      if (_selectedIngredients.contains(ingredient)) {
                        return SizedBox.shrink();
                      }
                      return SizedBox(
                        width: (MediaQuery.of(context).size.width - 48) /
                            3, // 计算每列的宽度
                        child: Draggable<String>(
                          data: ingredient,
                          child: IngredientItem(ingredient: ingredient),
                          feedback: Material(
                            child: IngredientItem(ingredient: ingredient),
                          ),
                          childWhenDragging: IngredientItem(
                              ingredient: ingredient, isDragging: true),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                DragTarget<String>(
                  onAccept: (data) {
                    if (requiredIngredients.contains(data)) {
                      setState(() {
                        _selectedIngredients.add(data);
                        _checkCompletion();
                      });
                    }
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      color: Colors.brown[200],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.brown[200],
                            child: Center(
                              child: Text(
                                '🍲',
                                style: TextStyle(fontSize: 120),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _selectedIngredients.map((ingredient) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/ingredients/all/$ingredient.png',
                                  width: 50,
                                  height: 50,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }

  void _checkCompletion() {
    if (_selectedIngredients.length == requiredIngredients.length) {
      bool success = true;
      for (var ingredient in requiredIngredients) {
        if (!_selectedIngredients.contains(ingredient)) {
          success = false;
          break;
        }
      }
      if (success) {
        setState(() {
          _isFinished = true;
        });
        // _showSuccessDialog();
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('成功'),
          content: Text('你完成了食譜！'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _selectedIngredients.clear();
                });
              },
              child: Text('重玩'),
            ),
          ],
        );
      },
    );
  }
}

class IngredientItem extends StatelessWidget {
  final String ingredient;
  final bool isDragging;

  IngredientItem({required this.ingredient, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isDragging ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/ingredients/all/$ingredient.png',
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
