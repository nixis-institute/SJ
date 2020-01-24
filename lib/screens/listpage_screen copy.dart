// import 'package:flutter/material.dart';
// import 'package:shopping_junction/models/products.dart';
// import 'package:shopping_junction/models/subcategory.dart';
// import 'package:shopping_junction/widgets/product_grid.dart';

// class ListPage extends StatefulWidget{
//   @override
//   final List<Product> product;
//   final SubList list;
//   ListPage({this.product,this.list});

//   _ListPageState createState() => _ListPageState();
// }

// class _ListPageState extends State<ListPage>
// {
//   @override
//   Widget build(BuildContext context)
//   {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.list.name),),
      
//       body: ProductGrid(
//         product: widget.product,
//       ),

//       bottomNavigationBar: BottomAppBar(
//         child: Container(
//           height: 50,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Icon(Icons.sort,
//               color: Colors.white,
//               size: 22,
//               ),
//               SizedBox(width: 10,),
//               Text("Sort & Filter",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 17
//                 ),
//               )
//             ],
//           ),
//         ),
//         color: Colors.green,
        
//       ),
//     );
//   }
// }