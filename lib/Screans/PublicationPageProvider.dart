
// import 'dart:ffi';

// import 'package:alpha/Models/Publication.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Provider/PublicationProvider.dart';

// class PublicationPageProvider extends StatefulWidget {
//   const PublicationPageProvider({Key? key}) : super(key: key);

//   @override
//   State<PublicationPageProvider> createState() =>
//       _PublicationPageProviderState();
// }

// class _PublicationPageProviderState extends State<PublicationPageProvider> {
//   @override
//   void initState() {
//     super.initState();
//     final postPublication =
//         Provider.of<DataPublication>(context, listen: false);
//     postPublication.getPublicationsData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final postpublication = Provider.of<DataPublication>(context);
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(10.0),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Text(" titre   :${postpublication.publications.}"),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Text(" nom     :${postpublication.publications.nom}"),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Text(" content :${postpublication.publications.content}"),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Center(
//                 child: Text(
//                   " id :${postpublication.publications?.id}",
//                   style: const TextStyle(color: Colors.redAccent),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       height: 40,
//                       width: 100,
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           textStyle: MaterialStateProperty.all(
//                             const TextStyle(fontSize: 10.0),
//                           ),
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.white60),
//                           foregroundColor:
//                               MaterialStateProperty.all(Colors.blue.shade400),
//                           overlayColor:
//                               MaterialStateProperty.all(Colors.blue.shade50),
//                           shadowColor: MaterialStateProperty.all(Colors.black),
//                           elevation: MaterialStateProperty.all(15),
//                           padding: MaterialStateProperty.all(
//                               const EdgeInsets.all(9.0)),
//                           shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.thumb_up_alt_outlined,
//                               size: 25.0,
//                               color: Colors.blue.shade400,
//                             ),
//                             Text(
//                               "1",
//                               style: TextStyle(
//                                   color: Colors.blue.shade400, fontSize: 20.0),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       height: 40,
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           textStyle: MaterialStateProperty.all(
//                             const TextStyle(fontSize: 5.0),
//                           ),
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.white60),
//                           foregroundColor:
//                               MaterialStateProperty.all(Colors.blue.shade400),
//                           overlayColor:
//                               MaterialStateProperty.all(Colors.blue.shade50),
//                           shadowColor: MaterialStateProperty.all(Colors.black),
//                           elevation: MaterialStateProperty.all(15),
//                           padding: MaterialStateProperty.all(
//                               const EdgeInsets.all(7.0)),
//                           shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//                           setState(() {});
//                         },
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.comment,
//                               size: 18.0,
//                               color: Colors.blue.shade400,
//                             ),
//                             Text(
//                               "Comment",
//                               style: TextStyle(
//                                   color: Colors.blue.shade400, fontSize: 20.0),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
