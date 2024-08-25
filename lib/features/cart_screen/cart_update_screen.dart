import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_quakka/features/cart_screen/update_cart_cuibt.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/shared_constabts.dart';
import '../../utill/color_resources.dart';
import '../basewidget/custom_textfield.dart';
import '../home/home_cubit/home_cubit.dart';

class UpdateCartScreen extends StatefulWidget {
  final int cartId;

  UpdateCartScreen({required this.cartId});

  @override
  _UpdateCartScreenState createState() => _UpdateCartScreenState();
}

class _UpdateCartScreenState extends State<UpdateCartScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _senderController = TextEditingController();
  final _receiverController = TextEditingController();
  final _contentController = TextEditingController();
  final _numberOfPointController = TextEditingController();
  bool _isPremium = false;
  File? _imageDesign;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _titleController.dispose();
    _senderController.dispose();
    _receiverController.dispose();
    _contentController.dispose();
    _numberOfPointController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageDesign = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateCartCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: ColorResources.apphighlightColor,
            highlightColor: ColorResources.apphighlightColor,
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "تحديث الكارت"
                  : "Update Cart",
            ),
          ),
        ),
        body: BlocConsumer<UpdateCartCubit, CartState>(
          listener: (context, state) {
            if (state is CartUpdated) {
              //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              Constants.showToast(msg: state.message,
                  gravity: ToastGravity.BOTTOM,
                  color: Colors.green);
              Navigator.pop(context);
            } else if (state is CartUpdateError) {
              //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
              Constants.showToast(msg: "Failed to update the cart",
                  gravity: ToastGravity.BOTTOM,
                  color: Colors.red);
            }
          },
          builder: (context, state) {

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      _imageDesign == null
                          ? TextButton(
                        onPressed: _pickImage,
                        child: const Text('Pick Image'),
                      )
                          : Image.file(_imageDesign!),

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
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
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
                          if (value == null || value.isEmpty) {
                            return 'Please enter content';
                          }
                          return null;
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
                          if (value == null || value.isEmpty) {
                            return 'Please enter a sender';
                          }
                          return null;
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
                          if (value == null || value.isEmpty) {
                            return 'Please enter a receiver';
                          }
                          return null;
                        },
                      ),


                      const SizedBox(height: 10,),
                      CustomTextField(
                        borderRadius: 20,
                        borderColor: ColorResources.apphighlightColor,
                        hintText: 'Number of Points',
                        labelText: 'Number of Points',
                        required: true,
                        // focusNode: _nameFocusNode,
                        // nextFocus: _userNameFocusNode,
                        // prefixIcon: AppAssets.user,
                        //capitalization: TextCapitalization.words,
                        inputType: TextInputType.number,
                        controller: _numberOfPointController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a number of points';
                          }
                          return null;
                        },
                      ),

                      SwitchListTile(
                        title: const Text('Is Premium'),
                        value: _isPremium,
                        onChanged: (bool value) {
                          setState(() {
                            _isPremium = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      if (state is CartUpdateError)
                        Text(
                          state.error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() && _imageDesign != null) {
                            final createdDate = DateTime.now();
                            context.read<UpdateCartCubit>().updateCart(
                              id: widget.cartId,
                              title: _titleController.text,
                              imageDesign: _imageDesign!,
                              sender: _senderController.text,
                              receiver: _receiverController.text,
                              content: _contentController.text,
                              created: createdDate,
                              numberOfPoint: int.parse(_numberOfPointController.text),
                              isPremium: _isPremium,
                            );
                          }else{
                            Constants.showToast(msg: "Please pick an image and complete all data",
                                gravity: ToastGravity.BOTTOM,
                                color: Colors.red);
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
                        child: Text(
                            HomeCubit.get(context).isArabic
                                ? "تحديث الكارت"
                                : 'Update Cart',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white
                          ),

                        ),

                      ),
                    ],
                  ),
                ),
              );

          },
        ),
      ),
    );
  }
}
