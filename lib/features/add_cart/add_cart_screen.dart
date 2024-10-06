import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/routing/routes.dart';
import '../../core/shared_constabts.dart';
import '../../utill/color_resources.dart';
import '../../utill/my_validators.dart';
import '../basewidget/custom_textfield.dart';
import '../home/home_cubit/home_cubit.dart';
import 'cart_model.dart';
import 'cuibt.dart';


class AddCartScreen extends StatefulWidget {
  final int? categoryId;

  AddCartScreen({ this.categoryId});

  @override
  _AddCartScreenState createState() => _AddCartScreenState();
}

class _AddCartScreenState extends State<AddCartScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController senderController = TextEditingController();
  final TextEditingController receiverController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController createdController = TextEditingController();
  final TextEditingController numberOfPointsController = TextEditingController();
  bool isPremium = false;
  XFile? imageDesign;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageDesign = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCartCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.white,
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "اضافة كارت"
                  : "Add Cart",
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
            BlocConsumer<AddCartCubit, AddCartState>(
            listener: (context, state) {
              if (state is AddCartSuccess) {
                Constants.showToast(msg: 'Cart added successfully',
                    gravity: ToastGravity.BOTTOM,
                    color: Colors.green);

                Navigator.pushNamed(context,Routes.homeScreen);

              } else if (state is AddCartFailure) {
                Constants.showToast(msg: 'Failed to add Cart',
                    gravity: ToastGravity.BOTTOM,
                    color: Colors.red);

              }
            },
            builder: (context, state) {
              if (state is AddCartLoading) {
                return  Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                          backgroundColor: ColorResources.apphighlightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),
                        onPressed: pickImage,
                        child: Text(
                          HomeCubit.get(context).isArabic
                              ? "التقط صورة"
                              : 'Pick Image ',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white
                          ),

                        ),
                      ),
                      if (imageDesign != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Image.file(File(imageDesign!.path)),
                        ),
                      const SizedBox(height: 20),
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
                        controller: titleController,
                        validator: (value) {
                          return MyValidators.displayFieldValidator(
                              value);
                        },
                      ),
                      const SizedBox(height: 20),

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
                        controller: senderController,
                        validator: (value) {
                          return MyValidators.displayFieldValidator(
                              value);
                        },
                      ),
                      const SizedBox(height: 20),

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
                        controller: receiverController,
                        validator: (value) {
                          return MyValidators.displayFieldValidator(
                              value);
                        },
                      ),
                      const SizedBox(height: 20),

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
                        controller: contentController,
                        validator: (value) {
                          return MyValidators.displayFieldValidator(
                              value);
                        },
                      ),
                      const SizedBox(height: 20),

                      CustomTextField(
                        borderRadius: 20,
                        borderColor: ColorResources.apphighlightColor,
                        hintText: 'Created (e.g., 2-2-2024)',
                        labelText: "Today date",
                        required: true,
                        // focusNode: _nameFocusNode,
                        // nextFocus: _userNameFocusNode,
                        // prefixIcon: AppAssets.user,
                        capitalization: TextCapitalization.words,
                        inputType: TextInputType.datetime,
                        controller: createdController,
                        validator: (value) {
                          return MyValidators.displayFieldValidator(
                              value);
                        },
                      ),
                      const SizedBox(height: 20),

                      CustomTextField(
                        borderRadius: 20,
                        borderColor: ColorResources.apphighlightColor,
                        hintText: 'Number of Points',
                        labelText: 'Number of Points',
                        required: true,
                        // focusNode: _nameFocusNode,
                        // nextFocus: _userNameFocusNode,
                        // prefixIcon: AppAssets.user,
                        capitalization: TextCapitalization.words,
                        inputType: TextInputType.number,
                        controller: numberOfPointsController,
                        // validator: (value) {
                        //   return MyValidators.displayFieldValidator(
                        //       value);
                        // },
                      ),
                      const SizedBox(height: 20),

                      CheckboxListTile(
                        title: const Text(
                            'Is Premium',
                          style: TextStyle(
                              fontSize: 20,
                              color: ColorResources.apphighlightColor
                          ),
                        ),
                        value: isPremium,
                        onChanged: (newValue) {
                          setState(() {
                            isPremium = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 10),

                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (imageDesign != null && titleController.text.isNotEmpty &&
                              senderController.text.isNotEmpty &&
                              receiverController.text.isNotEmpty&&
                              contentController.text.isNotEmpty &&
                              createdController.text.isNotEmpty
                          )
                          {
                            final request = AddCartModel(
                              title: titleController.text,
                              imageDesign: imageDesign!,
                              sender: senderController.text,
                              receiver: receiverController.text,
                              content: contentController.text,
                              created: createdController.text,
                              numberOfPoints: int.parse(numberOfPointsController.text),
                              isPremium: isPremium,
                            );
                            context.read<AddCartCubit>().addCart(request, widget.categoryId!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                  HomeCubit.get(context).isArabic
                                      ? "من فضلك اكمل البيانات"
                                      : 'Please select an image and complete data',

                              )),
                            );
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
                              ? "اضافة كارت"
                              : "Add Cart",
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                        ),

                      ),

                      if (state is AddCartFailure) ...[
                        const SizedBox(height: 10),
                        Text(
                          state.error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ]
                    ],
                  ),
                ),
              );
            },
          )],
        ),
      ),
    );
  }
}
