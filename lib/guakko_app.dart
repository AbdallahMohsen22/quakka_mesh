import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:new_quakka/basic_constants.dart';
import 'core/network/message.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/app_theme.dart';
import 'features/cart_screen/cuibt.dart';
import 'features/chat/send_massege_cuibt.dart';
import 'features/home/home_cubit/home_cubit.dart';
import 'features/profile/delete_user_cuibt/delete_user_cuibt.dart';
import 'features/search_by_username/cuibt.dart';
import 'features/send_cart/cuibt.dart';
import 'generated/l10n.dart';
import 'main.dart';

class GuakkoApp extends StatelessWidget {
  final AppRouter appRouter;
  final bool? isEnglish;
  const GuakkoApp({
    super.key,
    required this.appRouter,
    required this.isEnglish,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Set the design size based on screen width. For example:
        if (constraints.maxWidth >= 768) {
          // For iPads or larger devices
          return buildResponsiveApp(context, const Size(768, 1024)); // iPad size
        } else {
          // For phones or smaller devices
          return buildResponsiveApp(context, const Size(375, 812)); // iPhone size
        }
      },
    );
  }

  Widget buildResponsiveApp(BuildContext context, Size designSize) {
    return ScreenUtilInit(
      designSize: designSize, // Dynamically set design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return BlocProvider(
          create: (BuildContext context) =>
          HomeCubit()..changeAppLanguage(fromShared: isEnglish),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<UserCubit>(create: (context) => UserCubit()),
                  BlocProvider<DeleteUserCubit>(create: (context) => DeleteUserCubit()),
                  BlocProvider<SendCartCubit>(create: (context) => SendCartCubit()),
                  BlocProvider<SendMessageCubit>(create: (context) => SendMessageCubit(),),
                  BlocProvider<CartCubit>(create: (context) => CartCubit(),),
                ],
                child: MaterialApp(
                  title: "Quakka Mesh App",
                  theme: appTheme(),
                  supportedLocales: S.delegate.supportedLocales,
                  localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  locale: HomeCubit.get(context).isArabic
                      ? const Locale('ar')
                      : const Locale('en'),
                  debugShowCheckedModeBanner: false,
                  initialRoute: userToken == null ? Routes.onBoardingScreen : Routes.homeScreen,
                  onGenerateRoute: appRouter.generateRoute,
                  navigatorKey: navigatorKey,
                  routes: {
                    "/message": (context) => const Message(),
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
