import 'package:MySchool/core/constants.dart';
import 'package:flutter/material.dart';


class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
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
          items: const [
            // Todo Change Icon and Active Icon 
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 26),   //? When Icon Unselected 
              activeIcon: Icon(Icons.home_filled, size: 26),  //? When Icon Selected  
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined, size: 26),
              activeIcon: Icon(Icons.chat, size: 26),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, size: 26),
              activeIcon: Icon(Icons.calendar_today, size: 26),
              label: 'Time Table',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 26),
              activeIcon: Icon(Icons.person, size: 26),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}