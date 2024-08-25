import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/shared_constabts.dart';
import '../../utill/color_resources.dart';
import '../../utill/my_validators.dart';
import '../basewidget/custom_textfield.dart';
import '../home/home_cubit/home_cubit.dart';
import 'banner_cuibt.dart';

class AddBannerForm extends StatefulWidget {
  const AddBannerForm({super.key});

  @override
  _AddBannerFormState createState() => _AddBannerFormState();
}

class _AddBannerFormState extends State<AddBannerForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannerCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: ColorResources.apphighlightColor,
            highlightColor: ColorResources.apphighlightColor,
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "اضافة بانر"
                  : "Add Banner",
            ),
          ),
        ),
        body: BlocConsumer<BannerCubit, BannerState>(
          listener: (context, state) {
            if (state is BannerError) {
              //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
              Constants.showToast(msg: state.error,
                  gravity: ToastGravity.BOTTOM,
                  color: Colors.red);
            } else if (state is BannerLoaded) {
              //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Banner added successfully')));
              Constants.showToast(msg: 'Banner added successfully',
                  gravity: ToastGravity.BOTTOM,
                  color: Colors.green);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(

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
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),
                      _imageFile != null
                          ? Image.file(_imageFile!)
                          : TextButton(
                        onPressed: _pickImage,
                        child: const Text('Pick Image'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() && _imageFile != null) {
                            context.read<BannerCubit>().addBanner(
                              _titleController.text,
                              _imageFile!,
                            );
                            context.pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                          backgroundColor: ColorResources.apphighlightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),
                        child:  Text(
                          HomeCubit.get(context).isArabic
                              ? "اضافة البانر"
                              : 'Add Banner',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
