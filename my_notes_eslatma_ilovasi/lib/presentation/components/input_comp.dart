import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.isPassword,
      required this.controller,
      required this.hint,
      required this.icon});

  final bool isPassword;
  final TextEditingController controller;
  final String hint;
  final Widget icon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    if (!widget.isPassword) {
      _obscureText = false;
    }
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white),
        decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
                fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF12325D), width: 1.5)),
            border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF12325D), width: 1.5)),
            prefixIcon: widget.icon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility_sharp,
                      color: Colors.white,
                    ))
                : (widget.controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          widget.controller.clear();
                        })
                    : null)));
  }
}
