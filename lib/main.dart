import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:o_kay_sellers/constants/colors.dart'; // Updated import
import 'package:o_kay_sellers/providers/location_provider.dart'; // Updated import
import 'package:o_kay_sellers/providers/register_shop_provider.dart'; // Updated import
import 'package:o_kay_sellers/providers/authentication_provider.dart'; // Updated import
import 'package:o_kay_sellers/providers/internet_provider.dart'; // Updated import
import 'package:o_kay_sellers/router.dart'; // Updated import
import 'package:o_kay_sellers/splash_screen/screens/splash_screen.dart'; // Updated import
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => InternetProvider()),
        ChangeNotifierProvider(create: (context) => RegisterShopProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'o_kay_sellers', // Updated app title
        theme: ThemeData(
          // useMaterial3: true,
          colorScheme: scheme,
          scaffoldBackgroundColor: Colors.white,
          dialogBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          unselectedWidgetColor: Color.fromARGB(255, 16, 2, 214),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const SplashScreen(),
      ),
    );
  }
}
