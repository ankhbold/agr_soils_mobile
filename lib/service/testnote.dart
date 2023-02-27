// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:mvvm/service/apis/get_notes_data.dart';
// import 'package:mvvm/service/remote_services.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Repository repository = Repository();
//   List<GetNote> listNote = [];
//   String searchString = '';

//   @override
//   void initState() {
//     super.initState();
//     getGetNoteApi();
//   }

//   var repository = Repository();
//   List<GetNote> listNote = [];
//   getGetNoteApi() async {
//     listNote = await repository.getGetNoteApi();
//     setState(() {
//       isloaded = true;
//     });
//   }

//   List<dynamic> filteredData() {
//     if (searchString.isEmpty) {
//       return data;
//     }
//     return data.where((element) {
//       return element['name'].toLowerCase().contains(searchString.toLowerCase());
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Example'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   searchString = value;
//                 });
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredData().length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(filteredData()[index]['name']),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
