import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon/pages/login.dart';
import 'package:hackathon/pages/navBar.dart';
// import 'package:hackathon/pages/post.dart';
import 'package:hackathon/routes/routes.dart';
import 'package:hackathon/widgets/theme.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:velocity_x/velocity_x.dart';

FlutterSecureStorage token = FlutterSecureStorage();
String? tokenSave;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  String? tokenRead = await token.read(key: 'token');
  tokenSave = tokenRead;
  print(tokenRead);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final GlobalKey<MyAz> myWidgetKey = GlobalKey<_MyWidgetState>();\

  // const MyApp({super.key});
  static bool lightThemeData = true;
  @override
  Widget build(BuildContext context) {
    return VxApp(
        store: MyStore(),
        builder: (context, vxData) => MaterialApp(
              title: "Routine Application",
              debugShowCheckedModeBanner: false,
              // themeMode: ThemeMode.light,
              theme: vxData.isDarkMode
                  ? MyTheme.darkTheme(context)
                  : MyTheme.lightTheme(context),
              // darkTheme: MyTheme.darkTheme(context),
              initialRoute: tokenSave.isEmptyOrNull
                  ? MyRoutes.loginPage
                  : MyRoutes.homePage,
              routes: {
                MyRoutes.loginPage: (context) => LoginPage(),
                MyRoutes.homePage: (context) => NavBarContent(),
                // MyRoutes.postPage: (context) => PostPage()
              },
            ));
  }
}

class MyStore extends VxStore {}
