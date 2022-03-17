import 'package:warranty_keeper/routes/path.dart';

class Paths {
  Paths._();

  static Path get initial => Path('');
  static Path get login => Path('login');
  static Path get settings => Path('settings');
  static WarrantyPath get warranty => WarrantyPath();
}

class WarrantyPath extends Path {
  WarrantyPath() : super('warranties');

  Path get newWarranty => Path('new', path);
  Path get current => Path('current', path);
  PathWithParam get selected => PathWithParam(
        'selected',
        'selectedId',
        path: path,
      );
}
