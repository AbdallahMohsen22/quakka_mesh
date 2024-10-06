import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../basic_constants.dart';
import '../../core/helpers/adaptive_indecator.dart';
import '../../core/routing/routes.dart';
import '../../utill/app_assets.dart';
import '../../utill/color_resources.dart';
import '../../utill/constant.dart';
import '../../utill/dialog_utils.dart';
import '../basewidget/custom_textfield.dart';
import '../home/home_cubit/home_cubit.dart';
import '../home/login_widget_cart.dart';
import '../home/login_widget_profile.dart';
import '../search_by_username/cuibt.dart';
import 'cuibt/profile_cubit.dart';
import 'delete_user_cuibt/delete_user_cuibt.dart';
import 'delete_user_cuibt/delete_user_state.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId;

  const ProfileScreen({super.key, this.userId});

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

  // late final FocusNode _nameFocusNode,
  //     _emailFocusNode,
  //     _phoneFocusNode,
  //     _userNameFocusNode,
  //     _passwordFocusNode;
  bool obscureText = true;
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageCover = File(pickedFile.path);
      }
    });
  }

  Future<int> fetchUserPoints(String userId) async {
    final url =
        'http://backend.quokka-mesh.com/api/Statistics/User/UserPoint?userId=$userId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['numbers'];
    } else {
      throw Exception('Failed to load user points');
    }
  }

  @override
  void initState() {
    super.initState();
    if (userId != null) {
      context.read<UserCubit>().fetchUser(
          userId!); // Fetch user info in initState
    }else {
      // Handle null userId (maybe show a login prompt or an error)
      // You can show a login widget or redirect to a login screen here
      const LoginWidgetCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                context.pushNamed(Routes.homeScreen);
              },
              child: const Icon(Icons.arrow_back)),
          title: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.white,
            child: Text(
              HomeCubit.get(context).isArabic
                  ? 'تحديث البروفايل'
                  : 'Update Profile',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: userId != null?
        Stack(
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
            BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserErrorInfo) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is UserLoadingInfo) {
                return Center(child: AdaptiveIndicator(os: getOS()));
              } else if (state is UserLoadedInfo) {
                final user = state.user;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 7,
                          ),
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
                                          ? CircleAvatar(
                                        radius: 65,
                                        backgroundImage: NetworkImage('http://backend.quokka-mesh.com/${user['imageCover']}'),
                                      )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                  border: Border.all(
                                                      color: ColorResources
                                                          .apphighlightColor),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(
                                                      File(
                                                        _imageCover!.path,
                                                      ),
                                                      //
                                                    ),
                                                  )),
                                            )),
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
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isAdmin == true
                                  ? const Text(
                                      "(Admin)",
                                      style: TextStyle(
                                          color:
                                              ColorResources.apphighlightColor),
                                    )
                                  : const Text(
                                      "(User)",
                                      style: TextStyle(
                                          color:
                                              ColorResources.apphighlightColor),
                                    ),
                              const SizedBox(
                                width: 5,
                              ),
                              FutureBuilder<int>(
                                future: fetchUserPoints(userId!),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      HomeCubit.get(context).isArabic
                                          ? 'My Points: ${snapshot.data}'
                                          : 'My Points: ${snapshot.data}',
                                      style: const TextStyle(
                                          color:
                                              ColorResources.apphighlightColor),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          CustomTextField(
                            hintText: user['fullName'],
                            labelText: user['fullName'],
                            inputType: TextInputType.name,
                            // required: true,
                            // focusNode: _nameFocusNode,
                            // nextFocus: _userNameFocusNode,
                            prefixIcon: AppAssets.user,
                            capitalization: TextCapitalization.words,
                            controller: _fullNameController,
                            // validator: (value) {
                            //   return MyValidators.displayNameValidator(value);
                            // },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomTextField(
                            hintText: user['userName'],
                            labelText: user['userName'],
                            inputType: TextInputType.name,
                            // required: true,
                            // focusNode: _userNameFocusNode,
                            // nextFocus: _emailFocusNode,
                            prefixIcon: AppAssets.username,
                            capitalization: TextCapitalization.words,
                            controller: _usernameController,
                            // validator: (value) {
                            //   return MyValidators.displayNameValidator(value);
                            // },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomTextField(
                            hintText: user['email'],
                            labelText: user['email'],
                            controller: _emailController,
                            // focusNode: _emailFocusNode,
                            // nextFocus: _passwordFocusNode,
                            prefixIcon: AppAssets.email,
                            // required: true,
                            showCodePicker: true,
                            // validator: (value) {
                            //   return MyValidators.emailValidator(value);
                            // },
                            // inputType: TextInputType.emailAddress,
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          // CustomTextField(
                          //   hintText: '********',
                          //   labelText: 'New password',
                          //   controller: _passwordController,
                          //   // focusNode: _passwordFocusNode,
                          //   // nextFocus: _phoneFocusNode,
                          //   isPassword: true,
                          //   inputAction: TextInputAction.next,
                          //   // validator: (value) {
                          //   //   return MyValidators.passwordValidator(value);
                          //   // },
                          //   prefixIcon: AppAssets.pass,
                          // ),

                          CustomTextField(
                            hintText: user['phoneNumber'],
                            labelText: user['phoneNumber'],
                            controller: _phoneNumberController,
                            // focusNode: _phoneFocusNode,
                            // required: true,
                            showCodePicker: true,
                            isAmount: true,
                            prefixIcon: AppAssets.callIcon,
                            // validator: (value) {
                            //   return MyValidators.phoneValidator(value);
                            // },
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          BlocConsumer<ProfileCubit, ProfileState>(
                            listener: (context, state) {
                              if (state is ProfileUpdateError) {
                                Constants.showToast(
                                    msg: state.error,
                                    gravity: ToastGravity.BOTTOM,
                                    color: Colors.red);
                              } else if (state is ProfileUpdated) {
                                Constants.showToast(
                                    msg: state.message,
                                    gravity: ToastGravity.BOTTOM,
                                    color: Colors.green);
                              }
                            },
                            builder: (context, state) {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<ProfileCubit>(context)
                                          .updateProfile(
                                        id: userId!, // Replace with the actual ID
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 70, vertical: 12),
                                    backgroundColor:
                                        ColorResources.apphighlightColor,
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
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                      const SizedBox(height: 5,),
                      BlocConsumer<DeleteUserCubit, DeleteUserState>(
                      listener: (context, state) {
                        if (state is DeleteUserSuccess) {

                          Constants.showToast(
                              msg: 'Account deleted successfully',
                              gravity: ToastGravity.BOTTOM,
                              color: Colors.green);
                          // Navigator.of(context).pop();  // Navigate after deletion
                        } else if (state is DeleteUserFailure) {

                          Constants.showToast(
                              msg: state.error,
                              gravity: ToastGravity.BOTTOM,
                              color: Colors.red);
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              DialogUtils.showMessage(
                                  context,
                                  HomeCubit.get(context).isArabic
                                      ? 'هل أنت متأكد من حذف الحساب؟'
                                      : 'Are you sure you want to delete your account?',
                                  posActionTitle:
                                  HomeCubit.get(context).isArabic
                                      ? "نعم"
                                      : "yes",
                                  posAction: () async {
                                    context.read<DeleteUserCubit>().deleteUser(userId!);
                                    var prefs = await SharedPreferences.getInstance();
                                    setState(() {
                                      isSignIn = false;
                                      userId=null;
                                      userToken=null;

                                    });
                                    prefs.setBool('isAuth', false);
                                    prefs.remove('userId');
                                    prefs.remove('token');
                                    context
                                        .pushReplacementNamed(Routes.loginScreen);
                                  },
                                  negActionTitle:
                                  HomeCubit.get(context).isArabic
                                      ? "لا"
                                      : "no",
                                  negAction: () {});
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 12),
                              backgroundColor:
                              ColorResources.apphighlightColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                            ),
                            child: Text(
                              HomeCubit.get(context).isArabic
                                  ? "حذف الحساب"
                                  : "Delete Account",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
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
              else if (state is UserErrorInfo) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          )],
        ) : const LoginWidgetProfile(),
      ),
    );
  }
}
