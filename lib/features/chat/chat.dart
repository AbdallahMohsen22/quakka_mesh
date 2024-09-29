import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import 'package:shimmer/shimmer.dart';

import '../../basic_constants.dart';
import '../../core/routing/routes.dart';
import '../../utill/color_resources.dart';
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
          baseColor: ColorResources.apphighlightColor,
          highlightColor: ColorResources.apphighlightColor,
          child: Text(
            HomeCubit.get(context).isArabic
                ? 'الدردشة'
                : 'Chat',
            style:const TextStyle(color: ColorResources.apphighlightColor) ,

          ),

        ),
        leading: InkWell(
          onTap: (){
            context.pushNamed(Routes.homeScreen);
          },
          child: const Icon(Icons.arrow_back),
        ),

      ),
      body: userId != null? BlocProvider(
        create: (context) => ChatCubit()..fetchUsers(userId!),
        child: UserListView(),
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
          return const Center(child: CircularProgressIndicator());
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
                  // leading: ClipRRect(
                  //   borderRadius: BorderRadius.circular(30.0),
                  //   child: CachedNetworkImage(
                  //     imageUrl: "http://backend.quokka-mesh.com/${user.imageCover}",
                  //     placeholder: (context, url) => const CircularProgressIndicator(),
                  //     errorWidget: (context, url, error) => const Icon(Icons.person_3_sharp),
                  //     httpHeaders: const {
                  //       ApiConstants.tokenTitle:
                  //       ApiConstants.tokenBody
                  //     },
                  //   ),
                  // ),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('http://backend.quokka-mesh.com/${user.imageCover}'),
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
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}