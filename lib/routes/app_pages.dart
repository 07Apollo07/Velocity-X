import 'package:get/get.dart';
import 'package:velocityx/binding/bindings.dart';
import 'package:velocityx/controllers/metaDataController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/Home/HomeWrapper.dart';
import 'package:velocityx/screens/Home/home.dart';
import 'package:velocityx/screens/Organization/Orgdirectory.dart';
import 'package:velocityx/screens/Organization/OrgdirectoryWrapper.dart';
import 'package:velocityx/screens/PdfViewer/pdf_viewer.dart';
import 'package:velocityx/screens/PdfViewerWeb/pdf_viewer_web.dart';
import 'package:velocityx/screens/Scanner/Scanner.dart';
import 'package:velocityx/screens/UserProfile/profile.dart';
import 'package:velocityx/screens/UserProfile/profileWrapper.dart';
import 'package:velocityx/screens/authenticate/login_page.dart';
import 'package:velocityx/screens/authenticate/register_page.dart';
import 'package:velocityx/screens/authenticate/sign_in.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';
import 'package:velocityx/screens/splash.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => Login(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => Register(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SignIn(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeWrapper(),
      // binding: StoreBindings(),
    ),
    GetPage(
      name: _Paths.FILE_INFORMATION,
      page: () => FileInformation(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.METADATA,
      page: () => MetaDataPage(File: FilesModel()),
      // binding: MetaDataController(),
    ),
    GetPage(
      name: _Paths.SCANNER,
      page: () => Scanner(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ORGDIRECTORY,
      page: () => OrgDirectoryWrapper(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILEPAGE,
      page: () => ProfileWrapper(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PDFVIEWER,
      page: () => Viewer(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PDFWEBVIEWER,
      page: () => PdfViewerWeb(),
      // binding: HomeBinding(),
    ),
  ];
}
