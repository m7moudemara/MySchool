import 'package:MySchool/features/school/presentation/views/teacher/classes_info_view.dart';
import 'dart:convert';

import 'package:MySchool/core/constants/strings.dart';
import 'package:MySchool/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Main MyChildren Page with Search and Navigation to Details
class MyChildrenView extends StatefulWidget {
  const MyChildrenView({super.key});
  static final String id = "my_children_view";
  @override
  State<MyChildrenView> createState() => _MyChildrenViewState();
}

class _MyChildrenViewState extends State<MyChildrenView> {
  Future<List<Map<String, dynamic>>> getChilds() async {
    String? token = await sharedPrefController.getToken();

    final url = Uri.parse('$baseUrl/api/guardians/73/children');
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      // List result = jsonDecode(response.body)['data'];
      List<Map<String, dynamic>> resultx = [];
      for (var element in jsonDecode(response.body)['data']) {
        Map<String, dynamic> child = await getOneChildInf(
          element['student']['id'],
          token!,
        );
        resultx.add({
          'id': element['student']['id'],
          'name': element['student']['name'],
          'class': child['class_name'],
          'image': "https://img.icons8.com/?size=256w&id=7820&format=png",
        });
      }
      // result.forEach((element) async {
      //   Map<String, dynamic> child = await getOneChildInf(
      //     element['student']['id'],
      //     token!,
      //   );
      //   resultx.add({
      //     'id': element['student']['id'],
      //     'name': element['student']['name'],
      //     'class': child['class_name'],
      //     'image': "https://img.icons8.com/?size=256w&id=7820&format=png",
      //   });
      // });
      // setState(() {
      //   filteredChildren = resultx;
      // });
      print(resultx);
      print('dddddddddddddd');
      return resultx;
    } else {
      throw Exception('error');
    }
  }

  Future<Map<String, dynamic>> getOneChildInf(int id, String token) async {
    final url = Uri.parse('$baseUrl/api/dashboard/student/$id');
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('error');
    }
  }

  // local list of children
  // This should ideally be fetched from a database or API
  // final List<Map<String, String>> allChildren = [
  //   {
  //     "name": "Mohamed Ashraf",
  //     "class": "Class 1",
  //     "image": "https://img.icons8.com/?size=256w&id=7820&format=png",
  //   },
  //   {
  //     "name": "Ahmed Ashraf",
  //     "class": "Class 2",
  //     "image": "https://img.icons8.com/?size=256w&id=7820&format=png",
  //   },
  //   {
  //     "name": "Mahmoud Ashraf",
  //     "class": "Class 3",
  //     "image": "https://img.icons8.com/?size=256w&id=7820&format=png",
  //   },
  //   {
  //     "name": "Mostafa Ashraf",
  //     "class": "Class 4",
  //     "image": "https://img.icons8.com/?size=256w&id=7820&format=png",
  //   },
  // ];

  // Filtered list based on search
  late Future<List<Map<String, dynamic>>> allchilds;
  List<Map<String, dynamic>> filteredChildren = [];
  List<Map<String, dynamic>> allChildren = [];
  String searchQuery = "";
  // late Future<List<Map<String, dynamic>>> allChilds;
  // xx() async {
  //   filteredChildren = await allchilds;
  // }

  @override
  void initState() {
    super.initState();
    // getChilds();
    allchilds = getChilds();
    // xx();
  }

  // Update search results when user types
  void updateSearch(String query) async {
    final reslults =
        allChildren.where((child) {
          return child['name']!.toLowerCase().contains(query.toLowerCase());
        }).toList();
    setState(() {
      filteredChildren = reslults;
      searchQuery = query;
      // filteredChildren =
      //     allChildren.where((child) {
      //       return child['name']!.toLowerCase().contains(query.toLowerCase());
      //     }).toList();
    });
  }

  // Highlight matching part of the name in blue
  List<TextSpan> highlightMatch(String source, String query) {
    if (query.isEmpty) return [TextSpan(text: source)];

    String lowerSource = source.toLowerCase();
    String lowerQuery = query.toLowerCase();

    List<TextSpan> spans = [];
    int start = 0;
    int index = lowerSource.indexOf(lowerQuery);

    while (index != -1) {
      if (index > start) {
        spans.add(
          TextSpan(
            text: source.substring(start, index),
            style: TextStyle(color: Colors.black),
          ),
        );
      }

      spans.add(
        TextSpan(
          text: source.substring(index, index + query.length),
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      );

      start = index + query.length;
      index = lowerSource.indexOf(lowerQuery, start);
    }

    if (start < source.length) {
      spans.add(
        TextSpan(
          text: source.substring(start),
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Children'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search input
            Container(
              height: 61,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Color(0x51A7A7A7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextField(
                  onChanged: updateSearch,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Color(0xFF868686)),
                    hintStyle: TextStyle(
                      color: Color(0xFF868686),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                    contentPadding: EdgeInsets.only(
                      top: 14,
                    ), // Align vertically
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // 🧒 List of children with filtering and navigation
            Expanded(
              child: FutureBuilder(
                future: allchilds,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (allChildren.isEmpty) {
                      allChildren = snapshot.data!;
                      filteredChildren = snapshot.data!;
                    }
                    // return filteredChildren.isNotEmpty
                    //     ?
                    return ListView.builder(
                      itemCount: filteredChildren.length,
                      // itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // final child = snapshot.data![index];
                        // final name = snapshot.data![index]['name'];
                        final child = filteredChildren[index];
                        final name = filteredChildren[index]['name'];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                          margin: EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            onTap: () {
                              // Navigate to details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => ClassesinfoView(
                                        studentClass: child['class']!,
                                        studentName: child['name']!,
                                        studentId: child['id'],
                                      ),
                                ),
                              );
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                child['image']!,
                                width: 48,
                                height: 54,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                                children: highlightMatch(name, searchQuery),
                              ),
                            ),
                            subtitle: Text(
                              child['class']!,
                              style: TextStyle(
                                color: Color(0xFF868686),
                                fontSize: 14,
                                fontFamily: 'Inter',
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    );
                    // : Center(
                    //   // Display when no results found
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Icon(
                    //         Icons.search_off,
                    //         size: 50,
                    //         color: Colors.grey,
                    //       ),
                    //       SizedBox(height: 10),
                    //       Text(
                    //         'No children found',
                    //         style: TextStyle(
                    //           color: Colors.grey,
                    //           fontSize: 16,
                    //           fontFamily: 'Inter',
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
