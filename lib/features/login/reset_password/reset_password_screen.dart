//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:quokka_mesh/core/widges/quakko_logo.dart';
// import '../../../../core/theming/styles.dart';
// import '../../../core/helpers/spacing.dart';
// import '../../../core/widges/app_text_button.dart';
// import '../../home/home_cubit/home_cubit.dart';
//
// class ResetPasswordScreen extends StatelessWidget {
//   const ResetPasswordScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Boyo3AppBarLogo(),
//       // ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 verticalSpace(35),
//                 QuakkoLogo(),
//                 verticalSpace(36),
//                 Column(
//                   children: [
//                     // const ResetPasswordFields(),
//                     AppTextButton(
//                       buttonText: HomeCubit.get(context).isArabic
//                           ? "تاكيد"
//                           : "Confirm",
//
//                       textStyle: TextStyles.font16WhiteSemiBold,
//                       onPressed: () {
//                         // validateThenDoLogin(context);
//                       },
//                     ),
//                     verticalSpace(16),
//                     // const ResetPasswordBlocListener(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   //
//   // void validateThenDoLogin(BuildContext context) {
//   //   if (context.read<ForgetPasswordCubit>().formKey.currentState!.validate()) {
//   //     context.read<ForgetPasswordCubit>().emitResetPassword();
//   //   }
//   // }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_quakka/features/login/reset_password/reset_pass_cuibt.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/shared_constabts.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/my_validators.dart';
import '../../basewidget/custom_textfield.dart';
import '../../home/home_cubit/home_cubit.dart';
import '../login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: ColorResources.apphighlightColor,
            highlightColor: ColorResources.apphighlightColor,
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "استعادة كلمة المرور"
                  : 'Reset Password',
            ),
          ),
        ),
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccess) {
              // Fluttertoast.showToast(msg: state.message);
              Constants.showToast(msg: state.message,
                  gravity: ToastGravity.BOTTOM,
                  color: Colors.green);
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())); // Navigate back or to another screen
            } else if (state is ResetPasswordFailure) {
              // Fluttertoast.showToast(msg: state.error);
              Constants.showToast(msg: state.error,
                  gravity: ToastGravity.BOTTOM,
                  color: Colors.red);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      borderRadius: 20,
                      borderColor: ColorResources.apphighlightColor,
                      hintText: 'Email',
                      labelText: 'Email',
                      required: true,
                      // focusNode: _nameFocusNode,
                      // nextFocus: _userNameFocusNode,
                      // prefixIcon: AppAssets.user,
                      // capitalization: TextCapitalization.words,
                      inputType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    ///password field
                    CustomTextField(
                      showLabelText: true,
                      required: true,
                      labelText: 'New Password',
                      hintText: "*********",
                      inputAction: TextInputAction.done,
                      isPassword: true,
                      // prefixIcon: AppAssets.pass,
                      // focusNode: _passwordFocusNode,
                      controller: _newPasswordController,
                      validator: (value) {
                        return MyValidators.passwordValidator(value);
                      },

                    ),

                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    ///confirm password field
                    CustomTextField(
                      showLabelText: true,
                      required: true,
                      labelText: 'Confirm Password',
                      hintText: "*********",
                      inputAction: TextInputAction.done,
                      isPassword: true,
                      // prefixIcon: AppAssets.pass,
                      // focusNode: _passwordFocusNode,
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },

                    ),
                    // TextFormField(
                    //   controller: _confirmPasswordController,
                    //   decoration: InputDecoration(labelText: 'Confirm Password'),
                    //   obscureText: true,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please confirm your password';
                    //     }
                    //     if (value != _newPasswordController.text) {
                    //       return 'Passwords do not match';
                    //     }
                    //     return null;
                    //   },
                    // ),

                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ResetPasswordCubit>().resetPassword(
                            email: _emailController.text,
                            newPassword: _newPasswordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 50),
                        backgroundColor: ColorResources.apphighlightColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                      ),
                      child: state is ResetPasswordInProgress
                          ? CircularProgressIndicator()
                          : Text(
                        HomeCubit.get(context).isArabic
                            ? "تغيير كلمة المرور"
                            : "Reset Password",
                        style: TextStyle(
                            fontSize: 20,
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
