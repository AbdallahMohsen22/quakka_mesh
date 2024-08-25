import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/shared_constabts.dart';
import '../../utill/color_resources.dart';
import '../../utill/my_validators.dart';
import '../basewidget/custom_textfield.dart';
import '../home/home_cubit/home_cubit.dart';
import 'cuibt.dart';
import 'model_add_category.dart';


class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController titleController = TextEditingController();
  XFile? image;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: ColorResources.apphighlightColor,
            highlightColor: ColorResources.apphighlightColor,
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "اضافة قسم"
                  : "Add Category",
            ),
          ),
        ),
        body: BlocConsumer<AddCategoryCubit, AddCategoryState>(
          listener: (context, state) {
            if (state is AddCategorySuccess) {
              Constants.showToast(msg: 'Category added successfully',
                  gravity: ToastGravity.BOTTOM,
                  color: Colors.green);

              Navigator.pop(context);
            } else if (state is AddCategoryFailure) {
              Constants.showToast(msg: 'Failed to add Category',
                  gravity: ToastGravity.BOTTOM,
                  color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is AddCategoryLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
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
                    // TextField(
                    //   controller: titleController,
                    //   decoration: InputDecoration(labelText: 'Title'),
                    // ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: pickImage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        backgroundColor: ColorResources.apphighlightColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                      ),
                      child: Text(
                        HomeCubit.get(context).isArabic
                            ? "التقط صورة"
                            : 'Pick Image',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                      ),
                    ),
                    if (image != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Image.file(File(image!.path)),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        backgroundColor: ColorResources.apphighlightColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                      ),
                      child: Text(
                        HomeCubit.get(context).isArabic
                            ? "اضافة قسم"
                            : 'Add Category',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        if (image != null && titleController.text.isNotEmpty) {
                          final request = AddCategoryModel(
                            title: titleController.text,
                            image: image!,
                          );
                          context.read<AddCategoryCubit>().addCategory(request);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select an image and enter title')),
                          );
                        }
                      },
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     if (image != null && titleController.text.isNotEmpty) {
                    //       final request = AddCategoryModel(
                    //         title: titleController.text,
                    //         image: image!,
                    //       );
                    //       context.read<AddCategoryCubit>().addCategory(request);
                    //     } else {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(content: Text('Please select an image and enter title')),
                    //       );
                    //     }
                    //   },
                    //   child: Text('Add Category'),
                    // ),
                    if (state is AddCategoryFailure) ...[
                      SizedBox(height: 10),
                      Text(
                        state.error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ]
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
