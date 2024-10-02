import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theming/styles.dart';
import '../../utill/color_resources.dart';
import '../home/home_cubit/home_cubit.dart';

class ShareDialog extends StatelessWidget {
  final XFile imageFile;

  const ShareDialog({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.grey[300],
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: ColorResources.black,
          highlightColor: ColorResources.black,
          child: Text(
            HomeCubit.get(context).isArabic
                ? "شارك الصورة مع صديقك"
                : 'Share the image with friends',
          ),
        ),
        const SizedBox(height: 30,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                child: Image.asset('assets/images/whats_icon.png', height: 40, width: 40),
                onTap: () {
                  _shareViaWhatsApp();
                  Navigator.pop(context); // Close the share options dialog
                },
              ),
              const SizedBox(width: 5,),
              InkWell(
                child: Image.asset('assets/images/instegram_icon.png', height: 40, width: 40),
                onTap: () {
                  _shareViaInstagram();
                  Navigator.pop(context); // Close the share options dialog
                },
              ),
              const SizedBox(width: 5,),
              InkWell(
                child: Image.asset('assets/images/twitter_icon.png', height: 40, width: 40),
                onTap: () {
                  _shareViaTwitter();
                  Navigator.pop(context); // Close the share options dialog
                },
              ),
              const SizedBox(width: 5,),
              InkWell(
                child: Image.asset('assets/images/linkedin_icon.png', height: 40, width: 40),
                onTap: () {
                  _shareViaLinkedIn();
                  Navigator.pop(context); // Close the share options dialog
                },
              ),
              const SizedBox(width: 5,),
              InkWell(
                child: Image.asset('assets/images/facebook_icon.png', height: 40, width: 40),
                onTap: () {
                  _shareViaFacebook();
                  Navigator.pop(context); // Close the share options dialog
                },
              ),
              const SizedBox(width: 5,),
              InkWell(
                child: Image.asset('assets/images/messenger_icon.png', height: 40, width: 40),
                onTap: () {
                  _shareViaMessenger();
                  Navigator.pop(context); // Close the share options dialog
                },
              ),
              const SizedBox(width: 5,),
              InkWell(
                child: Image.asset('assets/images/gmail_icon.png', height: 40, width: 40),
                onTap: () {
                  _shareViaGmail();
                  Navigator.pop(context); // Close the share options dialog
                },
              ),
              const SizedBox(width: 10,),
            ],
          ),
        ),
        const SizedBox(height: 60,),
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            backgroundColor: const MaterialStatePropertyAll(
              ColorResources.apphighlightColor,
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 8.h,
              ),
            ),
            fixedSize: MaterialStateProperty.all(
              Size(90.w, 25.h),
            ),
          ),
          onPressed: () {
            _shareViaWhatsApp();
            Navigator.pop(context);
          },
          child: Text(
            'GO',
            style: TextStyles.font13WhiteBold,
          ),
        ),
      ],
    );
  }

  void _shareViaWhatsApp() {
    Share.shareXFiles([imageFile], text: 'Check out this awesome image!');
  }

  void _shareViaFacebook() async {
    String facebookUrl = 'https://www.facebook.com/sharer/sharer.php?u=${imageFile.path}';
    await canLaunch(facebookUrl)
        ? await launch(facebookUrl)
        : throw 'Could not launch $facebookUrl';
  }

  void _shareViaTwitter() async {
    String twitterUrl = 'https://twitter.com/intent/tweet?url=${imageFile.path}';
    await canLaunch(twitterUrl)
        ? await launch(twitterUrl)
        : throw 'Could not launch $twitterUrl';
  }

  void _shareViaGmail() {
    Share.shareXFiles([imageFile], subject: 'Check out this image!');
  }

  void _shareViaInstagram() async {
    String instagramUrl = 'https://www.instagram.com/share?url=${imageFile.path}';
    await canLaunch(instagramUrl)
        ? await launch(instagramUrl)
        : throw 'Could not launch $instagramUrl';
  }

  void _shareViaLinkedIn() async {
    String linkedInUrl = 'https://www.linkedin.com/sharing/share-offsite/?url=${imageFile.path}';
    await canLaunch(linkedInUrl)
        ? await launch(linkedInUrl)
        : throw 'Could not launch $linkedInUrl';
  }

  Future<void> _shareViaMessenger() async {
    const messengerUrl = 'fb-messenger://share?link=https://damarota.com';
    if (await canLaunch(messengerUrl)) {
      await launch(messengerUrl);
    } else {
      Share.shareXFiles([imageFile], text: 'Check out this image!');
    }
  }
}
