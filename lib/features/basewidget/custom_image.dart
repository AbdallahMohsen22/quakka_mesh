import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utill/app_assets.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;
  const CustomImage({Key? key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = AppAssets.placeholder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(

      placeholder: (context, url) => Image.asset(placeholder?? AppAssets.placeholder, height: height, width: width, fit: BoxFit.cover),
      imageUrl: image, fit: fit?? BoxFit.cover,
      height: height,width: width,
      errorWidget: (c, o, s) => Image.asset(placeholder?? AppAssets.placeholder, height: height, width: width, fit: BoxFit.cover),
    );
  }
}
