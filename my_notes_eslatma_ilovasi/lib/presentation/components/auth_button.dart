import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.text,
      required this.isActive,
      required this.isLoading,
      required this.onTap});

  final String text;
  final bool isActive;
  final bool isLoading;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32)),
            color: isActive && !isLoading
                ? Colors.white
                : Colors.white.withOpacity(0.2)),
        child: isLoading ? CircularProgressIndicator(color: Colors.white,) : Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Color(0xFF00224F)),
        ),
      ),
    );
  }
}
