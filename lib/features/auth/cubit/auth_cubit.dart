import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../basic_constants.dart';
import '../../../core/network/api_constants.dart';
import '../../../utill/constant.dart';
import '../../login/model/user_model.dart';
import '../model/register_model.dart';
import 'auth_state.dart';
import 'package:http/http.dart' as http;



class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);




  void register(RegisterModel request) async {
    emit(RegisterLoading());
    try {
      var uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.register}');
      var requestMultipart = http.MultipartRequest('POST', uri);

      // Add text fields
      var fields = await request.toFormData();
      fields.forEach((key, value) {
        requestMultipart.fields[key] = value;
      });

      // Add image file
      var imageFile = await http.MultipartFile.fromPath('ImageCover', request.imageCover.path);
      requestMultipart.files.add(imageFile);

      // Send request
      var response = await requestMultipart.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var prefs = await SharedPreferences.getInstance();
        final data = json.decode(responseBody);
        final user = UserModel.fromJson(data);
        emit(RegisterSuccess(user));
        Constants.showToast(msg: "Register Success",
            gravity: ToastGravity.BOTTOM,
            color: Colors.green);

        prefs.setBool('isAuth', true);
        prefs.setBool('isAdmin', user.result!.isAdmin!);
        prefs.setString('userId', user.result!.id!);
        prefs.setString('token', user.result!.token!);
        isSignIn = true;
        isAdmin = user.result!.isAdmin;
        userId = user.result!.id;
        userToken = user.result!.token;
        print("Api statusCode======>>>>>> ${response.statusCode}");
        print("Api Register Response======>>>>>> ${data}");
        print("UId======>>>>>> ${user.result!.id}");
        print("UId======>>>>>> ${user.result!.isAdmin}");
      } else {
        emit(RegisterFailure('Registration failed'));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }


}




//   static AuthCubit? get(context) => BlocProvider.of(context);
//
// bool isLoading=false;
//
//   UserResponse? userModel;
//   void register({
//   String? fullName,
//   String? userName,
//   String? password,
//   String? phone,
//   String? email,
//   XFile?image,
//    required BuildContext context
//
// })async{
//     emit(AuthRegisterLoadingState());
//     isLoading=true;
//     try {
//       var headers = {
//         ApiConstants.contentTypeTitle: ApiConstants.contentTypeBody,
//       };
//       var data = FormData.fromMap({
//         'ImageCover': [
//           await MultipartFile.fromFile(File(image!.path).path)
//         ],
//         'FullName': fullName,
//         'Username': userName,
//         'Email': email,
//         'Password':password,
//         'Phonenumber':phone
//       });
//       var dio = Dio();
//       var response = await dio.request(
//         '${ApiConstants.baseUrl}${ApiConstants.register}',
//         options: Options(
//           method: 'POST',
//           headers: headers,
//         ),
//         data: data,
//       );
//       print("===api call===");
//
//       if (response.statusCode == 200) {
//         isLoading=false;
//         print(json.encode(response.data));
//         userModel = UserResponse.fromJson(response.data);
//         print(userModel!.id);
//         print(userModel!.username);
//         print("ApI Response=====>>> ${response.data}");
//         if (uId != userModel!.id) {
//           CacheHelper.saveData(key: "uId", value: userModel!.id);
//           uId = CacheHelper.getData(key: "uId");
//           Constants.showToast(msg: "register successfully",
//               gravity: ToastGravity.BOTTOM,
//               color: Colors.green);
//           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeScreen(),));
//         } else {
//           Constants.showToast(msg: "Already login",
//               gravity: ToastGravity.BOTTOM,
//               color: Colors.black);
//         }
//       }
//       else {
//         print(response.statusMessage);
//       }
//
//     }
//     catch (e) {
//       if (e is DioException) {
//         if (e.response!.statusCode == 400) {
//           print("object");
//           print('${e.response!.data}');
//           isLoading=false;
//           emit(AuthRegisterErrorState(errorMessage:e.response!.data["messages"] ));
//           // Handle the 400 error explicitly
//
//           Constants.showToast(msg: e.response!.data['messages'],
//               gravity: ToastGravity.BOTTOM,
//               color: Colors.red);
//         } else {
//           isLoading=false;
//           // Handle other errors
//           print('Error: ${e.message}');
//           Constants.showToast(msg:e.message!,
//               gravity: ToastGravity.BOTTOM,
//               color: Colors.red);
//           emit(AuthRegisterErrorState(errorMessage:e.message!));
//         }
//       } else {
//         isLoading=false;
//         // Handle other exceptions
//         print('Error: ${e.toString()}');
//         emit(AuthRegisterErrorState(errorMessage:e.toString()));
//         Constants.showToast(msg:e.toString(),
//             gravity: ToastGravity.BOTTOM,
//             color: Colors.red);
//       }
//     }
//
//   }