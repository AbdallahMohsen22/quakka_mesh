import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import 'package:shimmer/shimmer.dart';

import '../../basic_constants.dart';
import '../../core/network/api_constants.dart';
import '../../core/routing/routes.dart';
import '../../generated/l10n.dart';
import '../../utill/app_assets.dart';
import '../../utill/color_resources.dart';
import '../../utill/constant.dart';
import '../../utill/my_validators.dart';
import '../auth/widgets/pick_image_widget.dart';
import '../basewidget/custom_textfield.dart';
import '../home/home_cubit/home_cubit.dart';
import '../home/home_screen.dart';
import 'cuibt/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool _isAdmin = false;
  File? _imageCover;

  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _phoneFocusNode,
      _userNameFocusNode,
      _passwordFocusNode;
  bool obscureText = true;
  bool isLoading = false;


  // @override
  // void initState() {
  //   super.initState();
  //   final profileCubit = context.read<ProfileCubit>().state;
  //   _fullNameController.text = profileCubit.fullName;
  //   _usernameController.text = profileCubit.username;
  //   _emailController.text = profileCubit.email;
  //   _passwordController.text = profileCubit.password;
  //   _phoneNumberController.text = profileCubit.phoneNumber;
  //   _isAdmin = profileCubit.isAdmin;
  //   _imageCover = profileCubit.imageCover;
  // }
  //
  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _userNameController.dispose();
  //   // Focus Nodes
  //   _nameFocusNode.dispose();
  //   _emailFocusNode.dispose();
  //   _passwordFocusNode.dispose();
  //   _userNameFocusNode.dispose();
  //   super.dispose();
  // }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageCover = File(pickedFile.path);
      }
    });
  }

  // Future<void> localImagePicker(context) async {
  //   final ImagePicker picker = ImagePicker();
  //   await Constants.imagePickerDialog(
  //     context: context,
  //     cameraFCT: () async {
  //       _pickedImage = await picker.pickImage(source: ImageSource.camera);
  //       setState(() {
  //
  //       });
  //     },
  //     galleryFCT: () async {
  //       _pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //       setState(() {});
  //     },
  //     removeFCT: () {
  //       setState(() {
  //         _pickedImage = null;
  //       });
  //     },
  //
  //   );
  // }

  // //Api call
  // void updateProfile(BuildContext context) async {
  //   String fullName = _nameController.text.trim();
  //   String userName = _userNameController.text.trim();
  //   String email = _emailController.text.trim();
  //   String password = _passwordController.text.trim();
  //   String phone = _phoneController.text.trim();
  //
  //   // Validate inputs
  //   if (email.isEmpty || password.isEmpty ||fullName.isEmpty||userName.isEmpty||phone.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please complete all fields')),
  //     );
  //     return;
  //   }
  //
  //   var headers = {
  //     ApiConstants.contentTypeTitle: ApiConstants.contentTypeBody,
  //     ApiConstants.tokenTitle: ApiConstants.tokenBody
  //   };
  //   // Request body as JSON
  //   // Map<String, String> body = {
  //   //   'Email':_emailController.text.trim(),
  //   //   'Password': _passwordController.text.trim(),
  //   // };
  //
  //   // Encode body to JSON
  //   // String bodyJson = json.encode(body);
  //
  //   var data = FormData.fromMap({
  //     'FullName': fullName,
  //     'Username': userName,
  //     'Email': email,
  //     'Password': password,
  //     'Phonenumber': phone,
  //     'image': _pickedImage,
  //   });
  //   // Send POST request
  //   var dio = Dio();
  //   try {
  //     print("API Call=====>>>> ");
  //     var response = await dio.request(
  //       '${ApiConstants.baseUrl}${ApiConstants.updateSubProfile}/9ddb91d5-9437-4b9f-8b38-2b2c5b104390',
  //       options: Options(
  //         method: 'PUT',
  //         headers: headers,
  //       ),
  //       data: data,
  //     );
  //
  //     // Check response status
  //     if (response.statusCode == 200) {
  //
  //       Navigator.push(context, MaterialPageRoute(
  //         builder: (context) => const HomeScreen(),));
  //       print("API Response====>>> Profile Updated");
  //       print("API Response====>>> ${response.data}");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Profile updated successfully')),
  //       );
  //     } else {
  //       // Show error message
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Update failed')),
  //       );
  //       print("API Response====>>>${response.statusCode}");
  //     }
  //   } catch (e) {
  //     // Exception occurred
  //     if (e is DioException) {
  //       if (e.response!.statusCode == 400) {
  //         // Handle the 400 error explicitly
  //         print('API Response=====>>>>${e.response!.data['messages']}');
  //         Constants.showToast(msg: e.response!.data['messages'],
  //             gravity: ToastGravity.BOTTOM,
  //             color: Colors.red);
  //       } else {
  //         // Handle other errors
  //         print('Error: ${e.message}');
  //         Constants.showToast(msg:e.message!,
  //             gravity: ToastGravity.BOTTOM,
  //             color: Colors.red);
  //       }
  //     }
  //   }
  // }

  Future<int> fetchUserPoints(String userId) async {
    final url = 'http://quokkamesh-001-site1.etempurl.com/api/Statistics/User/UserPoint?userId=$userId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['numbers'];
    } else {
      throw Exception('Failed to load user points');
    }
  }

  @override
  Widget build(BuildContext context) {


    // return BlocProvider(
        //   create: (context) => ProfileCubit(),
        //   child: Scaffold(
        //     backgroundColor: ColorResources.white,
        //     body: SingleChildScrollView(
        //       padding: EdgeInsets.all(16.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //
        //           SizedBox(height: 30,),
        //           SizedBox(
        //             height: 150,
        //             width: 150,
        //             child: PickImageWidget(
        //               pickedImage: _pickedImage,
        //               function: () async {
        //                 await localImagePicker(context);
        //               },
        //             ),
        //           ),
        //
        //           FutureBuilder<int>(
        //             future: fetchUserPoints(userId!),
        //             builder: (context, snapshot) {
        //               if (snapshot.connectionState == ConnectionState.waiting) {
        //                 return CircularProgressIndicator();
        //               } else if (snapshot.hasError) {
        //                 return Text('Error: ${snapshot.error}');
        //               } else {
        //                 return Text(
        //                   HomeCubit.get(context).isArabic
        //                       ? 'My Points: ${snapshot.data}'
        //                       : 'My Points: ${snapshot.data}',
        //                   style:TextStyle(color: ColorResources.appColor) ,
        //
        //                 );
        //               }
        //             },
        //           ),
        //
        //           SizedBox(height: 8,),
        //           CustomTextField(
        //             hintText: 'Full name',
        //             labelText: 'Full name',
        //             inputType: TextInputType.name,
        //             // required: true,
        //             focusNode: _nameFocusNode,
        //             nextFocus: _userNameFocusNode,
        //             prefixIcon: AppAssets.user,
        //             capitalization: TextCapitalization.words,
        //             controller: _fullNameController,
        //             validator: (value) {
        //               return MyValidators.displayNameValidator(
        //                   value);
        //             },
        //           ),
        //           const SizedBox(
        //             height: 16.0,
        //           ),
        //
        //           CustomTextField(
        //             hintText: 'User name',
        //             labelText: 'User name',
        //             inputType: TextInputType.name,
        //             // required: true,
        //             focusNode: _userNameFocusNode,
        //             nextFocus: _emailFocusNode,
        //             prefixIcon: AppAssets.username,
        //             capitalization: TextCapitalization.words,
        //             controller: _usernameController,
        //             validator: (value) {
        //               return MyValidators.displayNameValidator(
        //                   value);
        //             },                              ),
        //           const SizedBox(
        //             height: 16.0,
        //           ),
        //
        //           CustomTextField(
        //             hintText: S.of(context).emailAddress,
        //             labelText: S.of(context).emailAddress,
        //             controller: _emailController,
        //             focusNode: _emailFocusNode,
        //             nextFocus: _passwordFocusNode,
        //             prefixIcon: AppAssets.email,
        //             // required: true,
        //             showCodePicker: true,
        //             validator: (value) {
        //               return MyValidators.emailValidator(value);
        //             },
        //             // inputType: TextInputType.emailAddress,
        //             inputType: TextInputType.emailAddress,
        //           ),
        //           const SizedBox(
        //             height: 16.0,
        //           ),
        //
        //           CustomTextField(
        //             hintText: 'New password',
        //             labelText: 'New password',
        //             controller: _passwordController,
        //             focusNode: _passwordFocusNode,
        //             nextFocus: _phoneFocusNode,
        //             isPassword: true,
        //             inputAction: TextInputAction.next,
        //             validator: (value) {
        //               return MyValidators.passwordValidator(value);
        //             },
        //             prefixIcon: AppAssets.pass,
        //           ),
        //           const SizedBox(
        //             height: 16.0,
        //           ),
        //           CustomTextField(
        //             hintText: 'Enter Mobile Number',
        //             labelText: 'Enter Mobile Number',
        //             controller: _phoneNumberController,
        //             focusNode: _phoneFocusNode,
        //             // required: true,
        //             showCodePicker: true,
        //             isAmount: true,
        //             prefixIcon: AppAssets.callIcon,
        //             validator: (value) {
        //               return MyValidators.phoneValidator(value);
        //             },
        //             inputAction: TextInputAction.next,
        //             inputType: TextInputType.phone,
        //           ),
        //           const SizedBox(
        //             height: 30.0,
        //           ),
        //
        //           ///save button
        //           SizedBox(
        //             width: double.infinity,
        //             child: ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                 padding: const EdgeInsets.all(12),
        //                 backgroundColor: ColorResources.appColor,
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(
        //                     30,
        //                   ),
        //                 ),
        //               ),
        //               //icon: const Icon(Icons.save_as_rounded),
        //               child: Text(
        //                 S.of(context).update,
        //                 style: const TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 20,
        //                 ),
        //               ),
        //               onPressed: () async {
        //                 updateProfile(context);
        //               },
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //
        // );

    return BlocProvider(
      create: (context) => ProfileCubit(),

      child: Scaffold(

        appBar: AppBar(
          leading: InkWell(
              onTap: (){
                context.pushNamed(Routes.homeScreen);
              },
              child: Icon(Icons.arrow_back)
          ),
          title: Shimmer.fromColors(
            baseColor: ColorResources.apphighlightColor,
            highlightColor: ColorResources.apphighlightColor,
            child: Text(
                HomeCubit.get(context).isArabic
                    ? 'تحديث البروفايل'
                    : 'Update Profile',
                style:TextStyle(color: ColorResources.apphighlightColor) ,

            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [


                            SizedBox(height: 7,),
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: _imageCover == null
                                            ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100.0),
                                            border: Border.all(
                                                color: ColorResources.apphighlightColor
                                            ),
                                          ),
                                        )
                                            :Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100.0),
                                              border: Border.all(
                                                  color: ColorResources.apphighlightColor
                                              ),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:FileImage(
                                                  File(
                                                    _imageCover!.path,
                                                  ),
                                                  //
                                                ),
                                              )
                                          ),
                                        )
          
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(16.0),
                                      color: ColorResources.apphighlightColor,
                                      child: InkWell(
                                        splashColor: Colors.red,
                                        borderRadius: BorderRadius.circular(16.0),
                                        onTap: _pickImage,
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.add_a_photo,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  // ElevatedButton(
                  //   onPressed: _pickImage,
                  //   child: Text('Pick Image'),
                  // ),
                  // if (_imageCover != null)
                  //   Image.file(
                  //     _imageCover!,
                  //     height: 100,
                  //     width: 100,
                  //   ),
                  SizedBox(height: 16.0),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isAdmin==true?
                      Text("(Admin)",style:TextStyle(color: ColorResources.apphighlightColor) ,):
                      Text("(User)",style:TextStyle(color: ColorResources.apphighlightColor) ,),
                      SizedBox(width: 5,),
                      FutureBuilder<int>(
                                  future: fetchUserPoints(userId!),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Text(
                                        HomeCubit.get(context).isArabic
                                            ? '${snapshot.data}نقاطي: '
                                            : 'My Points: ${snapshot.data}',
                                        style:TextStyle(color: ColorResources.apphighlightColor) ,

                                      );
                                    }
                                  },
                                ),
                    ],
                  ),

                  SizedBox(height: 16.0),

                  CustomTextField(
                              hintText: 'Full name',
                              labelText: 'Full name',
                              inputType: TextInputType.name,
                              // required: true,
                              // focusNode: _nameFocusNode,
                              // nextFocus: _userNameFocusNode,
                              prefixIcon: AppAssets.user,
                              capitalization: TextCapitalization.words,
                              controller: _fullNameController,
                              validator: (value) {
                                return MyValidators.displayNameValidator(
                                    value);
                              },
          
                            ),

                  const SizedBox(
                              height: 16.0,
                            ),
          
                            CustomTextField(
                              hintText: 'User name',
                              labelText: 'User name',
                              inputType: TextInputType.name,
                              // required: true,
                              // focusNode: _userNameFocusNode,
                              // nextFocus: _emailFocusNode,
                              prefixIcon: AppAssets.username,
                              capitalization: TextCapitalization.words,
                              controller: _usernameController,
                              validator: (value) {
                                return MyValidators.displayNameValidator(
                                    value);
                              },                              ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            CustomTextField(
                              hintText: S.of(context).emailAddress,
                              labelText: S.of(context).emailAddress,
                              controller: _emailController,
                              // focusNode: _emailFocusNode,
                              // nextFocus: _passwordFocusNode,
                              prefixIcon: AppAssets.email,
                              // required: true,
                              showCodePicker: true,
                              validator: (value) {
                                return MyValidators.emailValidator(value);
                              },
                              // inputType: TextInputType.emailAddress,
                              inputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            CustomTextField(
                              hintText: 'New password',
                              labelText: 'New password',
                              controller: _passwordController,
                              // focusNode: _passwordFocusNode,
                              // nextFocus: _phoneFocusNode,
                              isPassword: true,
                              inputAction: TextInputAction.next,
                              validator: (value) {
                                return MyValidators.passwordValidator(value);
                              },
                              prefixIcon: AppAssets.pass,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
          
                  CustomTextField(
                        hintText: 'Enter Mobile Number',
                        labelText: 'Enter Mobile Number',
                        controller: _phoneNumberController,
                        // focusNode: _phoneFocusNode,
                        // required: true,
                        showCodePicker: true,
                        isAmount: true,
                        prefixIcon: AppAssets.callIcon,
                        validator: (value) {
                          return MyValidators.phoneValidator(value);
                        },
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       value: _isAdmin,
                  //       onChanged: (bool? value) {
                  //         setState(() {
                  //           _isAdmin = value ?? false;
                  //         });
                  //       },
                  //     ),
                  //     Text('Is Admin')
                  //   ],
                  // ),
          
          
                  BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileUpdateError) {
                        Constants.showToast(msg: state.error,
                            gravity: ToastGravity.BOTTOM,
                            color: Colors.red);
                      } else if (state is ProfileUpdated) {
                        Constants.showToast(msg: state.message,
                            gravity: ToastGravity.BOTTOM,
                            color: Colors.green);
                      }
                    },
                    builder: (context, state) {
          
                        return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<ProfileCubit>(context).updateProfile(
                                id: userId!,  // Replace with the actual ID
                                fullName: _fullNameController.text,
                                username: _usernameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                phoneNumber: _phoneNumberController.text,
                                isAdmin: _isAdmin,
                                imageCover: _imageCover,
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
                                ? "تحديث"
                                : "Update Profile",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                        );
          
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    
      }

  }

