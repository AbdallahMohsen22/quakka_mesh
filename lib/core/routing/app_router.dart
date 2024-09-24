
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/core/routing/routes.dart';
import 'package:new_quakka/features/basewidget/drawer.dart';
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


class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be bassed in any screen like this >> (arguments as ClassName)
    // final args = settings.arguments;
    switch (settings.name) {

      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingPage(),
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
            child:  const HomeScreen(),
          ),
        );
      case Routes.drawerScreen:
        return MaterialPageRoute(
          builder: (_) => MainDrawer(),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child:  LoginScreen(),
          ),
        );

      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );




      case Routes.notificationScreen:
        return MaterialPageRoute(
            builder: (_) =>  NotificationScreen()

        );




      // case Routes.categoriesScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<AdsPackagesCubit>(),
      //       child: CategoriesScreen(),
      //     ),
      //   );
      //




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
