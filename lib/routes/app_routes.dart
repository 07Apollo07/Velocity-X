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
  static const ORGDIRECTORY = _Paths.ORGDIRECTORY;
  static const PROFILEPAGE = _Paths.PROFILEPAGE;
  static const PDFVIEWER = _Paths.PDFVIEWER;
  static const PDFWEBVIEWER = _Paths.PDFWEBVIEWER;
  static const QR_CODE = _Paths.QR_CODE;
  static const CONTACT_CARD = _Paths.CONTACT_CARD;
  static const DOC_CREATOR = _Paths.DOC_CREATOR;
  static const DOC_EDITING = _Paths.DOC_EDITING;
  static const FILES = _Paths.FILES;
  static const FAQ = _Paths.FAQ;
}

abstract class _Paths {
  static const SPLASH = '/';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const SIGNIN = '/sign_in';
  static const HOME = '/home';
  static const FILE_INFORMATION = "/file_information";
  static const METADATA = '/metadata';
  static const SCANNER = '/scanner';
  static const ORGDIRECTORY = '/organization_directory';
  static const PROFILEPAGE = '/profile';
  static const PDFVIEWER = '/pdf_viewer';
  static const PDFWEBVIEWER = '/pdf_web_viewer';
  static const QR_CODE = "/qr_code";
  static const CONTACT_CARD = "/contact_card";
  static const DOC_CREATOR = "/doc_creator";
  static const DOC_EDITING = "/doc_edit";
  static const FILES = "/files";
  static const FAQ = "/faq";
}
