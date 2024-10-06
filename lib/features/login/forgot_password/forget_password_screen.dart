import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/shared_constabts.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/my_validators.dart';
import '../../basewidget/custom_textfield.dart';
import '../../home/home_cubit/home_cubit.dart';
import '../otp/otp_screen.dart';
import 'forgot_pass_cuibt.dart';

class SendEmailScreen extends StatefulWidget {
  @override
  _SendEmailScreenState createState() => _SendEmailScreenState();
}

class _SendEmailScreenState extends State<SendEmailScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.white,
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "تأكيد الايميل"
                  : "Confirm Email",
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
            BlocConsumer<EmailCubit, EmailState>(
            listener: (context, state) {
              if (state is EmailSent) {
                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                Constants.showToast(msg: 'Send OTP Successfully',
                    gravity: ToastGravity.BOTTOM,
                    color: Colors.green);
                if (state.message == 'Send OTP Successfully') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OtpScreen()),
                  );
                }
              } else if (state is EmailSendError) {
                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a valid email")));
                Constants.showToast(msg: "Enter a valid email",
                    gravity: ToastGravity.BOTTOM,
                    color: Colors.red);
              }
            },
            builder: (context, state) {

                return Padding(
                  padding: const EdgeInsets.all(16.0),
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
                        //capitalization: TextCapitalization.words,
                        inputType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          return MyValidators.emailValidator(
                              value);
                        },

                      ),

                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          final email = _emailController.text;
                          if (email.isNotEmpty) {
                            context.read<EmailCubit>().sendEmail(email);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter an email')));
                          }
                        },
                        child: Text(
                            HomeCubit.get(context).isArabic
                                ? "تأكيد الايميل"
                                : "Confirm Email",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 12),
                          backgroundColor: ColorResources.apphighlightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );

            },
          )],
        ),
      ),
    );
  }
}
