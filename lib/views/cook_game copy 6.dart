import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '料理記憶遊戲',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CookGameScreen(),
    );
  }
}

class CookGameScreen extends StatefulWidget {
  @override
  _CookGameScreenState createState() => _CookGameScreenState();
}

class _CookGameScreenState extends State<CookGameScreen> {
  final List<String> _ingredients = ['蔥', '薑', '鹽', '苦瓜', '空心菜'];
  final List<String> _recipe = ['鹽', '空心菜'];
  final List<String> _selectedIngredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('料理記憶遊戲'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 200,
            child: GridView.builder(
              itemCount: _ingredients.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2,
              ),
              itemBuilder: (context, index) {
                String ingredient = _ingredients[index];
                if (_selectedIngredients.contains(ingredient)) {
                  return SizedBox.shrink();
                }
                return Draggable<String>(
                  data: ingredient,
                  child: IngredientItem(ingredient: ingredient),
                  feedback: Material(
                    child: IngredientItem(ingredient: ingredient),
                  ),
                  childWhenDragging:
                      IngredientItem(ingredient: ingredient, isDragging: true),
                );
              },
            ),
          ),
          DragTarget<String>(
            onAccept: (data) {
              if (_recipe.contains(data)) {
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
                          style: TextStyle(fontSize: 100),
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
    if (_selectedIngredients.length == _recipe.length) {
      bool success = true;
      for (var ingredient in _recipe) {
        if (!_selectedIngredients.contains(ingredient)) {
          success = false;
          break;
        }
      }
      if (success) {
        _showSuccessDialog();
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
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isDragging ? Colors.grey : Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/$ingredient.png',
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
