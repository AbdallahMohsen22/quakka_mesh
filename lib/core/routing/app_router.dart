
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/core/routing/routes.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/banner/banner_cuibt.dart';
import '../../features/category/cuibt.dart';
import '../../features/home/widgets/notification_screen.dart';
import '../../features/login/login_screen.dart';
import '../../features/auth/register.dart';
import '../../features/home/home_screen.dart';
import '../../features/login/cubit/login_cubit.dart';
import '../../features/on_bording/on_boarding.dart';
import '../../features/splash/splash_screen.dart';
import '../../injection.dart';

// class VehicleArgumet {
//   VehicleModel vehicleModel;
//   VehicleArgumet(this.vehicleModel);
// }

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be bassed in any screen like this >> (arguments as ClassName)
    final args = settings.arguments;
    switch (settings.name) {

      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingPage(),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child:  LoginScreen(),
          ),
        );


      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CategoryCubit>(),
              ),

              BlocProvider(
                create: (context) => getIt<BannerCubit>(),
              ),





            ],
            child:  HomeScreen(),
          ),
        );

      case Routes.notificationScreen:
        return MaterialPageRoute(
            builder: (_) =>  NotificationScreen()

        );


      // case Routes.drawerScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => DrawerScreen(),
      //   );
      // case Routes.categoriesScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<AdsPackagesCubit>(),
      //       child: CategoriesScreen(),
      //     ),
      //   );
      //
      // case Routes.contactUsScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const ContactUsScreen(),
      //   );
      // case Routes.serviceScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<ServiceCubit>(),
      //       child: ServiceScreen(),
      //     ),
      //   );
      //
      // case Routes.workshop:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<ServiceCubit>(),
      //       child: WorkShopScreen(),
      //     ),
      //   );
      // case Routes.privacyPolicyScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const PrivacyPolicy(),
      //   );
      // case Routes.usagePolicyScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const UsagePolicy(),
      //   );
      // case Routes.whoAreWeScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => WhoAreWeScreen(),
      //   );




       //  case Routes.resetPasswordScreen:
       //  return MaterialPageRoute(
       //    builder: (_) => BlocProvider(
       //      create: (context) => getIt<ForgetPasswordCubit>(),
       //      child: const ResetPasswordScreen(),
       //    ),
       //  );
       //
       // case Routes.forgetPasswordConfirmEmail:
       //  return MaterialPageRoute(
       //    builder: (_) => BlocProvider(
       //      create: (context) => getIt<ForgetPasswordCubit>(),
       //      child: ForgetPasswordConfirmEmailScreen(),
       //    ),
       //  );
       //  case Routes.forgetPasswordConfirmOtp:
       //  return MaterialPageRoute(
       //    builder: (_) => BlocProvider(
       //      create: (context) => getIt<ForgetPasswordCubit>(),
       //      child: ForgetPasswordOtpScreen(),
       //    ),
       //  );


      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );

      // case Routes.confirmEmail:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<RegisterCubit>(),
      //       child: ConfirmEmailScreen(),
      //     ),
      //   );
      //
      // case Routes.otpScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<RegisterCubit>(),
      //       child: OtpScreen(),
      //     ),
      //   );
      //
      // case Routes.vehicleScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<VehicleCubit>(),
      //       child: VehicleScreen(
      //         type1: args as String,
      //       ),
      //     ),
      //   );
      //
      //   case Routes.filterPriceVehiclesScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<VehicleCubit>(),
      //       child: const FilterPriceVehiclesScreen(
      //       ),
      //     ),
      //   );
      //
      // case Routes.addCaravanScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<VehicleCubit>(),
      //       child: AddCaravanScreen(),
      //     ),
      //   );
      //
      // case Routes.addCarsScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<VehicleCubit>(),
      //       child: AddCarsScreen(),
      //     ),
      //   );
      //
      // case Routes.addMotorcycles:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<VehicleCubit>(),
      //       child: AddMotorcyclesScreen(),
      //     ),
      //   );
      //
      // case Routes.addTools:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<VehicleCubit>(),
      //       child: AddToolsScreen(),
      //     ),
      //   );
      //
      // case Routes.vehicleDetails:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<VehicleCubit>(),
      //       child: VehicleDetails(
      //         vehicleModel: args as VehicleModel,
      //       ),
      //     ),
      //   );
      // case Routes.shopDetails:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<ShopCubit>(),
      //       child: ShopDetails(
      //         shopItemModel: args as ShopItemModel,
      //       ),
      //     ),
      //   );
      // case Routes.adsPackagesScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider(
      //           create: (context) => getIt<AdsPackagesCubit>(),
      //         ),
      //         //UserAddPackageCubit
      //         BlocProvider(
      //           create: (context) => getIt<UserAddPackageCubit>(),
      //         ),
      //         BlocProvider(
      //           create: (context) => getIt<ServicesPackagesCubit>(),
      //         ),
      //         BlocProvider(
      //           create: (context) => getIt<UserAddServicesPackagesCubit>(),
      //         ),
      //       ],
      //       child: AdsPackagesScreen(),
      //     ),
      //   );
      // case Routes.shopScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<ShopCubit>(),
      //       child: ShopScreen(),
      //     ),
      //   );
      //
      // case Routes.searchProductScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<ShopCubit>(),
      //       child: SearchProductScreen(),
      //     ),
      //   );
      //
      // case Routes.searchProductResultScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<ShopCubit>(),
      //       child: SearchProductResult(
      //         searchKey: args as String,
      //       ),
      //     ),
      //   );
      //
      //
      //
      //   case Routes.searachVehicle:
      //     return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //         create: (context) => getIt<VehicleCubit>(),
      //         child: SearchVehiclesScreen(),
      //       ),
      //   );
      //   case Routes.searachVehicleResult:
      //     return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //         create: (context) => getIt<VehicleCubit>(),
      //         child: SearchVehiclesResult(
      //           searchKey: args as String,
      //         ),
      //       ),
      //     );
      //
      //     case Routes.searachServices:
      //     return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //         create: (context) => getIt<ServiceCubit>(),
      //         child: SearchServiceScreen(),
      //       ),
      //   );
      //   case Routes.searachServicesResult:
      //     return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //         create: (context) => getIt<ServiceCubit>(),
      //         child: SearchServiceResult(
      //           searchKey: args as String,
      //         ),
      //       ),
      //     );
      //
      //
      // case Routes.addService:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<ServiceCubit>(),
      //       child: AddServiceScreen(),
      //     ),
      //   );
      //
      //   case Routes.addcamping:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<ServiceCubit>(),
      //       child: AddCampingScreen(),
      //     ),
      //   );
      // case Routes.addWorkshop:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<ServiceCubit>(),
      //       child: AddWorkshopScreen(),
      //     ),
      //   );
      //   case Routes.campingScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<ServiceCubit>(),
      //       child: CampingScreen(),
      //     ),
      //   );
      // case Routes.serviceDetails:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<ServiceCubit>(),
      //       child: ServiceDetails(
      //         serviceModel: args as ServiceModel,
      //       ),
      //     ),
      //   );
      // //AddAdsScreen
      // case Routes.addAdsScreen:
      //   return MaterialPageRoute(builder: (_) => AddAdsScreen());
      //  case Routes.auctionScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => AuctionScreen(),
      //   );
      //
      // case Routes.generatorScreen:
      //   return MaterialPageRoute(builder: (_) => GeneratorScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(),
                  body: Center(
                    child: Text('No route define for ${settings.name}'),
                  ),
                ));
    }
  }
}
