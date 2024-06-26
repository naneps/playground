import 'package:flutter/material.dart';

class ActionChipsSelector<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T)? titleBuilder;
  final String label;
  final ValueChanged<List<T>>
      onChanged; // Always returns a list, even if single selection
  final bool multipleSelection;
  final List<T> initialValues; // New parameter for initial values

  const ActionChipsSelector({
    super.key,
    required this.label,
    required this.items,
    this.titleBuilder,
    this.multipleSelection = false,
    required this.onChanged,
    this.initialValues =
        const [], // Default to an empty list if no initial values are provided
  });

  @override
  State<ActionChipsSelector<T>> createState() => _ActionChipsSelectorState<T>();
}

class _ActionChipsSelectorState<T> extends State<ActionChipsSelector<T>> {
  late List<T> selectedValues;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...widget.items.asMap().entries.map((e) {
                  T item = e.value;
                  final isSelected = selectedValues.contains(item);
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ActionChip(
                      avatar: isSelected
                          ? Icon(Icons.check, color: Colors.green.shade500)
                          : null,
                      label: Text(
                          widget.titleBuilder?.call(item) ?? item.toString()),
                      onPressed: () {
                        setState(() {
                          if (widget.multipleSelection) {
                            if (selectedValues.contains(item)) {
                              selectedValues.remove(item);
                            } else {
                              selectedValues.add(item);
                            }
                          } else {
                            selectedValues = [item];
                          }
                          widget.onChanged(selectedValues);
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    selectedValues = widget
        .initialValues; // Initialize selected values with the initial values
  }
}
