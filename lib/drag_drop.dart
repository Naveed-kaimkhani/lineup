
import 'package:flutter/material.dart';

class DragDropListScreen extends StatefulWidget {
  const DragDropListScreen({Key? key}) : super(key: key);

  @override
  State<DragDropListScreen> createState() => _DragDropListScreenState();
}

class _DragDropListScreenState extends State<DragDropListScreen> {
  List<String> names = [
    'Alice',
    'Bob',
    'Charlie',
    'Diana',
    'Eve',
    'Frank',
    'Grace',
    'Henry',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag & Drop List'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: names.length,
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          setState(() {
            final item = names.removeAt(oldIndex);
            names.insert(newIndex, item);
          });
        },
        itemBuilder: (context, index) {
          return Card(
            key: ValueKey(names[index]),
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                initialValue: names[index],
                onChanged: (val) => names[index] = val,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}