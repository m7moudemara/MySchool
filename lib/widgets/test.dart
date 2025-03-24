import 'package:flutter/material.dart';

class CircleAboveImagesWithText extends StatefulWidget {
  const CircleAboveImagesWithText({super.key});

  @override
  _CircleAboveImagesWithTextState createState() =>
      _CircleAboveImagesWithTextState();
}

class _CircleAboveImagesWithTextState extends State<CircleAboveImagesWithText> {
  List<bool> isSelectedList = [false, false, false];

  void _selectCircle(int index) {
    setState(() {
      for (int i = 0; i < isSelectedList.length; i++) {
        isSelectedList[i] = false;
      }
      isSelectedList[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Column(
          children: [
            Stack(
              clipBehavior: Clip.none, 
              children: [
                Image.asset(
                  'assets/student_image.png',
                  width: 141,
                  height: 142,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: -10, 
                  top: -10, 
                  child: GestureDetector(
                    onTap: () => _selectCircle(0),
                    child: Container(
                      width: 42,
                      height: 39,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isSelectedList[0] ? Colors.blue : Colors.transparent,
                        border: Border.all(color: Color(0xffD9D9D9), width: 5.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Student',
              style: TextStyle(fontSize: 24, color: Color(0xff3620C2)),
            ),
          ],
        ),
        SizedBox(height: 20),

        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      'assets/teacher_image.png',
                      width: 144,
                      height: 141,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: -10, 
                      top: -10, 
                      child: GestureDetector(
                        onTap: () => _selectCircle(1),
                        child: Container(
                          width: 42,
                          height: 39,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelectedList[1]
                                ? Colors.blue
                                : Colors.transparent,
                            border: Border.all(
                              color: Color(0xffD9D9D9),
                              width: 5.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Teacher',
                  style: TextStyle(fontSize: 24, color: Color(0xff3620C2)),
                ),
              ],
            ),
            SizedBox(width: 20),
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none, 
                  children: [
                    Image.asset(
                      'assets/parent_image.png',
                      width: 144,
                      height: 141,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: -10, 
                      top: -10, 
                      child: GestureDetector(
                        onTap: () => _selectCircle(2),
                        child: Container(
                          width: 42,
                          height: 39,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelectedList[2]
                                ? Colors.blue
                                : Colors.transparent,
                            border: Border.all(
                              color: Color(0xffD9D9D9),
                              width: 5.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Parent',
                  style: TextStyle(fontSize: 24, color: Color(0xff3620C2)),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
      
      ],
    );
  }
}