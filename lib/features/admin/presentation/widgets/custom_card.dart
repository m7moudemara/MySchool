import 'package:MySchool/features/admin/data/models/compo.dart';
import 'package:flutter/material.dart';


class CustomCard extends StatelessWidget {
  final Compo compo;

  const CustomCard({
    super.key,
    required this.compo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFF0C46C4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.27),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      compo.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.43,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded( 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage(compo.image),
                    ),
                    Text(compo.count.toString(),
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
