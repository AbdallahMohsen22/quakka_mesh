import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import '../../core/helpers/adaptive_indecator.dart';
import '../../core/routing/routes.dart';
import '../../core/widges/laoding_manager.dart';
import '../../core/widges/subtitle_text_widget.dart';
import '../../core/widges/title_text_widget.dart';
import '../../generated/l10n.dart';
import '../../utill/app_assets.dart';
import '../../utill/app_colors.dart';
import '../../utill/color_resources.dart';
import '../../utill/constant.dart';
import '../../utill/dimensions.dart';
import '../../utill/my_validators.dart';
import '../auth/register.dart';
import '../basewidget/custom_textfield.dart';
import '../home/home_cubit/home_cubit.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';
import 'forgot_password/forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  // static const routName = '/LoginScreen';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

   final FocusNode _emailFocusNode= FocusNode();
   final FocusNode _passwordFocusNode =FocusNode();
   final bool obscureText = true;
   final bool isLoading= false;

  LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(

      create: (context) => LoginCubit(),

      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Navigate to the next screen
            context.pushReplacementNamed(Routes.homeScreen);
            // Navigator.pushReplacementNamed(context, '/home', arguments: state.user);
          } else if (state is LoginFailure) {
            Constants.showToast(msg: "Login Invalid",
                gravity: ToastGravity.BOTTOM,
                color: Colors.red);
          }
        },
        builder: (context,state){

          return Scaffold(
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
                LoadingManager(
                isLoading: isLoading,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(children: [
                        Container(height: 200, decoration: const BoxDecoration(color: ColorResources.apphighlightColor)),
                        Image.asset(AppAssets.loginBg,fit: BoxFit.cover,height: 200, opacity : const AlwaysStoppedAnimation(.20)),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .01),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Image.asset(AppAssets.splashLogo, width: 350, height: 200)]),
                        ),


                      ]),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                        child: Column(

                          children:
                          [
                            const SizedBox(
                              height: 20.0,
                            ),
                            ///headers
                            // Image.asset(AppAssets.imagesLogo,width: 250,height: 250,),
                            Align(
                              alignment: checkArabic()?Alignment.centerRight:Alignment.centerLeft,
                              child: TitlesTextWidget(label: S.of(context).welcomeBack,fontSize: 20.sp,),
                            ),
                            const SizedBox(
                              height: 1.0,
                            ),
                            Align(
                              alignment: checkArabic()?Alignment.centerRight:Alignment.centerLeft,
                              child: SubtitleTextWidget(
                                  fontSize: 17.sp,
                                  color: AppColors.grey,
                                  label: HomeCubit.get(context).isArabic
                                      ? "دعنا نسجل دخول لاستكشاف ماهو جديد ومميز لك"
                                      : 'Let\'s get your logged in so you can start explore',
                              ),
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            /// form inputs
                            Form(
                              key: context.read<LoginCubit>().formKey,
                              child: Column(
                                children: [
                                  /// email field
                                  CustomTextField(
                                    hintText: S.of(context).emailAddress,
                                    labelText: S.of(context).emailAddress,
                                    controller: emailController,
                                    focusNode: _emailFocusNode,
                                    nextFocus: _passwordFocusNode,
                                    prefixIcon: AppAssets.email,
                                    required: true,
                                    showCodePicker: true,
                                    validator: (value) {
                                      return MyValidators.emailValidator(value);
                                    },

                                    inputType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                                  ///password field
                                  CustomTextField(
                                    showLabelText: true,
                                    required: true,
                                    labelText: 'password',
                                    hintText: "*********",
                                    inputAction: TextInputAction.done,
                                    isPassword: true,
                                    prefixIcon: AppAssets.pass,
                                    focusNode: _passwordFocusNode,
                                    controller: passwordController,
                                    validator: (value) {
                                      return MyValidators.passwordValidator(value);
                                    },

                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),


                                  /// forget password
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {

                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>  SendEmailScreen(),));
                                      },
                                      child:  SubtitleTextWidget(
                                        label: HomeCubit.get(context).isArabic
                                            ? "هل نسيت كلمة المرور"
                                            : "Forgot Password",
                                        textDecoration: TextDecoration.underline,
                                        fontStyle: FontStyle.italic,
                                        color: ColorResources.apphighlightColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  ///login button
                          state is LoginLoading ?
                              Center(child: AdaptiveIndicator(os: getOS()))
                               : SizedBox(
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
                                      icon: const Icon(Icons.login_rounded,color: Colors.white,),
                                      label: Text(
                                        HomeCubit.get(context).isArabic
                                            ? "تسجيل دخول"
                                            : "Login",
                                        style:  TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white
                                        ),
                                      ),
                                      onPressed: ()  {
                                        final email = emailController.text;
                                        final password = passwordController.text;
                                        context.read<LoginCubit>().login(email, password);

                                        // validateThenDoLogin(context);
                                        //login(context);
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  ///go to sign up
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SubtitleTextWidget(
                                        label:HomeCubit.get(context).isArabic
                                            ? "ليس لديك حساب؟"
                                            : 'Don\'t have an account?'
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => const RegisterScreen(),));
                                        },
                                        child:  SubtitleTextWidget(
                                          color: ColorResources.apphighlightColor,
                                          label: HomeCubit.get(context).isArabic
                                              ? "انشاء حساب"
                                              : "Sign Up",
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

                      // InkWell(
                      //   child: Text(HomeCubit.get(context).isArabic
                      //       ? "الدخول كزائر"
                      //       : "Login as a guest",
                      //       style: TextStyles.font12BlackBold),
                      //   onTap: (){
                      //     Navigator.push(context,
                      //         MaterialPageRoute(builder: (context) => const HomeScreen(),));
                      //     // context.pushNamed(Routes.homeScreen);
                      //   },
                      // ),

                      // const LoginBlocListener(),

                    ],
                  ),
                ),
              )],
            ),
          );
        },
      ),
    );


  }

}
