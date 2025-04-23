import 'package:MySchool/features/school/presentation/views/teacher/classes_info_view.dart';
import 'package:flutter/material.dart';

// Main MyChildren Page with Search and Navigation to Details
class MyChildrenView extends StatefulWidget {
  const MyChildrenView({super.key});
static final String id = "my_children_view"; 
  @override
  State<MyChildrenView> createState() => _MyChildrenViewState();
}

class _MyChildrenViewState extends State<MyChildrenView> {
  // local list of children
  // This should ideally be fetched from a database or API
  final List<Map<String, String>> allChildren = [
    {
      "name": "Mohamed Ashraf",
      "class": "Class 1",
      "image": "https://img.icons8.com/?size=256w&id=7820&format=png"
    },
    {
      "name": "Ahmed Ashraf",
      "class": "Class 2",
      "image": "https://img.icons8.com/?size=256w&id=7820&format=png"
    },
    {
      "name": "Mahmoud Ashraf",
      "class": "Class 3",
      "image": "https://img.icons8.com/?size=256w&id=7820&format=png"
    },
    {
      "name": "Mostafa Ashraf",
      "class": "Class 4",
      "image": "https://img.icons8.com/?size=256w&id=7820&format=png"
    },
  ];

  // Filtered list based on search
  List<Map<String, String>> filteredChildren = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredChildren = allChildren;
  }

  // Update search results when user types
  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredChildren = allChildren.where((child) {
        return child['name']!.toLowerCase().contains(query.toLowerCase());
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
                        final name = child['name']!;

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
                                  builder: (_) =>ClassesinfoView(
                                    studentClass: child['class']!,
                                    studentName: child['name']!,
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
