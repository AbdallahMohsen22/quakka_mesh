import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:new_quakka/features/home/widgets/home_page_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../utill/color_resources.dart';
import '../chat/chat.dart';
import '../profile/profile_screen.dart';
import '../view_mycart_recevied/my_cart_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  //final ScrollController _scrollController = ScrollController();

  int _selectedIndex = 0;

    final List<Widget> _widgetOptions = <Widget>[
     const HomePageScreen(),
     const MyCartScreen(),
     const ChatScreen(),
     const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(


        // selectedFontSize:0,
        // unselectedFontSize: 20,
        // iconSize: 30,
        // showSelectedLabels: true,
        // showUnselectedLabels: true,
        // unselectedItemColor: ColorResources.apphighlightColor,
        // backgroundColor: Colors.white.withOpacity(.5),
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Shimmer.fromColors(
                period: const Duration(seconds: 5),
                baseColor: ColorResources.appColor,
                highlightColor:ColorResources.apphighlightColor,
                child: const Icon(Icons.home,)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Shimmer.fromColors(
                period: const Duration(seconds: 5),
                baseColor: ColorResources.appColor,
                highlightColor:ColorResources.apphighlightColor,
                child: const Icon(Icons.near_me_sharp,)),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Shimmer.fromColors(
                period: const Duration(seconds: 500),
                baseColor: ColorResources.appColor,
                highlightColor:ColorResources.apphighlightColor,
                child: const Icon(IconlyBold.chat,)),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Shimmer.fromColors(
                period: const Duration(seconds: 500),
                baseColor: ColorResources.appColor,
                highlightColor:ColorResources.apphighlightColor,
                child: const Icon(Icons.person,)),
            label: '',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorResources.apphighlightColor,
        onTap: _onItemTapped,
      ),
    );

  }
}


