import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quakka/core/helpers/adaptive_indecator.dart';
import 'package:new_quakka/features/banner/update_banner.dart';
import 'package:new_quakka/utill/constant.dart';
import '../../basic_constants.dart';
import '../../core/network/api_constants.dart';
import 'banner_cuibt.dart';

class BannerView extends StatelessWidget {
  const BannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BannerCubit>(
      create: (context) => BannerCubit()..fetchBanners(),
      child: BlocConsumer<BannerCubit, BannerState>(
          listener: (context, state) {
            if (state is BannerError) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Try Connect with internet")));
            }
          },
          builder: (context, state) {
            if (state is BannerLoading) {
              return AdaptiveIndicator(os: getOS());
            } else if (state is BannerLoaded) {
              return CarouselSlider(
                items: state.banners.map((banner) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: (){
                        print("BannerId= ${banner.id}");
                        print("IsAdmin= $isAdmin");
                        if(isAdmin==true) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  UpdateBannerForm(bannerId: banner.id,
                                    initialTitle: banner.title,
                                    initialImageUrl: banner.image,)));
                        }
                        },
                      child: CachedNetworkImage(
                        height: 280,
                        width: 280,
                        fit: BoxFit.cover,
                        imageUrl: 'http://backend.quokka-mesh.com/${banner.image}',
                        httpHeaders: const {
                          ApiConstants.tokenTitle:
                          ApiConstants.tokenBody
                        },
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  aspectRatio: 4 / 1,
                  viewportFraction: 0.9,
                  enlargeFactor: 0.1,
                  height: 220.h,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
              );
            } else {
              return const Center(child: Text('Try Connect with internet'));
            }
          },
        ),
    );
  }
}
