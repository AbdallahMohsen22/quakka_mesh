// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:new_quakka/features/home/widgets/home_page_widget.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../utill/color_resources.dart';
// import 'login_widget_cart.dart';
// import 'login_widget_chat.dart';
// import 'login_widget_profile.dart';
//
//
// class HomeGestScreen extends StatefulWidget {
//   const HomeGestScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeGestScreen> createState() => _HomeGestScreenState();
// }
//
// class _HomeGestScreenState extends State<HomeGestScreen>{
//
//   int _selectedIndex = 0;
//
//     final List<Widget> _widgetOptions = <Widget>[
//       const HomePageScreen(),
//       const LoginWidgetCart(),
//       const LoginWidgetChat(),
//       const LoginWidgetProfile(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body:  _widgetOptions.elementAt(_selectedIndex),
//
//
//     bottomNavigationBar: BottomNavigationBar(
//
//         items:  <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Shimmer.fromColors(
//                 period: const Duration(seconds: 5),
//                 baseColor: ColorResources.appColor,
//                 highlightColor:ColorResources.apphighlightColor,
//                 child: const Icon(Icons.home,)),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Shimmer.fromColors(
//                 period: const Duration(seconds: 5),
//                 baseColor: ColorResources.appColor,
//                 highlightColor:ColorResources.apphighlightColor,
//                 child: const Icon(Icons.near_me_sharp,)),
//             label: '',
//           ),
//
//           BottomNavigationBarItem(
//             icon: Shimmer.fromColors(
//                 period: const Duration(seconds: 500),
//                 baseColor: ColorResources.appColor,
//                 highlightColor:ColorResources.apphighlightColor,
//                 child: const Icon(IconlyBold.chat,)),
//             label: '',
//           ),
//
//           BottomNavigationBarItem(
//             icon: Shimmer.fromColors(
//                 period: const Duration(seconds: 500),
//                 baseColor: ColorResources.appColor,
//                 highlightColor:ColorResources.apphighlightColor,
//                 child: const Icon(Icons.person,)),
//             label: '',
//           ),
//
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: ColorResources.apphighlightColor,
//         onTap: _onItemTapped,
//       ),
//     );
//
//   }
// }
//
//
