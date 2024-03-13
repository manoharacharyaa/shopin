import 'package:flutter/material.dart';
import 'package:shopin/colors/colors.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.deviceSize,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.onPressed,
    this.icon,
    this.suffixIcon,
    this.keyboardType,
    this.onSaved,
    this.validator,
    this.onChanged,
  });

  final String hintText;
  final Size deviceSize;
  final bool obscureText;
  final TextEditingController controller;
  final void Function()? onPressed;
  final IconData? icon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: white,
                ),
              ),
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              suffixIcon: suffixIcon,
            ),
            cursorColor: white,
            cursorErrorColor: Colors.red,
            onSaved: onSaved,
            validator: validator,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
