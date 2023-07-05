import 'package:go_router_paths/go_router_paths.dart';

class Paths {
  const Paths._();

  static Path get initial => Path('');
  static LoginPath get login => LoginPath();
  static HomePath get home => HomePath();
}

class LoginPath extends Path {
  LoginPath() : super('login');

  Path get forgotPassword => Path('forgot-password', parent: this);
}

class HomePath extends Path {
  HomePath() : super('home');

  Path get newWarranty => Path('new-warranty', parent: this);
  Path get currentWarranty => Path('current-warranty', parent: this);
  Path get warrantyDetails => Path('warranty-details', parent: this);
  Path get settings => Path('settings', parent: this);
}
