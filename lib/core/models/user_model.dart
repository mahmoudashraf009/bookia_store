import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';


@HiveType(typeId: 0)
class UserModel {

  @HiveField(0)
   String email;

  @HiveField(1)
   String password;

  UserModel({
    required this.email,
    required this.password,
  });
}