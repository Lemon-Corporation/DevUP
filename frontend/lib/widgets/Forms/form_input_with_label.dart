// ignore_for_file: deprecated_member_use

import 'package:devup/Values/values.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelledFormInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final String? value;
  final String keyboardType;
  final bool obscureText;
  final TextEditingController controller;

  const LabelledFormInput({
    Key? key,
    required this.placeholder,
    required this.keyboardType,
    required this.controller,
    required this.obscureText,
    required this.label,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.verticalSpace10,
        Text(
          label.toUpperCase(),
          textAlign: TextAlign.left,
          style: GoogleFonts.lato(
            fontSize: 12,
            color: HexColor.fromHex("3C3E49"),
          ),
        ),
        TextFormField(
          controller: controller,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
          onTap: () {},
          keyboardType: keyboardType == "text"
              ? TextInputType.text
              : TextInputType.number,
          obscureText:
              placeholder == 'Password' || placeholder == 'Choose a password'
                  ? true
                  : false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20,
            ),
            suffixIcon: placeholder == "Password"
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(
                      obscureText
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                      color: HexColor.fromHex("3C3E49"),
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  )
                : IconButton(
                    icon: Icon(
                      FontAwesomeIcons.solidTimesCircle,
                      size: 20,
                      color: HexColor.fromHex("3C3E49"),
                    ),
                    onPressed: () {
                      controller.clear();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
            hintText: placeholder,
            hintStyle: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HexColor.fromHex("3C3E49"),
            ),
            filled: false,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor.fromHex("3C3E49")),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor.fromHex("BEF0B2")),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
          ),
        ),
      ],
    );
  }
}
