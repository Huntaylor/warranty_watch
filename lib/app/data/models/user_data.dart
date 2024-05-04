import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:warranty_watch/app/app_library.dart';

part 'user_data.g.dart';

@CopyWith()
@JsonSerializable()
@autoequal
class UserData extends Equatable {
  const UserData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.agreedToServices,
  });

  factory UserData.fromJson(Map<dynamic, dynamic> json) =>
      _$UserDataFromJson(json);

  const UserData.create({
    required String firstName,
    required String lastName,
    required String email,
    required bool agreedToServices,
  }) : this(
          firstName: firstName,
          lastName: lastName,
          email: email,
          agreedToServices: agreedToServices,
        );

  final String email;
  final String firstName;
  final String lastName;
  final bool agreedToServices;

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  @override
  List<Object?> get props => _$props;
}
