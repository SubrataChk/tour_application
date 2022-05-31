import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_application/src/routes/routes.dart';
import 'package:tour_application/src/service/auth_service.dart';
import 'package:tour_application/src/service/firestore_method.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirestoreMethod(),
        )
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      name: "Shelter",
      options: FirebaseOptions(
          apiKey: "AIzaSyAG3XbL1fvUzSLP-2hnwqW3WJTYxjHrK7o",
          appId: "1:973832058133:android:f819caa68f9300783ce51c",
          messagingSenderId: "973832058133",
          projectId: "tour-application-flutter"));

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.red),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return MyApp();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SR Travel Agency',
      theme: ThemeData.light(),
      initialRoute: splash,
      getPages: getPages,
    );
  }
}
