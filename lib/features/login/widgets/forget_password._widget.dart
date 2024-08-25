
import 'package:flutter/material.dart';
import 'package:new_quakka/core/helpers/extensitions.dart';
import '../../../../core/theming/styles.dart';
import '../../../core/routing/routes.dart';
import '../../home/home_cubit/home_cubit.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        TextButton(
            onPressed: () {
              context.pushNamed(Routes.forgetPasswordConfirmEmail);
            },
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "نسيت كلمةالمرور"
                  : "Forget Password",
              style: TextStyles.font15MainRed,
            )),
      ],
    );
  }
}
