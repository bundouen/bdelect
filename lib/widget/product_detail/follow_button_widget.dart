import 'package:flutter/material.dart';

class FollowButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;

  const FollowButtonWidget({
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onClicked,
        child: Card(
            color: Colors.red,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "ADD TO CART",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      );
  // GestureDetector(
  //       onTap: onClicked,
  //       child: AnimatedContainer(
  //         duration: Duration(milliseconds: 300),
  //         curve: Curves.easeIn,
  //         width: 140,
  //         height: 50,
  //         child: buildStretched(),
  //       ),
  //     );

  Widget buildStretched() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.red, width: 2.5),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              'ADD TO CART',
              style: TextStyle(
                color: Colors.red,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );

  Widget buildShrinked() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.red),
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      );
}
