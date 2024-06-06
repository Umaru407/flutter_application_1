import 'package:flutter/material.dart';

class CookGameScreen extends StatefulWidget {
  @override
  _CookGameScreenState createState() => _CookGameScreenState();
}

class _CookGameScreenState extends State<CookGameScreen> {
  final List<String> _ingredients = ['蔥', '薑', '鹽', '苦瓜', '空心菜'];
  final List<String> _recipe = ['鹽', '空心菜','薑'];
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
            padding: EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _ingredients.map((ingredient) {
                if (_selectedIngredients.contains(ingredient)) {
                  return SizedBox.shrink();
                }
                return SizedBox(
                  width: (MediaQuery.of(context).size.width - 48) / 3, // 计算每列的宽度
                  child: Draggable<String>(
                    data: ingredient,
                    child: IngredientItem(ingredient: ingredient),
                    feedback: Material(
                      child: IngredientItem(ingredient: ingredient),
                    ),
                    childWhenDragging:
                        IngredientItem(ingredient: ingredient, isDragging: true),
                  ),
                );
              }).toList(),
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
