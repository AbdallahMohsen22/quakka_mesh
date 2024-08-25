
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:new_quakka/features/home/widgets/home_page_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../generated/l10n.dart';
import '../../localization/language_constrants.dart';
import '../../utill/app_assets.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../basewidget/drawer.dart';
import '../basewidget/title_row.dart';
import '../category/all_category_screen.dart';
import '../category/category_model.dart';
import '../chat/chat.dart';
import '../profile/profile_screen.dart';
import '../view_mycart_recevied/my_cart_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  final ScrollController _scrollController = ScrollController();

  // List<ListCategoryModel> catList=[
  //   ListCategoryModel(title: "BirthDay",  image: AppAssets.birthday),
  //   ListCategoryModel(title: "Arafa",  image: AppAssets.arafa),
  //   ListCategoryModel(title: "happy New Year",  image: AppAssets.happyNew),
  //   ListCategoryModel(title: "Ramadan",  image: AppAssets.ramadan),
  //   // CategoryModel(title: "BirthDay",  image: AppAssets.imagesCard1),
  //
  // ];
  int _selectedIndex = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    const HomePageScreen(),
    MyCartScreen(),
    ChatScreen(),
    ProfileScreen(),
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
        // drawer: MainDrawer(),
        // appBar: AppBar(
        //   centerTitle: false,
        //   title:  Shimmer.fromColors(
        //     period: const Duration(seconds: 2),
        //     baseColor: Colors.purple,
        //     highlightColor: Colors.red,
        //     child:  Text(S.of(context).chooseYourCard,style: TextStyle(
        //         fontSize: 20,
        //       fontWeight: FontWeight.bold
        //     ),),
        //   )
        //
        //
        // ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),

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
                  child: Icon(Icons.home,)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Shimmer.fromColors(
                  period: const Duration(seconds: 5),
                  baseColor: ColorResources.appColor,
                  highlightColor:ColorResources.apphighlightColor,
                  child: Icon(Icons.near_me_sharp,)),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: Shimmer.fromColors(
                  period: const Duration(seconds: 500),
                  baseColor: ColorResources.appColor,
                  highlightColor:ColorResources.apphighlightColor,
                  child: Icon(IconlyBold.chat,)),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: Shimmer.fromColors(
                  period: const Duration(seconds: 500),
                  baseColor: ColorResources.appColor,
                  highlightColor:ColorResources.apphighlightColor,
                  child: Icon(Icons.person,)),
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


