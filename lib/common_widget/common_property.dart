import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

InputDecoration editTextProperty(
    {IconData? icon, String hitText = '', String? svg, String? image}) {
  return InputDecoration(
    prefixIcon: svg == null
        ? icon == null
            ? image == null
                ? null
                : Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      image,
                      color: const Color(0XffEFBC22),
                      height: 10,
                    ),
                  )
            : Icon(icon)
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              svg,
            ),
          ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none, //<-- SEE HERE
      borderRadius: BorderRadius.circular(12.0),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none, //<-- SEE HERE
      borderRadius: BorderRadius.circular(12.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none, //<-- SEE HERE
      borderRadius: BorderRadius.circular(12.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide.none, //<-- SEE HERE
      borderRadius: BorderRadius.circular(12.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none, //<-- SEE HERE
      borderRadius: BorderRadius.circular(12.0),
    ),
    fillColor: const Color.fromRGBO(255, 255, 255, 1),
    filled: true,
    hintText: hitText,
    hintStyle: const TextStyle(color: Colors.black26),
    counterText: '',
  );
}
