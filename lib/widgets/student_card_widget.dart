import 'package:MySchool/models/student.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 165,
      decoration: BoxDecoration(
        color: const Color(0xFF0C46C4),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Text(
                student.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(student.imageUrl),
                backgroundColor: Colors.grey[300],
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          
          Text(
             student.className,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          
          const Spacer(),
          
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Text('Attendance',style: TextStyle(fontSize: 12,color: Colors.white,),),
                  Text(
                            '${student.absencePercentage.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      
                    ),
                    
                  ),
                ],
              ),
              
              const SizedBox(height: 4),
              
              Container(
                height: 13,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: student.totalDays - student.absentDays,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    
                    Expanded(
                      flex: student.absentDays,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}