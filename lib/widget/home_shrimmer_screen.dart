import 'package:bdelect/constants.dart';

import 'package:bdelect/widget/search_icon.dart';
import 'package:bdelect/widget/shopping_cart.dart';
import 'package:carousel_slider/carousel_slider.dart';


import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:shimmer/shimmer.dart';

class HomeShrimmerScreen extends StatelessWidget {
  HomeShrimmerScreen({Key? key}) : super(key: key);

  final List<Widget> cnt = [
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.red,
      ),
    ),
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.red,
      ),
    ),
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.red,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final orientaion = MediaQuery.of(context).orientation;
    return Scaffold(
      // backgroundColor: kSecondaryColor,
      // body: Center(
      //   child: CircularProgressIndicator(),
      // ),

      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Shimmer.fromColors(
          highlightColor: Colors.white,
          baseColor: Colors.grey[300]!,
          child: Text(
            'ផ្សារអេឡិចត្រូនិច',
            // style: TextStyle(color: Colors.red, fontFamily: "KhmerOSmuol"),
            style: TextStyle(
              color: kPrimaryColor,
              fontFamily: khmerMoul,
              fontSize: 14,
              package: packageKhmer,
            ),
          ),
        ),
        actions: [
          Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey[300]!,
            child: seachIcon(
              Icon(
                Icons.search,
                color: Colors.amber,
              ),
            ),
          ),
          Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey[300]!,
            child: shoppingCartIcon(
              Icon(
                Icons.shopping_cart,
                color: Colors.red,
              ),
            ),
          ),
          Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey[300]!,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.logout,
                  color: Colors.red,
                )),
          )
        ],
      ),
      body: Container(
        color: kSecondaryColor,
        child: ListView(
          children: [
            Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: Colors.grey[300]!,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CarouselSlider(
                          items: cnt.toList(),
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            autoPlayInterval: Duration(seconds: 5),
                            aspectRatio: 18 / 6,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 8),
                            child: Text(
                              "គ្រុមទំនិញ",
                              style: TextStyle(
                                fontFamily: khmerMoul,
                                package: packageKhmer,
                                fontSize: 12,
                                color: kBColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 200,
                              // color: Colors.grey[200],
                              child: Center(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (ctxt, i) {
                                    return InkWell(
                                      onTap: () {},
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 40),
                                            child: Card(
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              child: Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                width: 120,
                                                height: 150,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                ),
                                                // height: 180,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 15,
                                            child: Container(
                                              width: 100,
                                              height: 150,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3.0),
                                                child: Container(
                                                  width: 90,
                                                  height: 130,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 2,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ម៉ាកយីហោ",
                              style: TextStyle(
                                fontFamily: khmerMoul,
                                package: packageKhmer,
                                fontSize: 12,
                                color: kBColor,
                              ),
                            ),
                            Container(
                              child: StaggeredGridView.countBuilder(
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                crossAxisCount: 8,
                                staggeredTileBuilder: (int index) =>
                                    (orientaion == Orientation.portrait
                                        ? new StaggeredTile.count(2, 2)
                                        : new StaggeredTile.count(1, 1)),
                                itemCount: 8,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        InkWell(
                                  onTap: () {
                                    // id = brandList[index].id;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 200,
                                    width: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 2,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: StaggeredGridView.countBuilder(
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          crossAxisCount: 4,
                          staggeredTileBuilder: (int index) =>
                              (orientaion == Orientation.portrait
                                  ? new StaggeredTile.count(
                                      2, (index % 6 == 0) ? 2.5 : 3)
                                  : new StaggeredTile.count(1, 1.25)),
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) =>
                              InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),

                          // },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
