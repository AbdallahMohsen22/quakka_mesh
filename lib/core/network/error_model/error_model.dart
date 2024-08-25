
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel{

  String? messages;
  ErrorModel(this.messages);
  /*
    factory User.fromJson(Map<String ,dynamic> json)=>_$UserFromJson(json);
  Map<String ,dynamic> toJson()=>_$UserToJson(this);
   */

  factory ErrorModel.fromJson(Map<String,dynamic> json)=>_$ErrorModelFromJson(json);
  Map<String ,dynamic> toJson()=>_$ErrorModelToJson(this);
}