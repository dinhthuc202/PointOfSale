// import 'package:flutter/material.dart';
// import 'package:pos/models/sale_order.dart';
// import 'package:pos/pages/sale/widgets/form_item.dart';
//
// class DynamicFormWidget extends StatefulWidget {
//   const DynamicFormWidget({super.key});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _DynamicFormWidgetState();
//   }
// }
//
// class _DynamicFormWidgetState extends State<DynamicFormWidget> {
//   List<FromItem> fromItems = List.empty(growable: true);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               fromItems.isNotEmpty
//                   ? ListView.builder(
//                   itemCount: fromItems.length,
//                   itemBuilder: (_, index) {
//                     return fromItems[index];
//                   })
//                   : const Center(child: Text("Tap on + to Add Contact"))
//             ],
//           ),
//           Positioned(
//             left: 200,
//             child: Container(
//               width: 56,
//               height: 56,
//               child: Icon(Icons.add),
//               decoration: BoxDecoration(
//                 color: Colors.orange,
//                 borderRadius: BorderRadius.circular(10)
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   onSave() {
//     bool allValid = true;
//
//     for (var element in fromItems) {
//       allValid = (allValid && element.isValidated());
//     }
//
//     if (allValid) {
//       List<String> names =
//       fromItems.map((e) => e.saleOrder.id!).toList();
//       debugPrint("$names");
//     } else {
//       debugPrint("Form is Not Valid");
//     }
//   }
//
//   //Delete specific form
//   onRemove(SaleOrder saleOrder) {
//     setState(() {
//       int index = fromItems
//           .indexWhere((element) => element.saleOrder.id == saleOrder.id);
//
//       if (fromItems != null) fromItems.removeAt(index);
//     });
//   }
//
//   onAdd() {
//     setState(() {
//       SaleOrder saleOrder = SaleOrder(id: fromItems.length.toString());
//       fromItems.add(FromItem(
//         index: fromItems.length,
//         saleOrder: saleOrder,
//         onRemove: () => onRemove(saleOrder),
//       ));
//     });
//   }
// }
