import 'package:MySchool/core/constants/constants.dart';
import 'package:flutter/material.dart';


class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,    //? To Hide Label
          showUnselectedLabels: false,  //? To Hide Label
          // Todo If You Want To Change Selected and Unselected Icon Color.
          selectedItemColor: AppColors.kSecondaryColor,  //? Color When Icon Selected 
          unselectedItemColor: const Color(0xff868686),  //? Color When Icon Unselected 
          backgroundColor: Colors.white,
          currentIndex: currentIndex,  
          onTap: onTap,
          items: items
        ),
      ),
    );
  }
}