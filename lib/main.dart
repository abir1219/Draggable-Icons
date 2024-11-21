import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Dock(),
        ),
      ),
    );
  }
}

class Dock extends StatefulWidget {
  const Dock({super.key});

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {
  final List<IconData> items = [
    Icons.person,
    Icons.message,
    Icons.call,
    Icons.camera,
    Icons.photo,
  ];

  late List<IconData> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(items);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return _items.isNotEmpty
        ? Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black12,
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_items.length, (index) {
              return Draggable<IconData>(
                  data: _items[index],
                  feedback: _buildDockItem(
                      index, screenSize, _items[index], 0.08),
                  childWhenDragging:
                  _buildDockItem(index, screenSize, null, 0.06),
                  onDragEnd: (details) {
                    if (details.offset.dy < 200 ||
                        details.offset.dy > 250) {
                      setState(() {
                        _items.removeAt(index);
                      });
                    }
                  },
                  child: _buildDockItem(
                      index, screenSize, _items[index], 0.06));
            })))
        : const Center(
      child: Text(
        "No Icons Found",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildDockItem(
      int index, Size screenSize, IconData? icon, double heightFactor) {
    return Container(
      constraints: BoxConstraints(minWidth: screenSize.height * heightFactor),
      height: screenSize.height * heightFactor,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: icon != null
            ? Colors.primaries[index % Colors.primaries.length]
            : Colors.transparent,
      ),
      child: icon != null
          ? Center(
        child: Icon(
          icon,
          color: Colors.white,
        ),
      )
          : null,
    );
  }
}
