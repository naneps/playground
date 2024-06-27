import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ActionChipsSelector<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T)? titleBuilder;
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
  final ScrollController _scrollController = ScrollController();
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
          Row(
            children: [
              // icon for scroll left
              if (GetPlatform.isWeb) ...[
                IconButton(
                  icon: Icon(MdiIcons.chevronLeft),
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.offset - 50,
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                ),
              ],
              Expanded(
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.items.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      final selected = selectedValues.contains(item);
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: ActionChip(
                          label: widget.titleBuilder != null
                              ? widget.titleBuilder!(item)
                              : Text(item.toString()),
                          avatar: selected ? const Icon(Icons.check) : null,
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
                    },
                  ),
                ),
              ),
              // icon for scroll right
              if (GetPlatform.isWeb) ...[
                IconButton(
                  icon: Icon(MdiIcons.chevronRight),
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.offset + 50,
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                ),
              ],
            ],
          ),
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
