import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class FormatButton extends StatelessWidget {
  final IconData icon;
  final quill.Attribute attribute;
  final quill.QuillController controller;

  const FormatButton({
    super.key,
    required this.icon,
    required this.attribute,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final currentAttr = controller.getSelectionStyle().attributes[attribute.key];
    final isActive = currentAttr?.value == attribute.value;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.white24 : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: IconButton(
        icon: Icon(icon, color: isActive ? Colors.white : Colors.grey),
        onPressed: () {
          final toggled = isActive ? quill.Attribute.clone(attribute, null) : attribute;
          controller.formatSelection(toggled);
        },
      ),
    );
  }
}
