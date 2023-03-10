import 'package:flutter/material.dart';

void main() => runApp(UserRemove());

class UserRemove extends StatefulWidget {
  @override
  _UserRemoveState createState() => _UserRemoveState();
}

class _UserRemoveState extends State<UserRemove> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Refresh List Example'),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return ListTile(
              title: Text(item),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteItem(index);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _deleteItem(int index) {
    setState(() {
      // Remove the item from the list
      items.removeAt(index);
    });
  }
}
