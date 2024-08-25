import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/shared_constabts.dart';
import '../../../utill/color_resources.dart';
import '../../home/home_cubit/home_cubit.dart';
import '../reset_password/reset_password_screen.dart';
import 'otp_cuibt.dart';

// OtpScreen
class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _otp = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: ColorResources.apphighlightColor,
            highlightColor: ColorResources.apphighlightColor,
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "رمز التحقق"
                  : 'OTP Verification',
            ),
          ),

        ),
        body: BlocConsumer<OtpCubit, OtpState>(
          listener: (context, state) {
            if (state is OtpVerified) {
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              Constants.showToast(msg: state.message,
                  gravity: ToastGravity.BOTTOM,
                  color: Colors.green);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
              );
            } else if (state is OtpVerificationError) {
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
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
                    Pinput(
                      length: 6,
                      onCompleted: (pin) {
                        _otp = pin;
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<OtpCubit>().verifyOtp(_otp);
                        }
                      },
                      validator: (pin) {
                        if (pin == null || pin.isEmpty) {
                          return 'Please enter the OTP';
                        } else if (pin.length < 6) {
                          return 'OTP must be 6 digits';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<OtpCubit>().verifyOtp(_otp);
                        }
                      },
                      child: Text(
                          HomeCubit.get(context).isArabic
                              ? "تأكيد OTP"
                              : 'Verify OTP',
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

                    if (state is OtpVerifying)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('Verifying OTP...'),
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
