import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:gap/gap.dart';
import 'package:my_notes_eslatma_ilovasi/utils/extensions.dart';

class ItemNote extends StatelessWidget {
  const ItemNote(
      {super.key,
      required this.title,
      required this.time,
      required this.index,
      required this.controller});

  final String title;
  final quill.QuillController controller;

  final DateTime time;
  final int index;

  @override
  Widget build(BuildContext context) {
    const colors = [
      Color(0xFFfd99ff), // violet
      Color(0xFFff9e9e), // orange
      Color(0xFF91f48f), // green
      Color(0xFFfff599), // yellow
      Color(0xFF9effff), // blue
    ];
    final backgroundColor = colors[index % colors.length];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black, overflow: TextOverflow.ellipsis),
          ),
          Gap(8),
          // quill.QuillEditor.basic(
          //   controller: controller,
          // ),
          Text(
            controller.document.toPlainText().trim(),
            maxLines: 3, // limit to 3 lines
            overflow: TextOverflow.ellipsis, // show “…” if it overflows
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.black, overflow: TextOverflow.ellipsis),
          ),
          Gap(8),
          Text(
            time.toDateString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.black, overflow: TextOverflow.ellipsis),
          ),
        ],
      ).paddingAll(6),
    );
  }
}
