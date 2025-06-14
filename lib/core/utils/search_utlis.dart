import 'package:flutter/material.dart';

class SearchUtils {

 static RichText getHighlightedText(String source, String query) {
  if (query.isEmpty) {
    return RichText(
      text: TextSpan(text: source, style: const TextStyle(color: Colors.black)),
    );
  }

  final lowerSource = source.toLowerCase();
  final lowerQuery = query.toLowerCase();

  final startIndex = lowerSource.indexOf(lowerQuery);
  if (startIndex == -1) {
    // No match found
    return RichText(
      text: TextSpan(text: source, style: const TextStyle(color: Colors.black)),
    );
  }

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: source.substring(0, startIndex),
          style: const TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: source.substring(startIndex, startIndex + query.length),
          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: source.substring(startIndex + query.length),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}
}