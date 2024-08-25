import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../basic_constants.dart';
import '../../core/routing/routes.dart';
import '../../core/theming/font_weight_helper.dart';
import '../../core/theming/styles.dart';
import '../../utill/app_assets.dart';
import '../../utill/color_resources.dart';
import '../../utill/dialog_utils.dart';
import '../add_category/add_category_screen.dart';
import '../banner/add_banner.dart';
import '../dashboard/dashboard_screen.dart';
import '../home/home_cubit/home_cubit.dart';
import '../home/home_screen.dart';
import '../payment/presentation/views/widgets/my_cart_view_body.dart';
import '../profile/profile_screen.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
      builder: (context, state){
        print(" isSignIn >> $isSignIn");
        print(" isAdmin >> $isAdmin");
        print(" userId >> $userId");
        return Drawer(
          backgroundColor: ColorResources.apphighlightColor,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
            child: ListView(

              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: ColorResources.apphighlightColor,
                  ),
                  child: Stack(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset(AppAssets.splashLogo, width: 300, height: 400,fit: BoxFit.cover,),

                    ]),


                  ]),
                ),
                ///Dashboard
                if (isAdmin == true)
                Column(
                  children: [
                    ListTile(
                      trailing: Shimmer.fromColors(
                        baseColor: ColorResources.white,
                        highlightColor: ColorResources.white,
                        child: const Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ),
                      leading: Shimmer.fromColors(
                        baseColor: ColorResources.white,
                        highlightColor: ColorResources.white,
                        child: const Icon(
                          Icons.dashboard_outlined,
                          size: 30,
                        ),
                      ),
                      title:  Text(
                        HomeCubit.get(context).isArabic? "الاحصاءات":"Dashboard",
                        style: const TextStyle(color: Colors.white,),),
                      onTap: () {
                        // Navigate to the home page.
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  DashboardScreen())); // Closes the drawer
                      },
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 1,
                      color: Colors.white.withOpacity(.5),
                    ),
                  ],
                ),


                ///Home
                ListTile(
                  trailing: Shimmer.fromColors(
                    baseColor: ColorResources.white,
                    highlightColor: ColorResources.white,
                      child: const Icon(
                          Icons.arrow_right,
                        size: 30,
                      ),
                  ),
                  leading: Shimmer.fromColors(
                    baseColor: ColorResources.white,
                    highlightColor: ColorResources.white,
                    child: const Icon(
                        Icons.home,
                      size: 30,
                    ),
                  ),
                  title:  Text(
                  HomeCubit.get(context).isArabic? "الرئيسية":"Home",
                    style: const TextStyle(color: Colors.white,),),
                  onTap: () {
                    // Navigate to the home page.
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen())); // Closes the drawer
                  },
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  color: Colors.white.withOpacity(.5),
                ),
                ///Account
                ListTile(
                  trailing: Shimmer.fromColors(
                    baseColor: ColorResources.white,
                    highlightColor: ColorResources.white,
                    child: const Icon(
                      Icons.arrow_right,
                      size: 30,
                    ),
                  ),
                  leading: Shimmer.fromColors(
                    baseColor: ColorResources.white,
                    highlightColor: ColorResources.white,
                    child: const Icon(
                      Icons.person_3_sharp,
                      size: 30,
                    ),
                  ),
                  title:  Text(
                    HomeCubit.get(context).isArabic? "الحساب":"Account",
                    style: const TextStyle(color: Colors.white,),),
                  onTap: () {
                    // Navigate to the home page.
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  const ProfileScreen())); // Closes the drawer
                  },
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  color: Colors.white.withOpacity(.5),
                ),

                ///add_banner
                if(isAdmin==true)
                  Column(
                    children: [
                      ListTile(
                        trailing: Shimmer.fromColors(
                          baseColor: ColorResources.white,
                          highlightColor: ColorResources.white,
                          child: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          ),
                        ),
                        leading: Shimmer.fromColors(
                          baseColor: ColorResources.white,
                          highlightColor: ColorResources.white,
                          child: const Icon(
                            IconlyBold.paperPlus,
                            size: 30,
                          ),
                        ),
                        title:  Text(
                          HomeCubit.get(context).isArabic?
                          "اضافة بانر":
                          "Add Banner",
                          style: const TextStyle(color: Colors.white,),),
                        onTap: () {
                          // Navigate to the home page.
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddBannerForm())); // Closes the drawer
                        },
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        thickness: 1,
                        color: Colors.white.withOpacity(.5),
                      ),
                    ],
                  ),

                ///add_category
                if(isAdmin==true)
                Column(
                  children: [
                    ListTile(
                      trailing: Shimmer.fromColors(
                        baseColor: ColorResources.white,
                        highlightColor: ColorResources.white,
                        child: const Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ),
                      leading: Shimmer.fromColors(
                        baseColor: ColorResources.white,
                        highlightColor: ColorResources.white,
                        child: const Icon(
                          IconlyBold.category,
                          size: 30,
                        ),
                      ),
                      title:  Text(
                        HomeCubit.get(context).isArabic?
                        "اضافة قسم":
                        "Add Category",
                        style: const TextStyle(color: Colors.white,),),
                      onTap: () {
                        // Navigate to the home page.
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddCategoryScreen())); // Closes the drawer
                      },
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 1,
                      color: Colors.white.withOpacity(.5),
                    ),
                  ],
                ),


                // ///add cart
                // ListTile(
                //   trailing: Shimmer.fromColors(
                //     baseColor: ColorResources.white,
                //     highlightColor: ColorResources.white,
                //     child: const Icon(
                //       Icons.arrow_right,
                //       size: 30,
                //     ),
                //   ),
                //   leading: Shimmer.fromColors(
                //     baseColor: ColorResources.white,
                //     highlightColor: ColorResources.white,
                //     child: const Icon(
                //       Icons.add,
                //       size: 30,
                //     ),
                //   ),
                //   title:  Text(
                //     HomeCubit.get(context).isArabic? "اضافة كارت":"Add Cart",
                //     style: TextStyle(color: Colors.white,),),
                //   onTap: () {
                //     // Navigate to the home page.
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddCartScreen())); // Closes the drawer
                //   },
                // ),
                // Divider(
                //   indent: 20,
                //   endIndent: 20,
                //   thickness: 1,
                //   color: Colors.white.withOpacity(.5),
                // ),

                ///Credit
                ListTile(
                  trailing: Shimmer.fromColors(
                    baseColor: ColorResources.white,
                    highlightColor: ColorResources.white,
                    child: const Icon(
                      Icons.arrow_right,
                      size: 30,
                    ),
                  ),
                  leading: Shimmer.fromColors(
                    baseColor: ColorResources.white,
                    highlightColor: ColorResources.white,
                    child: const Icon(
                      Icons.credit_card,
                      size: 30,
                    ),
                  ),
                  title:  Text(
                    HomeCubit.get(context).isArabic?
                    "الفيزا":
                    "Credit",
                    style: const TextStyle(color: Colors.white,),),
                  onTap: () {
                    // Navigate to the home page.
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>  MyCartViewBody())); // Closes the drawer
                  },
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  color: Colors.white.withOpacity(.5),
                ),
                ListTile(
                  onTap: () {
                    HomeCubit.get(context).changeAppLanguage();
                  },
                  trailing: Shimmer.fromColors(
                    baseColor: ColorResources.white,
                    highlightColor: ColorResources.white,
                    child: const Icon(
                      Icons.arrow_right,
                      size: 30,
                    ),
                  ),
                  leading: Shimmer.fromColors(
                    baseColor: ColorResources.white,
                    highlightColor: ColorResources.white,
                    child: const Icon(
                      Icons.language,
                      size: 30,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        HomeCubit.get(context).isArabic
                            ? "اللغة : "
                            : 'Language : ',
                        style: const TextStyle(color: Colors.white,),
                      ),
                      Text(
                          HomeCubit.get(context).isArabic
                              ? 'English'
                              : 'العربية',
                          style: const TextStyle(color: Colors.white,),)
                    ],
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  color: Colors.white.withOpacity(.5),
                ),

                if (isSignIn == true)
                  ListTile(
                    onTap: () {
                      DialogUtils.showMessage(
                          context,
                          HomeCubit.get(context).isArabic
                              ? 'هل أنت متأكد من تسجيل الخروج ؟'
                              : 'Are you sure you want to logout ?',
                          posActionTitle:
                          HomeCubit.get(context).isArabic
                              ? "نعم"
                              : "yes", posAction: () async {
                        var prefs =
                        await SharedPreferences.getInstance();
                        setState(() {
                          isSignIn = false;
                        });
                        prefs.setBool('isAuth', false);
                        prefs.remove('userId');
                        prefs.remove('token');
                        context.pushReplacementNamed(Routes.loginScreen);
                      },
                          negActionTitle:
                          HomeCubit.get(context).isArabic
                              ? "لا"
                              : "no",
                          negAction: () {});
                    },
                    trailing: Shimmer.fromColors(
                      baseColor: ColorResources.white,
                      highlightColor: ColorResources.white,
                      child: const Icon(
                        Icons.arrow_right,
                        size: 30,
                      ),
                    ),
                    leading:  Shimmer.fromColors(
                      baseColor: ColorResources.white,
                      highlightColor: ColorResources.white,
                      child: const Icon(
                        IconlyBold.logout,
                      ),
                    ),
                    title: Text(
                      HomeCubit.get(context).isArabic
                          ? 'تسجيل الخروج'
                          : 'Logout',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  color: Colors.white.withOpacity(.5),
                ),

                Center(
                  child: TextButton(
                    onPressed: _launchPrivacyPolicy,
                    child: Text(
                      HomeCubit.get(context).isArabic
                          ? 'Version: 1.0 | سياسة الخصوصية'
                          : 'Privacy Policy | Version: 1.0',
                      style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      }
    );
  }
  void _launchPrivacyPolicy() async {
    const url = 'https://www.example.com/privacy-policy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}