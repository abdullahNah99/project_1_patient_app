import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class EditTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String lableText;
  //final String initialValue;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final bool? obscureText;
  final Function? onPressed;
  final Function? onTap;

  const EditTextField({
    super.key,
    this.controller,
    required this.lableText,
    //required this.initialValue,
    this.validator,
    required this.keyboardType,
    this.suffixIcon,
    this.obscureText,
    this.onPressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
        end: 20.0,
      ),
      child: TextFormField(
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
              width: .5,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple.shade100,
              width: .5,
            ),
          ),
          label: Text(
            lableText,
          ),
          labelStyle: TextStyle(
            fontSize: 17.0,
            color: Colors.grey[500],
          ),
          contentPadding: const EdgeInsetsDirectional.only(
            start: 15.0,
            bottom: 20.0
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.grey[400],
          ),
          suffixIcon: suffixIcon != null ? IconButton(onPressed: (){ onPressed!();}, icon: Icon(suffixIcon, color: defaultColor,)) : null,
        ),
        obscureText: obscureText!,
        //initialValue: initialValue,
        style: const TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        cursorColor: color4,
        validator: validator ??
                (value) {
              if (value?.isEmpty ?? true) {
                return 'this field must not be empty';
              }
              return null;
            },
        onTap: (){
          onTap!();
        },
      ),
    );
  }
}