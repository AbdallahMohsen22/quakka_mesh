import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import 'package:new_quakka/features/auth/widgets/pick_image_widget.dart';
import '../../core/routing/routes.dart';
import '../../core/widges/laoding_manager.dart';
import '../../core/widges/subtitle_text_widget.dart';
import '../../core/widges/title_text_widget.dart';
import '../../generated/l10n.dart';
import '../../utill/app_assets.dart';
import '../../utill/app_colors.dart';
import '../../utill/color_resources.dart';
import '../../utill/constant.dart';
import '../../utill/my_validators.dart';
import '../basewidget/custom_textfield.dart';
import '../home/home_cubit/home_cubit.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/auth_state.dart';
import 'model/register_model.dart';

class RegisterScreen extends StatefulWidget {
  static const routName = '/RegisterScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  XFile? imageCover;

  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _phoneFocusNode,
      _userNameFocusNode,
      _passwordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;

  @override
  void initState() {
    // usernameController = TextEditingController();
    // emailController = TextEditingController();
    // phoneNumberController = TextEditingController();
    // passwordController = TextEditingController();
    // imageCoverController = TextEditingController();
    // Focus Nodes
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _userNameFocusNode = FocusNode();
    super.initState();
  }

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



  XFile? _pickedImage;


  Future<void> localImagePicker(context) async {
    final ImagePicker picker = ImagePicker();

    await Constants.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {
          imageCover = _pickedImage;
        });
      },
      galleryFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          imageCover = _pickedImage;
        });
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),

      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            // Navigate to the next screen or show a success message
            // Navigator.pushReplacementNamed(context, '/home', arguments: state.user);
            context.pushReplacementNamed(Routes.homeScreen);
          } else if (state is RegisterFailure) {
            Constants.showToast(msg: "Email or Password is Invalid!",
                gravity: ToastGravity.BOTTOM,
                color: Colors.red);
          }
        },
        builder: (context, state) {

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(children: [
                      Container(height: 200, decoration: const BoxDecoration(color: ColorResources.apphighlightColor)),
                      Image.asset(AppAssets.loginBg,fit: BoxFit.cover,height: 200, opacity : const AlwaysStoppedAnimation(.15)),
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .01),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Image.asset(AppAssets.splashLogo, width: 350, height: 200)]),
                      ),


                    ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                      child: Column(
                        children: [
                          // const SizedBox(height: 10.0,),

                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       TitlesTextWidget(label: S.of(context).welcome),
                          //       SubtitleTextWidget(
                          //         label: S.of(context).signUpNowToReceive,
                          //         color: AppColors.grey,
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 16.0,
                          // ),
                          ///circle avatar of image
                          SizedBox(
                            height: 130,
                            width: 130,
                            child: PickImageWidget(
                              pickedImage: _pickedImage,
                              function: () async {
                                await localImagePicker(context);
                              },
                            ),
                          ),

                          const SizedBox(height: 10.0,),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [

                                CustomTextField(
                                  hintText: 'Full name',
                                  labelText: 'Full name',
                                  inputType: TextInputType.name,
                                  required: true,
                                  focusNode: _nameFocusNode,
                                  nextFocus: _userNameFocusNode,
                                  prefixIcon: AppAssets.user,
                                  //capitalization: TextCapitalization.words,
                                  controller: fullNameController,
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
                                  required: true,
                                  focusNode: _userNameFocusNode,
                                  nextFocus: _emailFocusNode,
                                  prefixIcon: AppAssets.username,
                                  capitalization: TextCapitalization.words,
                                  controller: usernameController,
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
                                  controller: emailController,
                                  focusNode: _emailFocusNode,
                                  nextFocus: _phoneFocusNode,
                                  prefixIcon: AppAssets.email,
                                  required: true,
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
                                  hintText: 'Enter Mobile Number',
                                  labelText: 'Enter Mobile Number',
                                  controller: phoneNumberController,
                                  focusNode: _phoneFocusNode,
                                  nextFocus: _passwordFocusNode,
                                  required: true,
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
                                  height: 16.0,
                                ),

                                CustomTextField(
                                  hintText: 'password',
                                  labelText: 'password',
                                  controller: passwordController,
                                  focusNode: _passwordFocusNode,
                                  isPassword: true,
                                  required: true,
                                  inputAction: TextInputAction.next,
                                    validator: (value) {
                                      return MyValidators.passwordValidator(value);
                                    },
                                  prefixIcon: AppAssets.pass,
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),

                              state is RegisterLoading ?
                              const Center(child: CircularProgressIndicator()) :
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(12),
                                      backgroundColor: ColorResources.apphighlightColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                    ),
                                    icon: const Icon(IconlyLight.addUser,color: Colors.white,),
                                    label: Text(
                                      HomeCubit.get(context).isArabic
                                          ? "انشاء حساب"
                                          : "Sign Up",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white
                                      ),
                                    ),
                                    onPressed: ()  {
                                      // _registerFct(context);
                                      if (imageCover != null) {
                                        final request = RegisterModel(
                                          fullName: fullNameController.text,
                                          username: usernameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phoneNumber: phoneNumberController.text,
                                          imageCover: imageCover!,
                                        );
                                        context.read<RegisterCubit>().register(request);
                                      } else {

                                        Constants.showToast(msg: "Please select an image",
                                            gravity: ToastGravity.BOTTOM,
                                            color: Colors.red);
                                      }
                                    },
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SubtitleTextWidget(
                                      label:HomeCubit.get(context).isArabic
                                          ? "لديك حساب بالفعل "
                                          : "Already have an account",
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.pushNamed(Routes.loginScreen);
                                      },
                                      child:  SubtitleTextWidget(
                                        color: ColorResources.apphighlightColor,
                                        label:HomeCubit.get(context).isArabic
                                            ? "تسجيل دخول"
                                            : "Login",
                                        textDecoration: TextDecoration.underline,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),


                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
