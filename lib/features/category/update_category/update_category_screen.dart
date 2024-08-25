import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_quakka/features/cart_screen/update_cart_cuibt.dart';
import 'package:new_quakka/features/category/update_category/update_cuibt.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/shared_constabts.dart';
import '../../../utill/color_resources.dart';
import '../../basewidget/custom_textfield.dart';
import '../../home/home_cubit/home_cubit.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final int categoryId;

  UpdateCategoryScreen({required this.categoryId});

  @override
  _UpdateCategoryScreenState createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  File? _imageDesign;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _titleController.dispose();

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
      create: (context) => UpdateCategoryCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: ColorResources.apphighlightColor,
            highlightColor: ColorResources.apphighlightColor,
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "تحديث القسم"
                  : "Update Category",
            ),
          ),
        ),
        body: BlocConsumer<UpdateCategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is CategoryUpdated) {
              //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              Constants.showToast(msg: 'Category is updated successfully',
                  gravity: ToastGravity.BOTTOM,
                  color: Colors.green);
              Navigator.pop(context);
            } else if (state is CategoryUpdateError) {
              //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
              Constants.showToast(msg: "Failed to update the category",
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
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && _imageDesign != null) {
                          context.read<UpdateCategoryCubit>().updateCategory(
                            id: widget.categoryId,
                            title: _titleController.text,
                            image: _imageDesign!,

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
                            ? "تحديث القسم"
                            : 'Update Category',
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
