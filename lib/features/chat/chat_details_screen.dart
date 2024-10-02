import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_quakka/features/chat/send_massege_cuibt.dart';
import '../../basic_constants.dart';
import '../../utill/color_resources.dart';
import 'model/chat_model.dart';


class ChatDetailsScreen extends StatefulWidget {
  final String id;
  final String fullName;
  final String image;

  ChatDetailsScreen({required this.id, required this.fullName, required this.image});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController messageController = TextEditingController();

  final AudioPlayer _audioPlayer = AudioPlayer();

  void playSendMessageSound() async {
    await _audioPlayer.play(AssetSource('sounds/send_message_sound.wav'));
  }

  @override
  void initState() {
    super.initState();
    context.read<SendMessageCubit>().getMessages(receiverId: widget.id);
  }


  @override
  Widget build(BuildContext context) {
    context.read<SendMessageCubit>().getMessages(receiverId: widget.id);

    return BlocConsumer<SendMessageCubit, SendMessageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            elevation: 5,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundImage: NetworkImage('http://backend.quokka-mesh.com/${widget.image}'),
                  onBackgroundImageError: (error, stackTrace) {
                    // Handle image loading errors
                  },
                  child: widget.image.isEmpty
                      ? const Icon(Icons.person) // Fallback icon if image is null
                      : null,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    widget.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
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

              ConditionalBuilder(
              condition: context.read<SendMessageCubit>().messages.isNotEmpty,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        //reverse: true,
                        itemBuilder: (context, index) {
                          var message = context.read<SendMessageCubit>().messages[index];
                          if (userId == message.senderId) {
                            return buildMyMessage(message);
                          } else {
                            return buildMessage(message);
                          }
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 15),
                        itemCount: context.read<SendMessageCubit>().messages.length,
                        physics: const BouncingScrollPhysics(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Divider(
                      thickness: 1,
                      color: ColorResources.apphighlightColor,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.image),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                            if (pickedFile != null) {
                              context.read<SendMessageCubit>().sendImage(
                                receiverId: widget.id,
                                dateTime: DateTime.now().toString(),
                                imageUrl: pickedFile.path, // Update this to upload image and get URL
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.emoji_emotions),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return BlocProvider.value(
                                  value: context.read<SendMessageCubit>(),
                                  child: StickerPicker(
                                    onStickerSelected: (stickerUrl) {
                                      context.read<SendMessageCubit>().sendSticker(
                                        receiverId: widget.id,
                                        dateTime: DateTime.now().toString(),
                                        stickerUrl: stickerUrl,
                                      );
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your message here...',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send, color: ColorResources.apphighlightColor),
                          onPressed: () {
                            final message = messageController.text.toString();
                            if (message.isNotEmpty) {
                              context.read<SendMessageCubit>().sendMessage(
                                receiverId: widget.id,
                                dateTime: DateTime.now().toString(),
                                text: message,
                              );
                              messageController.clear();

                              playSendMessageSound(); // Play the sound here
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              fallback: (context) =>
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 100),
                            child: Image.asset("assets/images/start_chatting.png")
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 100),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.image),
                                  onPressed: () async {
                                    final picker = ImagePicker();
                                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                    if (pickedFile != null) {
                                      context.read<SendMessageCubit>().sendImage(
                                        receiverId: widget.id,
                                        dateTime: DateTime.now().toString(),
                                        imageUrl: pickedFile.path, // Update this to upload image and get URL
                                      );
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.emoji_emotions),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return BlocProvider.value(
                                          value: context.read<SendMessageCubit>(),
                                          child: StickerPicker(
                                            onStickerSelected: (stickerUrl) {
                                              context.read<SendMessageCubit>().sendSticker(
                                                receiverId: widget.id,
                                                dateTime: DateTime.now().toString(),
                                                stickerUrl: stickerUrl,
                                              );
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type your message here...',
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.send, color: ColorResources.apphighlightColor),
                                  onPressed: () {
                                    final message = messageController.text.toString();
                                    if (message.isNotEmpty) {
                                      context.read<SendMessageCubit>().sendMessage(
                                        receiverId: widget.id,
                                        dateTime: DateTime.now().toString(),
                                        text: message,
                                      );
                                      messageController.clear();

                                      playSendMessageSound(); // Play the sound here
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
            )],
          ),
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration:  BoxDecoration(
        color:  model.stickerUrl != null ?const Color(0xffffffff): const Color(0xffd8c1a3),
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (model.text != null)
            Text(model.text!,style: const TextStyle(color: Colors.white),),
          if (model.imageUrl != null)
            Image.file(File(model.imageUrl!)),
          if (model.stickerUrl != null)
            Image.asset(model.stickerUrl!,fit: BoxFit.cover,width: 100,height: 100,), // Assuming stickers are hosted online
        ],
      ),
    ),
  );

  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration:  BoxDecoration(
        color: model.stickerUrl != null ?const Color(0xFFFFFEBB4): const Color(0xFF3e1a24),
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (model.text != null)
            Text(model.text!,style: const TextStyle(color: Colors.white),),
          if (model.imageUrl != null)
            Image.file(File(model.imageUrl!)),
          if (model.stickerUrl != null)
            Image.asset(model.stickerUrl!,fit: BoxFit.cover,width: 100,height: 100,), // Assuming stickers are hosted online
        ],
      ),
    ),
  );
}

class StickerPicker extends StatelessWidget {
  final Function(String) onStickerSelected;

  StickerPicker({required this.onStickerSelected});

  final AudioPlayer _audioPlayer = AudioPlayer();

  void playSendMessageSound() async {
    await _audioPlayer.play(AssetSource('sounds/send_message_sound.wav'));
  }

  @override
  Widget build(BuildContext context) {
    // Assume you have a list of sticker URLs
    List<String> stickerUrls = [
      // 'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg',
      // 'https://lf16-tiktok-web.tiktokcdn-us.com/obj/tiktok-web-tx/ies/tiktok/sticker-set-creation/static/media/07_tuwogc_sadnesslay.fef1da707d811581c52a.png',
      // 'https://lf16-tiktok-web.tiktokcdn-us.com/obj/tiktok-web-tx/ies/tiktok/sticker-set-creation/static/media/07_tuwogc_sadnesslay.fef1da707d811581c52a.png',
      'assets/images/1.png',
      'assets/images/2.png',
      'assets/images/3.png',
      'assets/images/4.png',
      'assets/images/5.png',
      'assets/images/6.png',
      'assets/images/7.png',
      'assets/images/8.png',
      'assets/images/9.png',
      'assets/images/10.png',
      'assets/images/11.png',
      'assets/images/12.png',
      'assets/images/13.png',
      'assets/images/14.png',
      'assets/images/15.png',
      'assets/images/16.png',
      'assets/images/17.png',
      'assets/images/18.png',
      'assets/images/19.png',
      'assets/images/20.png',
      'assets/images/21.png',
      'assets/images/22.png',
      'assets/images/23.png',


      // Add more sticker URLs
    ];

    return BlocProvider(
      create: (context) => SendMessageCubit(),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5
        ),
        itemCount: stickerUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onStickerSelected(stickerUrls[index]);
              playSendMessageSound(); // Play the sound here
            },
            //child: CachedNetworkImage(imageUrl: stickerUrls[index]),
            child: Image.asset(stickerUrls[index]),
          );
        },
      ),
    );
  }
}
