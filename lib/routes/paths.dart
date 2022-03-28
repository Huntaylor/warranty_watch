import 'package:warranty_keeper/routes/path.dart';

class Paths {
  Paths._();

  static Path get initial => Path('');
  static Path get settings => Path('settings');
  // static Path get home => Path('home');
  // static Path get login => Path('login');
  static LoginPath get login => LoginPath();
  static Path get signup => Path('signup');
  static WarrantyPath get warranty => WarrantyPath();
}

class WarrantyPath extends Path {
  WarrantyPath() : super('warranties');

  Path get newWarranty => Path('new', path);
  Path get current => Path('current', path);
  Path get selected => Path('selected', path);
  // PathWithParam get selected => PathWithParam(
  //       'selected',
  //       'selectedId',
  //       path: path,
  //     );
}

class LoginPath extends Path {
  LoginPath() : super('login');

  Path get signup => Path('signup', path);
}
