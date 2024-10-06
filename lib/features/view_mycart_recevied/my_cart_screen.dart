import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/basic_constants.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import 'package:new_quakka/features/view_mycart_recevied/veiw_mycart_details.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/helpers/adaptive_indecator.dart';
import '../../core/routing/routes.dart';
import '../../utill/color_resources.dart';
import '../../utill/constant.dart';
import '../home/home_cubit/home_cubit.dart';
import '../home/login_widget_cart.dart';
import 'cart_cuibt.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late CartCubit _sentCartCubit;
  late CartCubit _receivedCartCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _sentCartCubit = CartCubit();
    _receivedCartCubit = CartCubit();

    if (userId != null) {
      _sentCartCubit.fetchSentCarts(userId!);

      _tabController.addListener(() {
        if (_tabController.indexIsChanging) {
          if (_tabController.index == 0) {
            _sentCartCubit.fetchSentCarts(userId!);
          } else if (_tabController.index == 1) {
            _receivedCartCubit.fetchReceivedCarts(userId!);
          }
        }
      });
    } else {

      const LoginWidgetCart();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _sentCartCubit.close();
    _receivedCartCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              context.pushNamed(Routes.homeScreen);
            },
            child: const Icon(Icons.arrow_back)
        ),
        title: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.white,
          child: Text(
            HomeCubit.get(context).isArabic
                ? 'الكروت المرسلة والمستقبلة'
                : 'My Cart',
            style:const TextStyle(color: Colors.white) ,

          ),
        ),
        bottom: TabBar(
          labelColor:  ColorResources.chatIconColor,
          indicatorColor: ColorResources.apphighlightColor,
          indicatorWeight: 5,
          dividerColor: ColorResources.apphighlightColor,
          unselectedLabelColor: ColorResources.chatIconColor,
          dividerHeight: 2,
          controller: _tabController,
          tabs: [
            Tab(text: HomeCubit.get(context).isArabic
                ? 'المرسلة'
                : 'Sent',
            ),
            Tab(text: HomeCubit.get(context).isArabic
                ? 'المستقبلة'
                : 'Received',),
          ],
        ),
      ),
      body: userId != null?
      Stack(
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
            BlocProvider<CartCubit>.value(value: _sentCartCubit),
            BlocProvider<CartCubit>.value(value: _receivedCartCubit),
          ],
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildCartView(context, _sentCartCubit),
              _buildCartView(context, _receivedCartCubit),
            ],
          ),
        )],
      ) : const LoginWidgetCart(),
    );
  }

  Widget _buildCartView(BuildContext context, CartCubit cubit) {
    return BlocBuilder<CartCubit, CartState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is CartLoading) {
          return  Center(child: AdaptiveIndicator(os: getOS()));
        } else if (state is CartLoaded) {
          if (state.carts.isEmpty) {
            return Center(
              child: Text(
                HomeCubit.get(context).isArabic
                    ? 'لا توجد كروت هنا'
                    : 'No carts here',
                style: const TextStyle(
                  fontSize: 20,
                  color: ColorResources.apphighlightColor,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.carts.length,
            itemBuilder: (context, index) {
              final cart = state.carts[index];
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      ViewMyCartDetails(
                        imageDesign: cart['imageDesign'],
                        receiverName: cart['receiver'] ?? 'No content',
                        title: cart['titel'] ?? 'No title',
                        content: cart['content'] ?? 'No content',
                        sender: cart['sender'] ?? 'No content',
                        //isPremium: state.cartData['isPremium'],

                      )));
                },
                child: Card(
                  color: ColorResources.apphighlightColor,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                        cart['titel'] ?? 'No title',
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                        cart['receiver'] ?? 'No content',
                        style: const TextStyle(color: Colors.white)
                    ),
                    leading: cart['imageDesign'] != null
                        ? Image.network('http://backend.quokka-mesh.com/${cart['imageDesign']}')
                        : null,
                  ),
                ),
              );
            },
          );
        } else if (state is CartError) {
          return const Center(child: Text('Error: please check your connection'));
        } else {
          return const Center(child: Text('please check your connection'));
        }
      },
    );
  }
}
