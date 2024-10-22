
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';

import '../../../utill/app_assets.dart';
import '../../category/category_model.dart';

class CategoryCarousel extends StatelessWidget {
  final List<Category> catList;

  CategoryCarousel({required this.catList});

  @override
  Widget build(BuildContext context) {
    final catList=[
      Category(id: 1,titel: "BirthDay",  image: AppAssets.birthday),
      Category(id: 2,titel: "Arafa",  image: AppAssets.arafa),
      Category(id: 3,titel: "happy New Year",  image: AppAssets.happyNew),
      Category(id: 4,titel: "Ramadan",  image: AppAssets.ramadan),
      Category(id: 5,titel: "Ramadan",  image: AppAssets.shahed),
      Category(id: 6,titel: "Ramadan",  image: AppAssets.national),


    ];
    return CarouselSlider(
      items: catList.map((category) => ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(
          category.image,
          width: 300,
          fit: BoxFit.cover,
        ),
      )).toList(),
      options: CarouselOptions(
        aspectRatio: 4 / 1,
        viewportFraction: 0.9,
        enlargeFactor: 0.1,
        height: 220,
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
  }
}
