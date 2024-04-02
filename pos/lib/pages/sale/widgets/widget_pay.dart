import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:number_to_vietnamese_words/number_to_vietnamese_words.dart';
import 'package:pos/constants/controllers.dart';
import '../../../constants/style.dart';

Widget widgetPay(BuildContext context) {
  // var response =await APIs.generateQRCode(saleOrderController.billAmount.value);
  // Map<String, dynamic> decodedResponse = jsonDecode(response.body);
  // String base64DataUrl = decodedResponse['data']['qrDataURL'].split(',')[1];
  // print(base64DataUrl);
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.95,
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            "Thanh toán",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 30,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Tổng thanh toán",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black54,
                                fontSize: 30,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "${formatMoney.format(saleOrderController.billAmount.value)} vnđ",
                                        style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.black54,
                                          fontSize: 40,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${int.parse(saleOrderController.billAmount.value.toString()).toVietnameseWords()} đồng",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black54,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: FutureBuilder(
                                future: saleOrderController
                                    .loadQRCode()
                                    .then((_) => null),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.9 *
                                            0.23,
                                        child: saleOrderController.qrPay!);
                                  }
                                  return Container();
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await saleOrderController.sentSaleOrder();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.lightBlue),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Thanh toán bằng tiền mặt",
                                        style:
                                            TextStyle(color: Colors.grey[200]),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                          width: 30,
                                          child: Image.asset(
                                            'images/money.png',
                                            fit: BoxFit.contain,
                                            color: Colors.grey[300],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.orange),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Thanh toán bằng chuyển khoản",
                                          style:
                                              TextStyle(color: Colors.grey[100])),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                          width: 30,
                                          child: Image.asset(
                                            'images/credit-card.png',
                                            fit: BoxFit.contain,
                                            color: Colors.grey[200],
                                          ),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  child: Container(width: 1, color: Colors.black),
                ),
                Expanded(
                  flex: 3,
                  child: ListView(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      const Center(
                        child: Text(
                          "Hóa đơn có",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: saleOrderController.itemSales.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                saleOrderController.itemSales[index].soDs
                                                .productName !=
                                            null &&
                                        saleOrderController.itemSales[index]
                                                .soDs.productName !=
                                            ''
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 7,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      saleOrderController
                                                          .itemSales[index]
                                                          .soDs
                                                          .productName!,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: const TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Giá tiền: ${formatMoney.format(saleOrderController.itemSales[index].soDs.salePrice ?? 0)} vnđ",
                                                      style: const TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: Colors.black54,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Center(
                                                  child: Text(
                                                    "x${saleOrderController.itemSales[index].soDs.quantity == null ? "0" : saleOrderController.itemSales[index].soDs.quantity.toString()}",
                                                    style: const TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0, right: 5),
                                                  child: Text(
                                                      formatMoney.format((saleOrderController
                                                                      .itemSales[
                                                                          index]
                                                                      .soDs
                                                                      .salePrice ==
                                                                  null
                                                              ? 0.0
                                                              : saleOrderController
                                                                  .itemSales[
                                                                      index]
                                                                  .soDs
                                                                  .salePrice!) *
                                                          (saleOrderController
                                                                      .itemSales[
                                                                          index]
                                                                      .soDs
                                                                      .quantity ==
                                                                  null
                                                              ? 0
                                                              : saleOrderController
                                                                  .itemSales[
                                                                      index]
                                                                  .soDs
                                                                  .quantity!)),
                                                      style: const TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textDirection:
                                                          TextDirection.rtl),
                                                ),
                                              )
                                            ],
                                          ),
                                          if (index <
                                              saleOrderController
                                                      .itemSales.length -
                                                  1)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              child: Container(
                                                color: Colors.grey,
                                                height: 1,
                                              ),
                                            ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 15, bottom: 10),
                        child: Container(
                          color: Colors.black54,
                          height: 2,
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                "Tổng cộng",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                formatMoney.format(
                                    saleOrderController.billAmount.value),
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
