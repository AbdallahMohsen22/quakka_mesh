import 'package:flutter/material.dart';

import '../../../utill/app_assets.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/custom_themes.dart';
import '../../basewidget/select_language_bottom_sheet.dart';
import 'notification_screen.dart';

class CartWidgetHomePage extends StatelessWidget {
  const CartWidgetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [


        // Padding(
        //   padding: const EdgeInsets.only(right: 12),
        //   child: IconButton(
        //     color: Theme.of(context).primaryColor,
        //     onPressed: () => showModalBottomSheet(backgroundColor: Colors.transparent,
        //         isScrollControlled: true,
        //         context: context, builder: (_)=> const SelectLanguageBottomSheet()),
        //
        //     icon: Stack(clipBehavior: Clip.none, children: [
        //       Icon(Icons.translate),
        //
        //
        //     ]),
        //   ),
        // ),

        IconButton(
          color: Theme.of(context).primaryColor,
          onPressed: () => showModalBottomSheet(backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context, builder: (_)=> const SelectLanguageBottomSheet()),

          icon: Stack(clipBehavior: Clip.none, children: [
            Image.asset(AppAssets.splashLogo, width: 350, height: 200),


          ]),
        ),

        // Consumer(
        //   builder: (context, notificationProvider, _) {
        //     return IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
        //       icon: Stack(clipBehavior: Clip.none, children: [
        //         Image.asset(AppAssets.notification,
        //             height: Dimensions.iconSizeDefault,
        //             width: Dimensions.iconSizeDefault,
        //             color: ColorResources.getPrimary(context)),
        //         Positioned(top: -4, right: -4,
        //           child: CircleAvatar(radius: 7, backgroundColor: ColorResources.red,
        //             child: Text('0',
        //                 style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeExtraSmall,
        //                 )),
        //           ),
        //         ),
        //
        //       ]),
        //     );
        //   }
        // ),

        // Padding(
        //   padding: const EdgeInsets.only(right: 12.0),
        //   child: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
        //     icon: Stack(clipBehavior: Clip.none, children: [
        //       Image.asset(AppAssets.cartArrowDownImage,
        //           height: Dimensions.iconSizeDefault,
        //           width: Dimensions.iconSizeDefault,
        //           color: ColorResources.getPrimary(context)),
        //       // Positioned(top: -4, right: -4,
        //       //   child: Consumer<CartProvider>(builder: (context, cart, child) {
        //       //     return CircleAvatar(radius: 7, backgroundColor: ColorResources.red,
        //       //       child: Text(cart.cartList.length.toString(),
        //       //           style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeExtraSmall,
        //       //           )),
        //       //     );
        //       //   }),
        //       // ),
        //     ]),
        //   ),
        // ),
      ],
    );
  }
}
