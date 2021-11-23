import 'package:bdelect/constants.dart';
import 'package:flutter/material.dart';

class FloatingIcon extends StatelessWidget {
  const FloatingIcon({
    Key? key,
    required this.isFabVisible,
    required ScrollController scrollController,
  }) : _scrollController = scrollController, super(key: key);

  final double isFabVisible;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      opacity: isFabVisible,
      child: Container(
        height: 30,
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: Duration(seconds: 1),
              curve: Curves.easeIn,
            );
          },
          child: Icon(
            Icons.arrow_upward,
          ),
        ),
      ),
    );
  }
}