import 'package:MySchool/core/app_session.dart';
import 'package:MySchool/features/school/data/models/parent_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Model to hold the student data
class Child {
  final String name;
  final String studentClass;
  final String image;

  Child({required this.name, required this.studentClass, required this.image});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      name: json['name'],
      studentClass: json['class'],  // Assuming class is stored under the 'class' key
      image: json['imageUrl'],      // Assuming image URL is stored under the 'imageUrl' key
    );
  }
}

// Main MyChildren Page with Search and Navigation to Details
class MyChildrenView extends StatefulWidget {
  const MyChildrenView({super.key});
  static const String id = '/my_children';
  @override
  State<MyChildrenView> createState() => _MyChildrenViewState();
}

class _MyChildrenViewState extends State<MyChildrenView> {
  Dio _dio = Dio(); // Create Dio instance
  List<Child> children = [];
  List<Child> filteredChildren = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _fetchChildrenData();
  }

  // Fetch children data from the API
  Future<void> _fetchChildrenData() async {
    try {
      final response = await _dio.get('https://67f2952eec56ec1a36d38b8a.mockapi.io/myschool/users');
      final List<dynamic> data = response.data;

      // Assuming the API returns all users with their roles, filter out only the parents' children
      final parent = AppSession.currentUser as Parent; // Get the current parent from session
      final parentId = parent.idNumber; // Get parent ID

      // Filter the children who belong to this parent
      final List<Child> loadedChildren = [];
      for (var item in data) {
        if (item['parentId'] == parentId) {
          loadedChildren.add(Child.fromJson(item));
        }
      }

      setState(() {
        children = loadedChildren;
        filteredChildren = loadedChildren; // Initialize filteredChildren
      });
    } catch (e) {
      print('Error fetching children data: $e');
    }
  }

  // Update search results when user types
  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredChildren = children.where((child) {
        return child.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
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
        spans.add(TextSpan(
          text: source.substring(start, index),
          style: TextStyle(color: Colors.black),
        ));
      }

      spans.add(TextSpan(
        text: source.substring(index, index + query.length),
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ));

      start = index + query.length;
      index = lowerSource.indexOf(lowerQuery, start);
    }

    if (start < source.length) {
      spans.add(TextSpan(
        text: source.substring(start),
        style: TextStyle(color: Colors.black),
      ));
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
                    contentPadding: EdgeInsets.only(top: 14), // Align vertically
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // 🧒 List of children with filtering and navigation
            Expanded(
              child: filteredChildren.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredChildren.length,
                      itemBuilder: (context, index) {
                        final child = filteredChildren[index];
                        final name = child.name;

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
                                  builder: (_) => StudentDetailsPage(
                                    name: child.name,
                                    studentClass: child.studentClass,
                                    imageUrl: child.image,
                                  ),
                                ),
                              );
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                child.image,
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
                              child.studentClass,
                              style: TextStyle(
                                color: Color(0xFF868686),
                                fontSize: 14,
                                fontFamily: 'Inter',
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                          ),
                        );
                      },
                    )
                  : Center(
                      // Display when no results found
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 50, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            'No children found',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔎 Student Details Page
class StudentDetailsPage extends StatelessWidget {
  final String name;
  final String studentClass;
  final String imageUrl;

  const StudentDetailsPage({
    super.key,
    required this.name,
    required this.studentClass,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(imageUrl, width: 100, height: 100),
            ),
            SizedBox(height: 16),
            Text(
              name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              studentClass,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            // 🔧 Add more child-specific details here if needed
          ],
        ),
      ),
    );
  }
}
