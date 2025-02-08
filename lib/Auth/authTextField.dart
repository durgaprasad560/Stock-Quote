import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  const AuthTextField({super.key, required this.controller, required this.obscureText, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.alegreyaSans(color: Colors.white),
      cursorColor: Colors.white,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          fillColor: Color(0xFF404649),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade600,),
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300,),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          hintStyle: GoogleFonts.alegreyaSans(),
          hintText: hintText
      ),
    );
  }
}
