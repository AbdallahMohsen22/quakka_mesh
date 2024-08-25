import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/basic_constants.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import 'package:new_quakka/features/view_mycart_recevied/veiw_mycart_details.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/routing/routes.dart';
import '../../utill/color_resources.dart';
import '../home/home_cubit/home_cubit.dart';
import 'cart_cuibt.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> with SingleTickerProviderStateMixin {
  //final String userId = '9bc345b1-4d0c-4bca-aedf-761d9e53bcb8';
  late TabController _tabController;
  late CartCubit _sentCartCubit;
  late CartCubit _receivedCartCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _sentCartCubit = CartCubit();
    _receivedCartCubit = CartCubit();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 0) {
          _sentCartCubit.fetchSentCarts(userId!);
        } else if (_tabController.index == 1) {
          _receivedCartCubit.fetchReceivedCarts(userId!);
        }
      }
    });

    // Fetch initial data for the first tab
    _sentCartCubit.fetchSentCarts(userId!);
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
          baseColor: ColorResources.apphighlightColor,
          highlightColor: ColorResources.apphighlightColor,
          child: Text(
            HomeCubit.get(context).isArabic
                ? 'الكروت المرسلة والمستقبلة'
                : 'My Cart',
            style:const TextStyle(color: ColorResources.apphighlightColor) ,

          ),
        ),
        bottom: TabBar(
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
      body: MultiBlocProvider(
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
      ),
    );
  }

  Widget _buildCartView(BuildContext context, CartCubit cubit) {
    return BlocBuilder<CartCubit, CartState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartLoaded) {
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
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(cart['titel'] ?? 'No title'),
                    subtitle: Text(cart['receiver'] ?? 'No content'),
                    leading: cart['imageDesign'] != null
                        ? Image.network('http://quokkamesh-001-site1.etempurl.com/${cart['imageDesign']}')
                        : null,
                  ),
                ),
              );
            },
          );
        } else if (state is CartError) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}
