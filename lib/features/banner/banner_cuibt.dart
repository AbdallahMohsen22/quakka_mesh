import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'banner_model.dart';
import 'dart:convert';
import 'package:path/path.dart';

abstract class BannerState {}

class BannerInitial extends BannerState {}
class BannerLoading extends BannerState {}
class BannerLoaded extends BannerState {
  final List<Banner> banners;
  BannerLoaded({required this.banners});
}
class BannerError extends BannerState {
  final String error;
  BannerError({required this.error});
}

class AddBannerLoading extends BannerState {}
class AddBannerLoaded extends BannerState {
}
class AddBannerError extends BannerState {
  final String error;
  AddBannerError({required this.error});
}


class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerInitial());

  void fetchBanners() async {
    emit(BannerLoading());
    try {
      final response = await http.get(Uri.parse('http://backend.quokka-mesh.com/api/Banner/GetAllBanner'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Banner> banners = data.map((bannerJson) => Banner.fromJson(bannerJson)).toList();
        emit(BannerLoaded(banners: banners));
        print("APi response Banners====>>>>${data}");
      } else {
        emit(BannerError(error: 'Failed to load banners'));
      }
    } catch (e) {
      emit(BannerError(error: e.toString()));
    }
  }

  void addBanner(String title, File image) async {
    emit(AddBannerLoading());
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://backend.quokka-mesh.com/api/Banner/AddBanner'),
      );
      request.fields['Title'] = title;
      request.files.add(await http.MultipartFile.fromPath('Image', image.path, filename: basename(image.path)));

      var response = await request.send();
      if (response.statusCode == 200) {
        fetchBanners();
        print("Api add bannar=====>>>>${response.statusCode}");
        emit(AddBannerLoaded());
      } else {
        emit(AddBannerError(error: 'Failed to add banner'));
      }
    } catch (e) {
      emit(AddBannerError(error: e.toString()));
    }
  }

  void updateBanner(int id, String title, File image) async {
    emit(BannerLoading());
    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('http://backend.quokka-mesh.com/api/Banner/UpdateNews/$id'),
      );
      request.fields['Title'] = title;
      request.files.add(await http.MultipartFile.fromPath('Image', image.path, filename: basename(image.path)));

      var response = await request.send();
      if (response.statusCode == 200) {
        fetchBanners();
        print("Api update bannar=====>>>>${response.statusCode}");

      } else {
        emit(BannerError(error: 'Failed to update banner'));
      }
    } catch (e) {
      emit(BannerError(error: e.toString()));
    }
  }

  void deleteBanner(int id) async {
    emit(BannerLoading());
    try {
      final response = await http.delete(
        Uri.parse('http://backend.quokka-mesh.com/api/Banner/DeleteBanner?id=$id'),
      );
      if (response.statusCode == 200) {
        fetchBanners();
      } else {
        emit(BannerError(error: 'Failed to delete banner'));
      }
    } catch (e) {
      emit(BannerError(error: e.toString()));
    }
  }
}