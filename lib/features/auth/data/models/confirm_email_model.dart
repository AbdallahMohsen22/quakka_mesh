import 'package:json_annotation/json_annotation.dart';
part 'confirm_email_model.g.dart';

@JsonSerializable()
class ConfirmEmailModel {
  @JsonKey(name: "message")
  String message;
  ConfirmEmailModel(this.message);
  factory  ConfirmEmailModel.fromJson(Map<String,dynamic> json) => _$ConfirmEmailModelFromJson(json);
  Map<String,dynamic> toJson() => _$ConfirmEmailModelToJson(this);
}
