// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pos/constants/controllers.dart';
// import 'package:pos/models/sale_order.dart';
// import 'package:pos/widgets/custom_text.dart';
//
// class ItemBill extends StatefulWidget {
//   const ItemBill({super.key, required this.index});
//
//   final int index;
//
//   @override
//   State<ItemBill> createState() => _ItemBillState();
// }
//
// class _ItemBillState extends State<ItemBill> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: 220,
//               child: Text(
//                 saleOrderController.itemBills[widget.index].name,
//                 overflow: TextOverflow.visible,
//               ),
//             ),
//             Row(
//               children: [
//                 const CustomText(
//                   text: 'Số lượng: ',
//                   size: 14,
//                 ),
//                 saleOrderController.itemBills[widget.index].quantity != 0
//                     ? IconButton(
//                         icon: const Icon(Icons.remove),
//                         onPressed: () {
//                           //Giảm số lượng
//                           saleOrderController
//                               .decreaseQuantityProduct(widget.index);
//                         })
//                     : Padding(
//                         padding: const EdgeInsets.only(left: 8.0, right: 8),
//                         child: Icon(
//                           Icons.remove,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                 Text(
//                     saleOrderController.itemBills[widget.index].quantity.toString()),
//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: () {
//                     //Tăng số lương
//                     saleOrderController.increaseQuantityProduct(widget.index);
//                   },
//                 )
//               ],
//             ),
//           ],
//         ),
//         ElevatedButton(
//           onPressed: () {saleOrderController.onRemoveProduct2(widget.index);},
//           style: ButtonStyle(
//               backgroundColor:
//                   MaterialStateProperty.all<Color>(Colors.deepOrange),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ))),
//           child: const Icon(
//             Icons.remove,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
// }
