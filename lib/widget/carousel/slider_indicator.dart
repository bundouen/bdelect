import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SliderIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey[300]!,
      child: Container(
        // margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: AspectRatio(
            aspectRatio: 18 / 6,
            child: Container(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
