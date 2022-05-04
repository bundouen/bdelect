import 'package:bdelect/constants.dart';
import 'package:bdelect/controller/product_name_controller.dart';
import 'package:bdelect/controller/productcontroller.dart';
import 'package:bdelect/model/pname.dart';
import 'package:bdelect/model/product.dart';
import 'package:bdelect/widget/product_by_name/product_byname_Item.dart';
import 'package:bdelect/widget/product_detail/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/seachscreen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ProductNameController pNameController =
      Get.find<ProductNameController>();
  final ProductController productController = Get.find<ProductController>();
  var proName = PName(name: "No", price: 0);
  var productNameList = <Datum>[];
  //  PName? proName ;

  @override
  Widget build(BuildContext context) {
    productNameList = productController.productByName;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField<PName?>(
                  suggestionsCallback: pNameController.getUserSuggestions,
                  textFieldConfiguration: TextFieldConfiguration(
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: khmerSiemreap,
                        package: packageKhmer,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.red,
                        ),
                        iconSize: 50,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(
                          color: kSecondaryColor,
                        ),
                      ),
                      hintText: ("Search Product"),
                    ),
                  ),
                  itemBuilder: (context, PName? suggestion) {
                    final pname = suggestion!;
                    return ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pname.name,
                                style: TextStyle(
                                  fontFamily: khmerSiemreap,
                                  package: packageKhmer,
                                  fontSize: 16,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Text(
                                "\$${pname.price}",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  noItemsFoundBuilder: (context) => Center(
                    child: Text(
                      "ទំនិញហ្នឹងអត់មានទេ\!",
                      style: TextStyle(
                          fontFamily: khmerSiemreap,
                          package: packageKhmer,
                          fontSize: 16,
                          color: kPrimaryColor),
                    ),
                  ),
                  onSuggestionSelected: (PName? suggestion) {
                    final pname = suggestion!;
                    setState(() {
                      proName = pname;
                      productController.fechProductByName(proName.name);
                    });

                    // ScaffoldMessenger.of(context)
                    //   ..removeCurrentSnackBar()
                    //   ..showSnackBar(
                    //     SnackBar(
                    //       content: Text(
                    //         "បានជ្រើរើសឈ្មោះទំនិញ:​ ${pname.name}",
                    //         style: TextStyle(
                    //           fontFamily: khmerSiemreap,
                    //           package: packageKhmer,
                    //           fontSize: 12,
                    //         ),
                    //       ),
                    //     ),
                    //   );
                  },
                ),
              ),
            ),
            proName.name != "No"
                ? Expanded(
                    child: Container(
                        child: ListView.builder(
                            itemCount: productNameList.length,
                            itemBuilder: (context, i) {
                              return Obx(
                                () {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          ProductDetails.routeName,
                                          arguments: productNameList[i].id,
                                        );
                                      },
                                      child: ProductByNameItem(
                                        productNameList: productNameList[i],
                                      ),
                                    ),
                                  );
                                },
                              );
                            })),
                  )
                : Expanded(
                    child: Container(
                      child: Text(
                        "ស្វែងរកទំនិញដែលអ្នកចង់បាន",
                        style: TextStyle(
                          fontFamily: khmerSiemreap,
                          package: packageKhmer,
                          fontSize: 18,
                          color: kPrimaryColor,
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
