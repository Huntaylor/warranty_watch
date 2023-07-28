import 'package:warranty_keeper/data/models/user_data.dart';

abstract class IUserCollection {
  Future<UserData> getUserData();
}
