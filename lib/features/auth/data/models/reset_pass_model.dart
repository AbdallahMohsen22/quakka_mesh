import 'package:json_annotation/json_annotation.dart';
 part 'reset_pass_model.g.dart';

@JsonSerializable()
class ResetPassModel {
  @JsonKey(name: 'message')
  String message;


  ResetPassModel(this.message);

  factory ResetPassModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPassModelFromJson(json);
    Map<String, dynamic> toJson() => _$ResetPassModelToJson(this);

}
