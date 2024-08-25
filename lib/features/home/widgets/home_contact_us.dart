import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utill/constant.dart';

class ContactUsForHome extends StatelessWidget {
  const ContactUsForHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Row(
            children: [
              Text(checkArabic() ? "تواصل معنا" : 'Contact us',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              // TextButton(
              //     onPressed: () {
              //       // context.pushNamed(Routes.contactUsScreen);
              //     },
              //     child: Text(
              //       checkArabic() ? 'المزيد' : "More",
              //       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              //     ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Row(
            children: [
              const Icon(
                FontAwesomeIcons.house,
                color: Color(0xFF181059),
              ),
              const SizedBox(width: 10,),
              Column(
                children: [
                  Text(
                    checkArabic() ? "العنوان" : "Address",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    checkArabic() ? "الإمارات" : "The UAE",
                    style: const TextStyle(
                        fontSize: 15),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Row(
            children: [
              const Icon(
                FontAwesomeIcons.phone,
                color: Color(0xFF181059),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    checkArabic() ? "الهاتف" : "Phone",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "+971507877242",
                    style: TextStyle(
                        fontSize: 15, ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Row(
            children: [
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.message,
                    color: Color(0xFF181059),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        checkArabic() ? "البريد الإلكتروني" : "Email Address",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "info@boyo3.com",
                        style: TextStyle(
                            fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Row(
            children: [
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.calendar,
                    color: Color(0xFF181059),
                  ),
                  const SizedBox(width: 10,),
                  // horizontalSpace(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        checkArabic() ? "التوقيت" : "Timing",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                       const Text(
                         "من الاثنين - الجمعة 12م - 12ص",
                        style:TextStyle(
                            fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
