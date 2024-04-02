import 'package:flutter/material.dart';
import 'package:pos/constants/style.dart';
import 'package:pos/models/product.dart';
import 'package:pos/pages/products/widgets/product_card.dart';
import '../../constants/controllers.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key});

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> searchList = [];
  final bool _isSearching = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
              child: CustomText(
                text: menuController.activeItem.value,
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            height: (width > 768 ? (height - 80) : height - 130),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[50],
                border: Border.all(color: Colors.black12)),
            child: FutureBuilder(
              future: productController.getDataProduct(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: (width - 200) * 0.3,
                              height: 40,
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  searchList.clear();
                                  for (var i in productController.products) {
                                    if (i.name
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        i.id!
                                            .toString()
                                            .toLowerCase()
                                            .contains(value.toLowerCase())) {
                                      searchList.add(i);
                                    }
                                    setState(() {
                                      searchList;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  hintText: "Search: Name, Id",
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons.search),
                                    color: lightGrey,
                                    onPressed: () {},
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: ListView.separated(
                                  itemCount: _isSearching ||
                                          _searchController.text.isNotEmpty
                                      ? searchList.length
                                      : productController.products.length,
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      color: lightGrey,
                                      height: 1,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return ProductCard(
                                      product: _isSearching ||
                                              _searchController.text.isNotEmpty
                                          ? searchList[index]
                                          : productController.products[index],
                                    );
                                  }),
                            )
                          ],
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ],
    );
  }
}
