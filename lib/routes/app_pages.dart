import 'package:get/get.dart';
import 'package:velocityx/binding/bindings.dart';
import 'package:velocityx/controllers/metaDataController.dart';
import 'package:velocityx/models/file_stats.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/models/user_categories.dart';
import 'package:velocityx/screens/ContactCard/ContactCard.dart';
import 'package:velocityx/screens/DocumentCreation/document_creation.dart';
import 'package:velocityx/screens/DocumentEditing/DocumentEditing.dart';
import 'package:velocityx/screens/FAQ/faq.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/Files/Files.dart';
import 'package:velocityx/screens/Home/HomeWrapper.dart';
import 'package:velocityx/screens/Home/home.dart';
import 'package:velocityx/screens/Organization/Orgdirectory.dart';
import 'package:velocityx/screens/Organization/OrgdirectoryWrapper.dart';
import 'package:velocityx/screens/PdfViewer/pdf_viewer.dart';
import 'package:velocityx/screens/PdfViewerWeb/pdf_viewer_web.dart';
import 'package:velocityx/screens/QRCodeGeneration/QrCreator.dart';
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
      page: () => FileInformation(
        FileStat: FileStatsModel(),
      ),
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
      page: () => Viewer(
        document: '',
      ),

      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PDFWEBVIEWER,
      page: () => PdfViewerWeb(document: ""),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.QR_CODE,
      page: () => QrCreator(
        qrCodeOfInput: "Null",
      ),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_CARD,
      page: () => ContactPage(index: ''),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DOC_CREATOR,
      page: () => DocumentCreation(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DOC_EDITING,
      page: () => DocumentEditing(File: FilesModel()),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FILES,
      page: () => Files(category: CategoryModel()),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => FAQPage(),
      // binding: HomeBinding(),
    ),
  ];
}
