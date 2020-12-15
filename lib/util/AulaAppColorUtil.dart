import 'package:flutter/material.dart';

class AulaAppColorUtil {
    static Map<int, Color> _aulaAmarelo = {
        50: Color.fromRGBO(250, 223, 0, .1),
        100: Color.fromRGBO(250, 223, 0, .2),
        200: Color.fromRGBO(250, 223, 0, .3),
        300: Color.fromRGBO(250, 223, 0, .4),
        400: Color.fromRGBO(250, 223, 0, .5),
        500: Color.fromRGBO(250, 223, 0, .6),
        600: Color.fromRGBO(250, 223, 0, .7),
        700: Color.fromRGBO(250, 223, 0, .8),
        800: Color.fromRGBO(250, 223, 0, .9),
        900: Color.fromRGBO(250, 223, 0, 1)
    };

    static MaterialColor AulaAmarelo = new MaterialColor(0xFFFADF00, _aulaAmarelo);
}