// import 'package:flutter/material.dart';

// class ResultDetailsView extends StatelessWidget {  
//   const ResultDetailsView({super.key});
//   static String id = '/ResultDetailsView';  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Result Details',
//           style: TextStyle(
//             color: Color(0xFF3F3D56),
//             fontSize: 20,
//             fontFamily: 'Inter',
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.more_vert),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildHeaderSection(),
//             const SizedBox(height: 20),
//             _buildResultCard(),
//             const SizedBox(height: 20),
//             _buildTotalScore(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeaderSection() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Overall Percentage
//         Column(
//           children: [
//             const Text(
//               '95%',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               'Overall %',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(width: 40),
//         // Student Info
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Name: Mohamed Ashraf',
//               style: TextStyle(
//                 color: Color(0xFF3F3D56),
//                 fontSize: 18,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Grade: A',
//               style: TextStyle(
//                 color: Color(0xFF3F3D56),
//                 fontSize: 18,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildResultCard() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: const Color(0xFFD9D9D9),
//           width: 1.5,
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: [
//           _buildSubjectItem(
//             subject: 'English',
//             score: '95',
//           ),
//           _buildDivider(),
//           _buildSubjectItem(
//             subject: 'Maths',
//             score: '95',
//           ),
//           _buildDivider(),
//           _buildSubjectItem(
//             subject: 'Science',
//             score: '95',
//           ),
//           _buildDivider(),
//           _buildSubjectItem(
//             subject: 'Social',
//             score: '95',
//           ),
//           _buildDivider(),
//           _buildSubjectItem(
//             subject: 'History',
//             score: '95',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSubjectItem({required String subject, required String score}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       child: Row(
//         children: [
//           // Subject Icon
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(Icons.book, size: 20),
//           ),
//           const SizedBox(width: 16),
//           // Subject Name
//           Expanded(
//             child: Text(
//               subject,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           // Score
//           Container(
//             width: 36,
//             height: 36,
//             decoration: const BoxDecoration(
//               color: Color(0xFF103568),
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 score,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Container(
//       height: 1,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       color: const Color(0xFF103568),
//     );
//   }

//   Widget _buildTotalScore() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'Total',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 22,
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         Container(
//           width: 80,
//           height: 80,
//           decoration: const BoxDecoration(
//             color: Color(0xFF103568),
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: Text(
//               '477',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }