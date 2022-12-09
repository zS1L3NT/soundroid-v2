import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    Key? key,
    required this.controller,
    required this.name,
    required this.placeholder,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;

  final String name;

  final String placeholder;

  final String? Function(String?)? validator;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: _isObscure,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.placeholder,
        labelText: widget.name,
        prefixIcon: const AppIcon(Icons.password_rounded),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        errorStyle: const TextStyle(height: 1),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: AppIcon(
            _isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            onPressed: () => setState(() => _isObscure = !_isObscure),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty!';
        }

        if (value.length < 8) {
          return 'Password must be at least 8 characters long!';
        }

        if (!RegExp(r"[a-z]+").hasMatch(value)) {
          return 'Password must have a lowercase letter!';
        }

        if (!RegExp(r"[A-Z]+").hasMatch(value)) {
          return 'Password must have an uppercase letter!';
        }

        if (!RegExp(r"[0-9]+").hasMatch(value)) {
          return 'Password must have a number!';
        }

        if (widget.validator != null) {
          return widget.validator!(value);
        }

        return null;
      },
    );
  }
}
