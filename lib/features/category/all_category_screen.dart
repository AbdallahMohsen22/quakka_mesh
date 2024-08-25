
import 'package:flutter/material.dart';

import '../../localization/language_constrants.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../basewidget/custom_app_bar.dart';
import '../basewidget/custom_themes.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: CustomAppBar(title: getTranslated('CATEGORY', context)),
      body: Container(),
    );
  }

  // List<Widget> _getSubSubCategories(BuildContext context, SubCategory subCategory) {
  //   List<Widget> subSubCategories = [];
  //   subSubCategories.add(Container(
  //     color: ColorResources.getIconBg(context),
  //     margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
  //     child: ListTile(
  //       title: Row(
  //         children: [
  //           Container(
  //             height: 7,
  //             width: 7,
  //             decoration: BoxDecoration(color: ColorResources.getPrimary(context), shape: BoxShape.circle),
  //           ),
  //           const SizedBox(width: Dimensions.paddingSizeSmall),
  //           Flexible(child: Text(getTranslated('all_products', context)!, style: titilliumSemiBold.copyWith(
  //               color: Theme.of(context).textTheme.bodyLarge!.color), maxLines: 2, overflow: TextOverflow.ellipsis,
  //           )),
  //         ],
  //       ),
  //       onTap: () {
  //         // Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
  //         //   isBrand: false,
  //         //   id: subCategory.id.toString(),
  //         //   name: subCategory.name,
  //         // )));
  //       },
  //     ),
  //   ));
  //   for(int index=0; index < subCategory.subSubCategories!.length; index++) {
  //     subSubCategories.add(Container(
  //       color: ColorResources.getIconBg(context),
  //       margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
  //       child: ListTile(
  //         title: Row(
  //           children: [
  //             Container(
  //               height: 7,
  //               width: 7,
  //               decoration: BoxDecoration(color: ColorResources.getPrimary(context), shape: BoxShape.circle),
  //             ),
  //             const SizedBox(width: Dimensions.paddingSizeSmall),
  //             Flexible(child: Text(subCategory.subSubCategories![index].name!, style: titilliumSemiBold.copyWith(
  //                 color: Theme.of(context).textTheme.bodyLarge!.color), maxLines: 2, overflow: TextOverflow.ellipsis,
  //             )),
  //           ],
  //         ),
  //         onTap: () {
  //           // Navigator.push(context, MaterialPageRoute(builder: (_) => ));
  //         },
  //       ),
  //     ));
  //   }
  //   return subSubCategories;
  // }
}



