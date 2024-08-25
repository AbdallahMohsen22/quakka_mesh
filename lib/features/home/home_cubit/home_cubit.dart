
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/routing/routes.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeChosePageState());
  }

  bool isArabic = false;
  void changeAppLanguage({bool? fromShared}) async {
    var prefs = await SharedPreferences.getInstance();
    if (fromShared != null) {
      isArabic = fromShared;
      emit(AppChangeLanguageStates());
    } else {
      isArabic = !isArabic;
      prefs.setBool('isEnglish', isArabic).then((value) {
        emit(AppChangeLanguageStates());
      });
    }
  }

  /// dashboard
  // List<String> categoriesIcon = [
  //   //"assets/images/png_icons/home.png",
  //   "assets/images/png_icons/caravan.png",
  //   "assets/images/png_icons/4x4.png",
  //   "assets/images/png_icons/motorcycle.png",
  //   "assets/images/png_icons/tools.png",
  //   "assets/images/png_icons/generator.png",
  //   "assets/images/png_icons/service.png",
  //   "assets/images/png_icons/camping.png",
  //   "assets/images/png_icons/workshop.png",
  //   "assets/images/png_icons/shop.png",
  //   "assets/images/png_icons/packages.png",
  //   "assets/images/png_icons/auction.png",
  // ];
  // List<String> categoriesScreen = [
  //   Routes.vehicleScreen,
  //   Routes.vehicleScreen,
  //   Routes.vehicleScreen,
  //   Routes.vehicleScreen,
  //   Routes.generatorScreen, //Generators
  //   Routes.serviceScreen,
  //   Routes.campingScreen, //camping
  //   Routes.workshop,
  //   Routes.shopScreen,
  //   Routes.adsPackagesScreen,
  //   Routes.auctionScreen,
  // ];
  // List<String> categoriesEnglishNames = [
  //   'Caravans',
  //   'Cars 4x4',
  //   'Motorcycle',
  //   'Tools',
  //   'Generators', //Generators
  //   'Services',
  //   "Camping", //camping
  //   'Workshops',
  //   'Shop',
  //   'Packages',
  //   'Auction',
  // ];
  //
  // List<String> categoriesArabicNames = [
  //   //'اخر الأخبار',
  //   'كرفانات',
  //   'سيارات 4x4',
  //   'دراجة نارية',
  //   'قطع غيار',
  //   'مولدات', //Generators
  //   'خدمات',
  //   "تخييم", //camping
  //   'ورش ومعارض',
  //   'متجر',
  //   'الباقات',
  //   'المزادات',
  // ];

  //arguments
  // List<String> arguments = [
  //   ApiConstants.caravan,
  //   ApiConstants.cars,
  //   ApiConstants.motorcycles,
  //   ApiConstants.tools,
  //   'Generators', //Generators
  //   'Services',
  //   "Camping", //camping
  //   'Workshops',
  //   'Shop',
  //   'Packages',
  //   'Auction',
  // ];
  //
  // List<String> addAdsArabicCategory = [
  //   'كرفانات',
  //   'سيارات 4x4',
  //   'دراجة نارية',
  //   'قطع غيار',
  //   'خدمات',
  //   'ورش ومعارض',
  //   "تخييم",
  // ];
  // List<String> addAdsEnglishCategory = [
  //   'Caravans',
  //   'Cars 4x4',
  //   'Motorcycle',
  //   'Tools',
  //   'Services',
  //   'Workshops',
  //   "Camping",
  // ];
  //
  // List<String> addsCategoriesIcon = [
  //   "assets/images/png_icons/caravan.png",
  //   "assets/images/png_icons/4x4.png",
  //   "assets/images/png_icons/motorcycle.png",
  //   "assets/images/png_icons/tools.png",
  //   "assets/images/png_icons/service.png",
  //   "assets/images/png_icons/workshop.png",
  //   "assets/images/png_icons/camping.png",
  //
  // ];
  //
  // List<String> adsCategoriesScreen = [
  //   Routes.addCaravanScreen,
  //   Routes.addCarsScreen,
  //   Routes.addMotorcycles,
  //   Routes.addTools,
  //   Routes.addService,
  //   Routes.addWorkshop,
  //   Routes.addcamping,
  // ];
  //
  // List<String> addAdsArguments = [
  //   ApiConstants.caravan,
  //   ApiConstants.cars,
  //   ApiConstants.motorcycles,
  //   ApiConstants.tools,
  //   'Services',
  //   'Workshops',
  //   'camping',
  // ];
}
