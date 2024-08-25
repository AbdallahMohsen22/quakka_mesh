import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/shared_constabts.dart';
import '../../utill/app_assets.dart';
import '../../utill/color_resources.dart';
import '../basewidget/custom_textfield.dart';
import '../home/home_cubit/home_cubit.dart';
import 'cuibt.dart';


class SearchUserScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Shimmer.fromColors(
            baseColor: ColorResources.apphighlightColor,
            highlightColor: ColorResources.apphighlightColor,
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "البحث"
                  : "Search User",
            ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              borderRadius: 20,
              borderColor: ColorResources.apphighlightColor,
              hintText: 'Username',
              labelText: 'Username',
              required: true,
              // focusNode: _nameFocusNode,
              // nextFocus: _userNameFocusNode,
              prefixIcon: AppAssets.search,
              // capitalization: TextCapitalization.words,
              inputType: TextInputType.name,
              controller: _usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid user name';
                }
                return null;
              },
            ),

            SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: () {
                final username = _usernameController.text;
                if (username.isNotEmpty) {
                  context.read<UserCubit>().searchUsers(username);
                } else {
                  Constants.showToast(msg: 'Please enter a username',
                      gravity: ToastGravity.BOTTOM,
                      color: Colors.red);
                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a username')),);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: ColorResources.apphighlightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              ),
              label: Text(
                HomeCubit.get(context).isArabic
                    ? "بحث"
                    : "Search",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
              icon: const Icon(Icons.search_sharp,color: Colors.white,),
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is UserFailure) {
                    return Center(child: Text(state.error));
                  } else if (state is UserSuccess) {
                    return ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return ListTile(
                          title: Text(user.userName,style: TextStyle(color: Colors.black38),),
                          subtitle: Text(user.fullName,style: TextStyle(color: Colors.black),),
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                child: Image.network(
                                  'http://quokkamesh-001-site1.etempurl.com/' + user.imageCover,
                                  fit: BoxFit.cover,

                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    border: Border.all(
                                        color: ColorResources.white
                                    ),


                                ),
                              )

                          ),
                          // leading: Image.network(
                          //     'http://quokkamesh-001-site1.etempurl.com/' + user.imageCover,
                          //   fit: BoxFit.cover,
                          //
                          // ),
                          onTap: () {
                            Navigator.pop(context, user);
                          },
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No users found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
