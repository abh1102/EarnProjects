import 'package:flutter/material.dart';
Widget _buildDropdownField({

  required String label,
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      validator: (val) => val == null || val.isEmpty ? 'Select $label' : null,
    ),
  );
}
