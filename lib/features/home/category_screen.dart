// import 'package:flutter/material.dart';
// import 'package:quokka_mesh/features/card_details/card_details_screen.dart';
// import '../../utill/app_assets.dart';
//
// class ListCategoryModel{
//   final String title;
//   final String image;
//   ListCategoryModel({required this.title, required this.image});
// }
// class CategoryScreen extends StatelessWidget {
//    CategoryScreen({Key? key, required this.title}) : super(key: key);
//   final List<ListCategoryModel> catList=[
//     ListCategoryModel(title: "BirthDay",  image: AppAssets.imagesCard2),
//     ListCategoryModel(title: "Eid",  image: AppAssets.imagesCard2),
//     ListCategoryModel(title: "BirthDay",  image: AppAssets.imagesCard2),
//     ListCategoryModel(title: "BirthDay",  image: AppAssets.imagesCard2),
//     ListCategoryModel(title: "BirthDay",  image: AppAssets.imagesCard2),
//   ];
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body:  Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               GridView.builder(
//                   itemCount: 1,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 1 / 1.6,
//                   ),
//                   itemBuilder: (context, index) =>
//                       InkWell(
//                         onTap: (){
//                           if(index==0){
//                             Navigator.push(context, MaterialPageRoute(
//                               builder: (context) => CardDetailsScreen(
//                               image: catList[index].image,
//                             ),));
//
//                           }
//                         },
//                         child: Container(
//                           height: 100,
//                           width: 100,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.black
//                               ),
//                               color: Colors.black,
//                               image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(catList[index].image,)
//                               )
//                           ),
//                           child: Center(child: Text(catList[index].title),),
//                         ),
//                       )),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/utill/color_resources.dart';

import '../../core/network/api_constants.dart';
import '../cart_screen/cart_list_screen.dart';
import '../category/category_model.dart';
import '../category/cuibt.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => CategoryCubit()..fetchCategories(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
           if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75, // Aspect ratio of the grid items
              ),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return CategoryCard(category: category);
              },
            );
          } else if (state is CategoryError) {
            return Center(child: Text(state.error));
          }
          return Container();
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      child: Card(

        elevation: 20,
        color: ColorResources.apphighlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: 'http://backend.quokka-mesh.com/${category.image}',
                httpHeaders: const {
                  ApiConstants.tokenTitle:
                  ApiConstants.tokenBody
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    category.titel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  // SizedBox(height: 4.0),
                  // Text(
                  //   category.isActive == false ? 'Inactive' : 'Active',
                  //   style: TextStyle(
                  //     color: category.isActive == null ? Colors.red : Colors.green,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),

      ),
      onTap: () {
        print("category_id= ${category.id}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartListScreen(categoryId: category.id),
          ),
        );
      },
    );
  }
}
