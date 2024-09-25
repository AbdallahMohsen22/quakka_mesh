import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quakka/core/theming/colors.dart';
import 'package:new_quakka/features/login/login_screen.dart';
import 'package:new_quakka/utill/color_resources.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../utill/cache_helper.dart';
import '../home/home_cubit/home_cubit.dart';
import '../home/home_gest.dart';
import 'onBoardingModel.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

bool isLast = false;
int pindex = 0;
PageController pageindex = PageController();

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    List<OnBoarding> items = [
      OnBoarding(
        description:
        HomeCubit.get(context).isArabic
            ? 'اكتشف ماهو جديد واستمتع بتجربة فريدة من نوعها وارسل التهنئة للأصدقاء والأحباب '
            : "Discover what's new, enjoy a unique experience and send congratulations to friends and loved ones",
        image: 'assets/images/farah.jpeg',
        title: HomeCubit.get(context).isArabic
            ? 'مرحبا بك'
            : 'Welcome',
      ),
      OnBoarding(
        description:
        HomeCubit.get(context).isArabic
            ? 'هنئ اصدقائك واحبابك بأعياد ميلادهم واستمتع باللحظات السعيدة معهم'
            : 'Congratulate your friends and loved ones on their birthdays and enjoy the happy moments with them',
        image: 'assets/images/birthday.jpeg',
        title: HomeCubit.get(context).isArabic
            ? 'تهنئة عيد الميلاد'
            : 'Birthday Greetings',
      ),
      OnBoarding(
        description:
        HomeCubit.get(context).isArabic
            ? 'يمكنك ارسال تهنئة رأس السنة لأصدقائك وتمني لهم سنة سعيدة'
            : 'You can send New Year greetings to your friends and wish them a happy year',
        image: 'assets/images/crismas.jpeg',
        title: HomeCubit.get(context).isArabic
            ? 'تهنئة عيد رأس السنة'
            : "New Year's greetings",
      ),
      OnBoarding(
        description:
        HomeCubit.get(context).isArabic
            ? 'يمكنك ايضا ارسال تهنئة عيد اليوم الوطني الاماراتي لأصدقائك وتمني لهم اجازة سعيدة'
            : 'You can also send UAE National Day greetings to your friends and wish them a happy holiday',
        image: 'assets/images/elalam.jpeg',
        title: HomeCubit.get(context).isArabic
            ? 'عيد اليوم الوطني الاماراتي'
            : 'UAE National Day',
      ),
    ];
    void submit() {
      CacheHelper.saveData(key: 'onBoarding', value: true).then(
        (value) {
          print(value);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeGestScreen(),
              ),
              (route) => false);
        },
      );
    }

    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Stack(
        children: [
          // Image.asset(
          //   'assets/images/farah.jpeg',
          //   width: double.infinity,
          //   height: double.infinity,
          //   fit: BoxFit.fill,
          // ),
          Column(
            children: [

              SizedBox(
                height: 20.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: TextButton(
                        onPressed: () {
                          submit();
                        },
                        child: Text(
                          HomeCubit.get(context).isArabic
                              ? 'تخطي'
                              : 'Skip',
                          style: TextStyle(color: ColorResources.apphighlightColor, fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    pindex = value;
                    if (value == items.length - 1) {
                      isLast = true;
                    } else {
                      isLast = false;
                    }
                  },
                  controller: pageindex,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 275.h,
                            child: Image(
                              image: AssetImage(
                                items[index].image,
                              ),
                              height: 280.h,
                            ),
                          ),
                          Text(
                            items[index].title,
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: ColorResources.apphighlightColor,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150.h,
                              child: Center(
                                child: Text(
                                  items[index].description,
                                  style: TextStyle(
                                    fontSize:16.sp,
                                    color: ColorResources.apphighlightColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: items.length,
                ),
              ),
              Container(
                height: 40.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: ColorResources.apphighlightColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageindex.nextPage(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.linear,
                      );
                    }
                  },
                  child: Text(
                    isLast ? HomeCubit.get(context).isArabic
                        ? 'ابدأ'
                        : 'Get Started'
                        : HomeCubit.get(context).isArabic
                        ? 'التالي'
                        : 'Next',
                    style: TextStyle(
                        color: ColorResources.white,
                        fontSize:20.sp,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              SmoothPageIndicator(
                controller: pageindex,
                count: items.length,
                effect: WormEffect(
                  activeDotColor: ColorResources.apphighlightColor,
                  dotColor: ColorResources.apphighlightColor,
                  dotHeight: 13.r,
                  dotWidth: 13.r,
                  spacing: 15.0.w,
                ),
              ),
              SizedBox(
                height: 40.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}
