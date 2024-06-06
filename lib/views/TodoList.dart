

class GridExample extends StatelessWidget {
  final List<String> items = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 每行有兩個欄
        childAspectRatio: 3, // 子元素的寬高比，根據需求調整
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              items[index],
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      },
    );
  }
}