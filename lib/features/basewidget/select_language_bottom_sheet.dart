import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localization/language_constrants.dart';
import '../../utill/app_assets.dart';
import '../../utill/dimensions.dart';
import 'custom_themes.dart';

class SelectLanguageBottomSheet extends StatefulWidget {
  const SelectLanguageBottomSheet({Key? key}) : super(key: key);

  @override
  State<SelectLanguageBottomSheet> createState() => _SelectLanguageBottomSheetState();
}

class _SelectLanguageBottomSheetState extends State<SelectLanguageBottomSheet> {
  int selectedIndex = 0;
  @override
  void initState() {
    // selectedIndex = Provider.of<LocalizationProvider>(context, listen: false).languageIndex!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, localizationProvider, _) {
        return SingleChildScrollView(
          child: Container(padding: const EdgeInsets.only(bottom: 40, top: 15),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,

                borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeDefault))
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 40,height: 5,decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(20)
              ),),
              const SizedBox(height: 40,),

              Text(getTranslated('select_language', context)!, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

              Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
                child: Text('${getTranslated('choose_your_language_to_proceed', context)}'),),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppAssets.languages.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0,Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall),
                      child: Container(decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        color: selectedIndex == index? Theme.of(context).primaryColor.withOpacity(.1): Theme.of(context).cardColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                          child: Row(children: [
                          SizedBox(width: 25, child: Image.asset(AppAssets.languages[index].imageUrl!)),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                              child: Text(AppAssets.languages[index].languageName!),
                            )

                      ],),
                        ),),
                    ),
                  );

              }),

              // Padding(
              //   padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall,0),
              //   child: CustomButton(buttonText: '${getTranslated('select', context)}', onTap: (){
              //     Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
              //       AppAssets.languages[selectedIndex].languageCode!,
              //       AppAssets.languages[selectedIndex].countryCode,
              //     ));
              //     Provider.of<CategoryProvider>(context, listen: false).getCategoryList(true);
              //     Provider.of<HomeCategoryProductProvider>(context, listen: false).getHomeCategoryProductList(true);
              //     Provider.of<TopSellerProvider>(context, listen: false).getTopSellerList(true);
              //     Provider.of<BrandProvider>(context, listen: false).getBrandList(true);
              //     Provider.of<ProductProvider>(context, listen: false).getLatestProductList(1, reload: true);
              //     Provider.of<ProductProvider>(context, listen: false).getFeaturedProductList('1', reload: true);
              //     Provider.of<FeaturedDealProvider>(context, listen: false).getFeaturedDealList(true);
              //     Provider.of<ProductProvider>(context, listen: false).getLProductList('1', reload: true);
              //     Navigator.pop(context);
              //   },),
              // )

            ],),
          ),
        );
      }
    );
  }
}
