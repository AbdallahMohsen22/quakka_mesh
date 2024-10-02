import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../utill/color_resources.dart';
import '../home/home_cubit/home_cubit.dart';
import 'category_count_cubit.dart';
import 'cart_count_cubit.dart';
import 'count_all_user_cuibt.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Shimmer.fromColors(
          baseColor: ColorResources.apphighlightColor,
          highlightColor: ColorResources.apphighlightColor,
          child: Text(
            HomeCubit.get(context).isArabic
                ? "الاحصاءات"
                : "Dashboard",
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,

          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFFFFEBB4).withOpacity(0.8),
          ),
          MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UserCountCubit()..fetchUserCount(),
            ),
            BlocProvider(
              create: (context) => CategoryCountCubit()..fetchCategoryCount(),
            ),
            BlocProvider(
              create: (context) => CartCountCubit()..fetchCartCount(),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildCountCard<UserCountCubit, UserCountState>(
                    context,
                    title: 'Number of Users',
                    loadingText: 'Loading user count...',
                    errorText: 'Error loading user count',
                    builder: (state) {
                      if (state is UserCountLoaded) {
                        return Center(
                          child: Text(
                            '${state.userCount}',
                            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  SizedBox(height: 20),
                  _buildCountCard<CategoryCountCubit, CategoryCountState>(
                    context,
                    title: 'Number of Categories',
                    loadingText: 'Loading category count...',
                    errorText: 'Error loading category count',
                    builder: (state) {
                      if (state is CategoryCountLoaded) {
                        return Center(
                          child: Text(
                            '${state.categoryCount}',
                            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  SizedBox(height: 20),
                  _buildCountCard<CartCountCubit, CartCountState>(
                    context,
                    title: 'Number of Carts',
                    loadingText: 'Loading cart count...',
                    errorText: 'Error loading cart count',
                    builder: (state) {
                      if (state is CartCountLoaded) {
                        return Center(
                          child: Text(
                            '${state.cartCount}',
                            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        )],
      ),
    );
  }

  Widget _buildCountCard<C extends Cubit<S>, S extends Object>(
      BuildContext context, {
        required String title,
        required String loadingText,
        required String errorText,
        required Widget Function(S state) builder,
      }) {
    return BlocBuilder<C, S>(
      builder: (context, state) {
        return Card(
          color: ColorResources.appColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600,color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                if (state is UserCountLoading || state is CategoryCountLoading || state is CartCountLoading)
                  Center(child: CircularProgressIndicator())
                else if (state is UserCountError || state is CategoryCountError || state is CartCountError)
                  Text(
                    errorText,
                    style: TextStyle(color: Colors.red),
                  )
                else
                  builder(state),
              ],
            ),
          ),
        );
      },
    );
  }
}
