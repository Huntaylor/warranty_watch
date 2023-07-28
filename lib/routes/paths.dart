import 'package:go_router_paths/go_router_paths.dart';

class Paths {
  const Paths._();

  static Path get initial => Path('');
  static LoginPath get login => LoginPath();
  static HomePath get home => HomePath();
  static LoadingPath get loading => LoadingPath();
}

class LoginPath extends Path {
  LoginPath() : super('login');

  Path get forgotPassword => Path('forgot-password', parent: this);
  RegisterPath get register => RegisterPath(parent: this);
}

class HomePath extends Path {
  HomePath() : super('home');

  Path get newWarranty => Path('new-warranty', parent: this);
  WarrantyPath get warranties => WarrantyPath(parent: this);
  Path get settings => Path('settings', parent: this);
}

class LoadingPath extends Path {
  LoadingPath() : super('loading');
}

class RegisterPath extends Path {
  RegisterPath({required super.parent}) : super('register');

  Path get personalData => Path('personal-data', parent: this);
  Path get tos => Path('tos', parent: this);
}

class WarrantyPath extends Path {
  WarrantyPath({required super.parent}) : super('warranties');

  Path get details => Path('warranty-details', parent: this);
}
