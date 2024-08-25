// import 'dart:io';
// import '../../core/network/api_error_handler.dart';
// import '../../core/network/api_result/api_result.dart';
// import '../../core/network/api_service/api_service.dart';
// import 'data/models/confirm_email_model.dart';
// import 'data/models/user_response.dart';
//
//
//
//
// class RegisterRepo{
//   final ApiService apiService;
//   RegisterRepo (this.apiService);
//   Future<ApiResult<UserResponse>> register({
//      required String fullName,
//      required String username,
//      required String email,
//      required String password,
//      required String phonenumber,
//      required String longitude,
//      required String latitude,
//      required File imageCover,
//   })async{
//     try{
//       var response=await apiService.register(
//         // ApiConstants.tokenBody,
//         fullName,
//         username,
//         email,
//         password,
//         phonenumber,
//         imageCover
//       );
//       return ApiResult.success(response);
//     }catch(error){
//       return ApiResult.failure(ErrorHandler.handle(error));
//     }
//   }
//
//   Future<ApiResult<ConfirmEmailModel>> confirmEmail({
//       required String email,
//     })async{
//    try{
//       var response = await apiService.confirmEmail
//       (
//         // ApiConstants.tokenBody,
//          email,email,
//       );
//        return ApiResult.success(response);
//     }catch(error){
//       return ApiResult.failure(ErrorHandler.handle(error));
//     }
//   }
//   Future<ApiResult<ConfirmEmailModel>> confirmOtp({
//       required String otp,
//     })async{
//    try{
//       var response = await apiService.confirmOtp
//       (
//         // ApiConstants.tokenBody,
//          otp,otp,
//       );
//        return ApiResult.success(response);
//     }catch(error){
//       return ApiResult.failure(ErrorHandler.handle(error));
//     }
//   }
//
//
// }
