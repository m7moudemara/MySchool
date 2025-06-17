import 'package:MySchool/core/utils/utils.dart';
import 'package:flutter/material.dart';

class AddWidget extends StatelessWidget {
  final String title;
  final double width;
  VoidCallback? onTap;
  AddWidget({super.key, required this.title, required this.width, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Container(
                height: ResponsiveUtils.getResponsiveHeight(context, 0.2),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: const Color(0xFF225FFF),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: InkWell(
                  onTap: onTap,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9.0),
                          child: Image(image: AssetImage('assets/+.png')),
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            color: const Color(0xFF0C46C4),
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: width),
        ],
      ),
    );
  }
}
