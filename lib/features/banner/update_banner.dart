import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import 'package:new_quakka/core/routing/routes.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:io';

import '../../core/network/api_constants.dart';
import '../../core/shared_constabts.dart';
import '../../utill/color_resources.dart';
import '../../utill/my_validators.dart';
import '../basewidget/custom_textfield.dart';
import '../home/home_cubit/home_cubit.dart';
import 'banner_cuibt.dart';


class UpdateBannerForm extends StatefulWidget {
  final int bannerId;
  final String initialTitle;
  final String initialImageUrl;

  UpdateBannerForm({
    required this.bannerId,
    required this.initialTitle,
    required this.initialImageUrl,
  });

  @override
  _UpdateBannerFormState createState() => _UpdateBannerFormState();
}

class _UpdateBannerFormState extends State<UpdateBannerForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
  }

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
                  ? "تعديل البانر"
                  : "Update Banner",
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
            BlocConsumer<BannerCubit, BannerState>(
            listener: (context, state) {
              if (state is BannerError) {
                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                Constants.showToast(msg: state.error,
                    gravity: ToastGravity.BOTTOM,
                    color: Colors.red);
              } else if (state is BannerLoaded) {
                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Banner updated successfully')));
                Constants.showToast(msg: 'Banner updated successfully',
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
                            return MyValidators.displayFieldValidator(
                                value);
                          },
                        ),

                        const SizedBox(height: 20),
                        _imageFile != null
                            ? Image.file(_imageFile!)
                            : CachedNetworkImage(
                          imageUrl: widget.initialImageUrl,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.insert_link_outlined,color: Colors.white,),
                          httpHeaders: const {
                            ApiConstants.tokenTitle:
                            ApiConstants.tokenBody
                          },

                        ),
                        const SizedBox(height: 5),
                        TextButton(
                          onPressed: _pickImage,
                          child: Text(
                            HomeCubit.get(context).isArabic
                                ? "التقط صورة"
                                : 'Pick Image',

                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() && _imageFile != null ) {
                                  context.read<BannerCubit>().updateBanner(
                                    widget.bannerId,
                                    _titleController.text,
                                    _imageFile!,
                                  );
                                }else{
                                  Constants.showToast(msg: 'Please pick an image',
                                      gravity: ToastGravity.BOTTOM,
                                      color: Colors.red);
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
                              child: Text(
                                HomeCubit.get(context).isArabic
                                    ? "تحديث البانر"
                                    : 'Update Banner',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                ),

                              ),
                            ),

                            //delete banner
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {
                                context.read<BannerCubit>().deleteBanner(widget.bannerId);
                                context.pushNamed(Routes.homeScreen);

                                Constants.showToast(msg: 'Deleting in progress...',
                                    gravity: ToastGravity.BOTTOM,
                                    color: Colors.green);

                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                                backgroundColor: ColorResources.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                ),
                              ),
                              child: Text(
                                HomeCubit.get(context).isArabic
                                    ? "حذف البانر"
                                    : 'Delete Banner',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                ),

                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

