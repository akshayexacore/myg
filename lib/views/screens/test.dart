// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);
//
//
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<String>data= ["Mathew","Deon","Sara","Yeu"];
//   List<String> userChecked = [];
//   void _onSelected(bool selected, String dataName) {
//     if (selected == true) {
//       setState(() {
//         userChecked.add(dataName);
//       });
//     } else {
//       setState(() {
//         userChecked.remove(dataName);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("gvjg"),
//       ),
//       body: ListView.builder(
//           itemCount: data.length,
//           itemBuilder: (context, i) {
//             return ListTile(
//                 title: Text(
//                     data[i]),
//                 trailing:Checkbox(
//             value: userChecked.contains(data[i]),
//             onChanged: (val) {
//             _onSelected(val!, data[i]);
//             },
//             )
//             //you can use checkboxlistTile too
//             );
//           })
//     );
//   }
// }