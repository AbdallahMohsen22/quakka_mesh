import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../basic_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/my_validators.dart';
import '../basewidget/custom_textfield.dart';
import '../cart_screen/cart_list_screen.dart';
import '../cart_screen/cart_update_screen.dart';
import '../home/home_cubit/home_cubit.dart';
import '../search_by_username/receiver_model.dart';
import '../search_by_username/search_username_screen.dart';
import 'cuibt.dart';
import 'screenshot_screen.dart'; // Import your ScreenShotScreen



class SendCartScreen extends StatefulWidget {
  final String userId;
  final int cartId;
  final int categoryId;

  SendCartScreen({required this.userId, required this.cartId, required this.categoryId});

  @override
  _SendCartScreenState createState() => _SendCartScreenState();
}

class _SendCartScreenState extends State<SendCartScreen> {
  ReceiverUser? selectedUser;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _senderController = TextEditingController();
  final TextEditingController _receiverController = TextEditingController();

  bool _isPremium = false;

  String getTextUntilSecondSpace(String text) {
    int spaceCount = 0;
    int endIndex = text.length;

    for (int i = 0; i < text.length; i++) {
      if (text[i] == ' ') {
        spaceCount++;
        if (spaceCount == 2) {
          endIndex = i;
          break;
        }
      }
    }

    return text.substring(0, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    String truncatedText = getTextUntilSecondSpace(_receiverController.text);
    return Scaffold(
      appBar: AppBar(
        actions: [
          isAdmin==true?
           ElevatedButton(
              onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateCartScreen(cartId: widget.cartId,)));
                print("${widget.cartId}");
              },
             style: ElevatedButton.styleFrom(
               padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
               backgroundColor: ColorResources.apphighlightColor,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(
                   30,
                 ),
               ),
             ),
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "تحديث الكارت"
                  : "Update Cart",
              style: const TextStyle(
                color: Colors.white,
                  fontSize: 15
              ),
            ),
          ):const SizedBox(),
        ],
        title: Shimmer.fromColors(
          baseColor: ColorResources.apphighlightColor,
          highlightColor: ColorResources.apphighlightColor,
          child: Text(
            HomeCubit.get(context).isArabic
                ? "ارسال كارت"
                : "Send Cart",
          ),
        ),
        leading: InkWell(
          onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> CartListScreen(categoryId: widget.categoryId,)));
          },
          child: const Icon(
              Icons.arrow_back
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              CustomTextField(
                borderRadius: 20,
                borderColor: ColorResources.apphighlightColor,
                hintText: 'Title',
                labelText: 'Title',
                required: true,
                // focusNode: _nameFocusNode,
                // nextFocus: _userNameFocusNode,
                // prefixIcon: AppAssets.user,
                capitalization: TextCapitalization.words,
                inputType: TextInputType.text,
                controller: _titleController,
                validator: (value) {
                  return MyValidators.displayFieldValidator(
                      value);
                },

              ),

              const SizedBox(height: 10,),
              CustomTextField(
                borderRadius: 20,
                borderColor: ColorResources.apphighlightColor,
                hintText: 'Content',
                labelText: 'Content',
                required: true,
                // focusNode: _nameFocusNode,
                // nextFocus: _userNameFocusNode,
                // prefixIcon: AppAssets.user,
                capitalization: TextCapitalization.words,
                inputType: TextInputType.text,
                controller: _contentController,
                validator: (value) {
                  return MyValidators.displayFieldValidator(
                      value);
                },
              ),
              const SizedBox(height: 10,),

              CustomTextField(
                borderRadius: 20,
                borderColor: ColorResources.apphighlightColor,
                hintText: 'Sender',
                labelText: 'Sender',
                required: true,
                // focusNode: _nameFocusNode,
                // nextFocus: _userNameFocusNode,
                // prefixIcon: AppAssets.user,
                capitalization: TextCapitalization.words,
                inputType: TextInputType.name,
                controller: _senderController,
                validator: (value) {
                  return MyValidators.displayNameValidator(
                      value);
                },
              ),
              const SizedBox(height: 10,),

              CustomTextField(
                borderRadius: 20,
                borderColor: ColorResources.apphighlightColor,
                hintText: 'Receiver',
                labelText: 'Receiver',
                required: true,
                // focusNode: _nameFocusNode,
                // nextFocus: _userNameFocusNode,
                // prefixIcon: AppAssets.user,
                capitalization: TextCapitalization.words,
                inputType: TextInputType.name,
                controller: _receiverController,
                validator: (value) {
                  return MyValidators.displayNameValidator(
                      value);
                },
              ),
              const SizedBox(height: 10,),

              // SwitchListTile(
              //   title: Text('Is Premium'),
              //   value: _isPremium,
              //   onChanged: (bool value) {
              //     setState(() {
              //       _isPremium = value;
              //     });
              //   },
              // ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  final user = await Navigator.push<ReceiverUser>(
                    context,
                    MaterialPageRoute(builder: (context) => SearchUserScreen()),
                  );
                  if (user != null) {
                    setState(() {
                      selectedUser = user;
                      _receiverController.text = user.fullName;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 12),
                  backgroundColor: ColorResources.apphighlightColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                ),

                child: Text(selectedUser == null ?
                HomeCubit.get(context).isArabic
                    ? "اختر اسم المرسل اليه"
                    : "Select Receiver" : selectedUser!.fullName.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
                ),
              ),
              const SizedBox(height: 16),
              BlocConsumer<SendCartCubit, SendCartState>(
                listener: (context, state) {
                  if (state is SendCartSuccess) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Shimmer.fromColors(
                            baseColor: ColorResources.appColor,
                            highlightColor: ColorResources.apphighlightColor,
                            child: const Center(
                              child: Text(
                                'Cart Sent Successfully',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          content: Stack(
                            children: [
                              Image.network('http://backend.quokka-mesh.com/' + state.cartData['imageDesign']),
                              // Text('Title: ${_titleController.text}'),
                              // Text('Content: ${_contentController.text}'),
                              // Text('Sender: ${_senderController.text}'),
                              Positioned(
                                  bottom: 10,
                                  right: 20,
                                  child:
                                  Center(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(10),
                                        ),

                                        child: Text(
                                          truncatedText,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Arial', // Customize the font family if needed
                                          shadows: [
                                            Shadow(
                                              blurRadius: 10.0,
                                              color: Colors.black,
                                              offset: Offset(3.0, 3.0),
                                            ),
                                          ],
                                        ),
                                        )
                                    ),
                                  )),
                              // Text('Created: ${DateTime.now().toString()}',maxLines: 1,),
                              // Text('Is Premium: ${state.cartData['isPremium']}'),
                              // Text('Is Active: ${state.cartData['isActive']}'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),

                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScreenShotScreen(
                                      imageDesign: state.cartData['imageDesign'],
                                      receiverName: state.cartData['receiver'],
                                      title: state.cartData['titel'],
                                      content: state.cartData['content'],
                                      sender: state.cartData['sender'],
                                      isPremium: state.cartData['isPremium'],
                                    ),
                                  ),
                                );

                              },
                              child: const Text('Take a screenshot'),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (state is SendCartFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(

                      const SnackBar(content: Text("Cart Is Premium Please Upgrade Your Account")),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SendCartLoading) {
                    return const CircularProgressIndicator();
                  }
          
                  return ElevatedButton(
                    onPressed: selectedUser == null
                        ? null
                        : () {
                      final createdDate = DateTime.now(); // Ensure you use a valid date
                      context.read<SendCartCubit>().sendCart(
                        userId: userId!,
                        receiverId: selectedUser!.id,
                        cartId: widget.cartId,
                        createdDate: createdDate,
                        title: _titleController.text,
                        content: _contentController.text,
                        sender: _senderController.text,
                        receiver: _receiverController.text,
                        isPremium: _isPremium,
                      );
                    },

                    child: const Text(
                        'Send Cart'
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
