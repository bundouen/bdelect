import 'package:bdelect/model/product.dart';
import 'package:bdelect/widget/product_detail/follow_button_widget.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class PanelHeaderWidget extends StatelessWidget {
  final Datum product;
  final VoidCallback onClickedAddCart;

  const PanelHeaderWidget({
    required this.product,
    required this.onClickedAddCart,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(child: buildProduct()),
          FollowButtonWidget(
            onClicked: onClickedAddCart,
          ),
        ],
      );

  Widget buildProduct() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.productName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '\$${product.price * (1 - product.discount / 100)}',
                style: TextStyle(
                  fontFamily: khmerSiemreap,
                  fontSize: 18,
                  package: packageKhmer,
                  color: Colors.blue[900],
                  // fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  product.discount > 0 ? '\$${(product.price)}' : "",
                  style: TextStyle(
                      fontFamily: khmerSiemreap,
                      fontSize: 22,
                      package: packageKhmer,
                      // fontWeight: FontWeight.bold,
                      decoration: product.discount > 0
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color:
                          product.discount > 0 ? Colors.red : Colors.black12),
                ),
              ),
            ],
          )
        ],
      );
}
