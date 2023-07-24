import 'package:flutter/material.dart';
import 'package:women_safety_app/child/bottom_screens/chat_page.dart';
import 'package:women_safety_app/child/bottom_screens/child_home_page.dart';
import 'package:women_safety_app/child/bottom_screens/contacts_page.dart';
import 'package:women_safety_app/child/bottom_screens/profile_page.dart';
import 'package:women_safety_app/child/bottom_screens/review_page.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
    int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    ContactsPage(),
    ChatPage(),
    ProfilePage(),
    ReviewPage(),

  ];
  onTapped(int index){
    setState(() {
      currentIndex = index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex : currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.contacts_rounded,
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outlined,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.reviews,
            ),
            label: 'Reviews',
          ),
        ],
        
      ),
    );
  }
}