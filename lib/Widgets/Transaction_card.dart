import 'package:flutter/material.dart';

class DraggableListSleeve<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final void Function(List<T> newItems) onReorder;

  DraggableListSleeve({
    required this.items,
    required this.itemBuilder,
    required this.onReorder,
  });

  @override
  _DraggableListSleeveState<T> createState() => _DraggableListSleeveState<T>();
}

class _DraggableListSleeveState<T> extends State<DraggableListSleeve<T>> {
  late List<T> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      children: _items
          .map((item) => ListTile(
                key: Key(item.toString()),
                title: widget.itemBuilder(item),
              ))
          .toList(),
      onReorder: _onReorder,
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final T item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
      widget.onReorder(_items);
    });
  }
}
