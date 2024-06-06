import 'package:flutter/material.dart';

class CookGameScreen extends StatefulWidget {
  @override
  _CookGameScreenState createState() => _CookGameScreenState();
}

class _CookGameScreenState extends State<CookGameScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _ingredients = ['🥕', '🍅', '🍆', '🥔', '🌽'];
  final List<String> _recipe = ['🥕', '🍅', '🍆'];
  final List<String> _selectedIngredients = [];
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                });
              } else {
                _controller.forward().then((_) {
                  _controller.reverse();
                });
              }
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                // height: 200,
                color: Colors.brown[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.all(10),
                      // height: 100,
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
                          child: Text(
                            ingredient,
                            style: TextStyle(fontSize: 30),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
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
            },
            child: Text('檢查'),
          )
        ],
      ),
    );
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
        child: Text(
          ingredient,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
