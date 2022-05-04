import 'package:flutter/material.dart';
import '../constants.dart';

Widget iconButton(Icon icon, onTap()) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox.fromSize(
        size: Size(40, 40), // button width and height

        child: ClipOval(
          child: Material(
            color: kSecondaryColor, // button color
            child: InkWell(
              splashColor: Colors.green, // splash color

              onTap: () {
                onTap();
              },

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [icon],
              ),
            ),
          ),
        ),
      ),
    );
