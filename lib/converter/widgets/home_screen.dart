import 'package:flutter/material.dart';
import 'package:flutter_currency_app/core/colors.dart';

class TextFieldWithDropdown<T> extends StatelessWidget {
  final Function(String value)? onInput;

  const TextFieldWithDropdown({
    super.key,
    this.label = "Amount",
    required this.items,
    this.itemBuiler,
    required this.onChanged,
    required this.selected,
    required this.controller,
    this.onInput,
  });
  final TextEditingController controller;

  final List<T> items;
  final Widget Function(T item)? itemBuiler;

  final void Function(T? newValue) onChanged;

  final String label;

  final T selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: selected,
                onChanged: onChanged,
                items: items.map<DropdownMenuItem<T>>((T value) {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: itemBuiler?.call(value) ?? Text(value.toString()),
                  );
                }).toList(),
                underline: null,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 100,
                  maxWidth: 400,
                ),
                decoration: BoxDecoration(
                  color: AppColors.fieldBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  onChanged: onInput,
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
