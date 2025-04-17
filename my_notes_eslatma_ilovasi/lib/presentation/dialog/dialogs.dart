import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../res/app_strings.dart';

/// A custom dialog that matches the provided design.
class SaveDiscardDialog extends StatelessWidget {
  const SaveDiscardDialog(
      {super.key,
      required this.onSaveClick,
      required this.onDiscardClick,
      required this.isLoading});

  final VoidCallback onSaveClick;
  final VoidCallback onDiscardClick;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF262626), // dark background
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Info icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.info_outline,
                size: 32,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            // Title text
            Text(
              AppStrings.saveChanges,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Color(0xFFcfcfcf)),
            ),

            const SizedBox(height: 24),

            // Buttons row
            Row(
              children: [
                if (isLoading) ...[
                  CircularProgressIndicator(
                    color: Colors.blue,
                  )
                ] else ...[
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        onDiscardClick.call();
                        context.pop();
                      },
                      child: Text(
                        AppStrings.discard,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        onSaveClick.call();
                      },
                      child: Text(
                        AppStrings.save,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
