import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import 'package:shimmer/shimmer.dart';

import '../../basic_constants.dart';
import '../../core/helpers/adaptive_indecator.dart';
import '../../core/routing/routes.dart';
import '../../utill/constant.dart';
import '../home/home_cubit/home_cubit.dart';
import '../home/login_widget_chat.dart';
import '../search_by_username/cuibt.dart';
import 'chat_cuibt.dart';
import 'chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.white,
          child: Text(
            HomeCubit.get(context).isArabic
                ? 'الدردشة'
                : 'Chat',
            style:const TextStyle(color: Colors.white) ,

          ),

        ),
        leading: InkWell(
          onTap: (){
            context.pushNamed(Routes.homeScreen);
          },
          child: const Icon(Icons.arrow_back),
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
          // Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   color: const Color(0xFFFFFEBB4).withOpacity(0.8),
          // ),
          BlocProvider(
          create: (context) => ChatCubit()..fetchUsers(userId!),
          child: UserListView(),
        )],
      ) : const LoginWidgetChat(),
    );
  }

  // Widget buildChatItem(ReceiverUser model, context) => InkWell(
  //   onTap: (){
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatDetailsScreen(userModel: model,)));
  //   },
  //   child: Padding(
  //     padding: const EdgeInsets.all(20),
  //     child: Row(
  //       children: [
  //         CircleAvatar(
  //           radius: 25,
  //           backgroundImage: NetworkImage('${model.imageCover}'),
  //         ),
  //         SizedBox(width: 15,),
  //         Text(
  //             '${model.imageCover}',
  //           style: TextStyle(
  //             height: 1.4,
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, UserChatState>(
      listener: (context, state) {
        if (state is UserChatError) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        if (state is UserLoading) {
          return  Center(child: AdaptiveIndicator(os: getOS()));
        } else if (state is UserChatLoaded) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(
                    id: user.id,
                    fullName: user.fullName,
                    image: user.imageCover,) ));
                },
                child: ListTile(

                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('http://backend.quokka-mesh.com/${user.imageCover}'),
                    onBackgroundImageError: (error, stackTrace) {
                      // Handle image loading errors
                    },
                    child: user.imageCover.isEmpty
                        ? const Icon(Icons.person) // Fallback icon if image is null
                        : null,
                  ),
                  title: Text(
                    user.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // subtitle: Text(user.email),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20,),
                    ),
          );
        } else {
          return  Center(child: AdaptiveIndicator(os: getOS()));
        }
      },
    );
  }
}