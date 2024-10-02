import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../features/auth/data/models/confirm_email_model.dart';
import '../../../features/auth/data/models/reset_pass_model.dart';
import '../../../features/auth/data/models/user_response.dart';
import '../api_constants.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl) //"${baseUrl}"
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  @MultiPart()
  Future<UserResponse> login(// @Header(ApiConstants.tokenTitle) String token,
      @Part() String Email,
      @Part() String Password,);

  @POST(ApiConstants.register)
  @MultiPart()
  Future<UserResponse> register(
      // @Header(ApiConstants.tokenTitle) String token,
      @Part(name: "FullName") String fullName,
      @Part(name: "Username") String username,
      @Part(name: "Email") String email,
      @Part(name: "Password") String password,
      @Part(name: "Phonenumber") String phonenumber,
      @Part(name: "ImageCover") File imageCover,);

  @POST('${ApiConstants.confirmEmail}/{email}')
  Future<ConfirmEmailModel> confirmEmail(
      // @Header('Authorization') String token,
      @Path('email') String email,
      @Part() String emailAddress);

  @GET('${ApiConstants.confirmOtp}/{otp}')
  Future<ConfirmEmailModel> confirmOtp(// @Header('Authorization') String token,
      @Path('otp') String otp,
      @Part() String otpp);

  @POST(ApiConstants.resetPassword)
  Future<ResetPassModel> resetPassword(
      @Part(name: "Email") String email,
      @Part(name: "NewPassword") String newPassword,
      @Part(name: "ConfirmPassword") String confirmPassword,
      );



}
