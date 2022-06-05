part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const SIGNIN = _Paths.SIGNIN;
  static const HOME = _Paths.HOME;
  static const FILE_INFORMATION = _Paths.FILE_INFORMATION;
  static const METADATA = _Paths.METADATA;
  static const SCANNER = _Paths.SCANNER;
}

abstract class _Paths {
  static const SPLASH = '/Splash';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const SIGNIN = '/sign_in';
  static const HOME = '/home';
  static const FILE_INFORMATION = "/File_information";
  static const METADATA = '/metadata';
  static const SCANNER = '/scanner';
  // static const METADATA = '/metadata';
  // static const METADATA = '/metadata';
}
