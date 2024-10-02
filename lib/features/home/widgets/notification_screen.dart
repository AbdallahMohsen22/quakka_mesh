import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/routing/routes.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../home_cubit/home_cubit.dart';

class NotificationScreen extends StatelessWidget {

   NotificationScreen({super.key,});
  static const route = 'notification-screen';
  // final RemoteMessage message;

  //ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage?;
    //FirebaseNotifications message = FirebaseNotifications();


    return Scaffold(
      appBar: AppBar(
        title: Shimmer.fromColors(
          baseColor: ColorResources.apphighlightColor,
          highlightColor: ColorResources.apphighlightColor,
          child: Text(
            HomeCubit.get(context).isArabic
                ? "الاشعارات"
                : 'Notifications',
          ),
        ),
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: (){
            context.pushNamed(Routes.homeScreen);
          },
        ),
      ),


      body: Center(
        child: Column(
          children: [


            Text("${message?.notification!.title}"),
            Text("${message?.notification!.body}"),
          ],
        ),
      ),

      // body: message ==null? Center(
      //   child: Container(
      //     margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      //     color: Theme.of(context).cardColor,
      //     child: Image.asset(AppAssets.noNotification,
      //       //color: ColorResources.apphighlightColor,
      //     ),
      //
      //     ),
      // ): ListTile(
      //   leading: Stack(children: [
      //     ClipRRect(borderRadius: BorderRadius.circular(40),
      //       child: Container(decoration: BoxDecoration(
      //           border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.15), width: .35),
      //           borderRadius: BorderRadius.circular(40)),
      //         child: CustomImage(width: 50,height: 50,
      //             image: '${AppAssets.noNotification}'),
      //       ),),
      //     CircleAvatar(backgroundColor: Theme.of(context).colorScheme.error.withOpacity(.75),radius: 3)
      //   ],
      //   ),
      //   title: Text('${message.notification?.title}',
      //       style: titilliumRegular.copyWith(
      //         fontSize: Dimensions.fontSizeSmall,
      //       )),
      //
      // ),
      );
  }
}

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          color: ColorResources.getGrey(context),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            // enabled: Provider.of<NotificationProvider>(context).notificationModel == null,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorResources.white),
              subtitle: Container(height: 10, width: 50, color: ColorResources.white),
            ),
          ),
        );
      },
    );
  }
}

