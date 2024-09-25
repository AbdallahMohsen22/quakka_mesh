import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:new_quakka/features/home/widgets/home_page_widget.dart';
import 'package:new_quakka/features/login/login_screen.dart';
import 'package:shimmer/shimmer.dart';
import '../../utill/color_resources.dart';
import '../chat/chat.dart';
import '../profile/profile_screen.dart';
import '../view_mycart_recevied/my_cart_screen.dart';
import 'login_widget.dart';


class HomeGestScreen extends StatefulWidget {
  const HomeGestScreen({Key? key}) : super(key: key);

  @override
  State<HomeGestScreen> createState() => _HomeGestScreenState();
}

class _HomeGestScreenState extends State<HomeGestScreen>{
  final ScrollController _scrollController = ScrollController();

  int _selectedIndex = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    const LoginWidget(),
    const LoginWidget(),
    const LoginWidget(),
    const LoginWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(

        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),

        bottomNavigationBar: BottomNavigationBar(

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
      ),
    );

  }
}


