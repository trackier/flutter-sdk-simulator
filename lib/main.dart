import 'package:flutter/material.dart';
import 'package:flutter_simulator/Screens/HomeScreen.dart';
import 'package:flutter_simulator/Screens/SplashScreen.dart';
import 'package:trackier_sdk_flutter/trackierconfig.dart';
import 'package:trackier_sdk_flutter/trackierfluttersdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:app_links/app_links.dart';
import 'Screens/BuildinEventScreen.dart';
import 'Screens/CustomEventsScreen.dart';
import 'Screens/DeepLinkScreen.dart';
import 'Screens/ProductPageScreen.dart';
import 'Screens/AddToCartScreen.dart';
import 'Screens/CakeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the environment variables from the .env file
  await dotenv.load();

  // Initialize SDKs
  _initializeSDKs();

  // Handle deep link logic before running the app
  final Uri? initialDeepLink = await _getInitialDeepLink();

  runApp(MyApp(initialDeepLink: initialDeepLink));
}

class MyApp extends StatelessWidget {
  final Uri? initialDeepLink;

  const MyApp({super.key, required this.initialDeepLink});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      home: initialDeepLink != null
          ? _handleInitialDeepLink(context, initialDeepLink!)
          : SplashScreen(),
      routes: {
        '/builtInEvents': (context) => BuiltInEventsScreen(),
        '/customsEvents': (context) => CustomsEventsScreen(),
        '/deepLinking': (context) => DeepLinkingScreen(),
        '/productPage': (context) => ProductPageScreen(),
        '/addtocart': (context) => AddToCartScreen(),
        '/cakeActivity': (context) => CakeScreen(),
      },
    );
  }

  Widget _handleInitialDeepLink(BuildContext context, Uri deepLink) {
    String? productId = deepLink.queryParameters['product_id'];
    String? quantity = deepLink.queryParameters['quantity'];
    String? actionData = deepLink.queryParameters['actionData'];
    String? dlv = deepLink.queryParameters['dlv'];

    if (deepLink.pathSegments.isNotEmpty && deepLink.pathSegments[0] == 'd') {
      return CakeScreen(
        productId: productId,
        quantity: quantity,
        actionData: actionData,
        dlv: dlv,
      );
    }

    return EventsTrackingScreen();
  }
}

void _initializeSDKs() async {
  try {
    // Get the environment variables directly from dotenv
    final trDevKey = dotenv.env['TR_DEV_KEY'] ?? "default_value";
    final secretId = dotenv.env['SECRET_ID'] ?? "default_value";
    final secretKey = dotenv.env['SECRET_KEY'] ?? "default_value";

    final trackerSDKConfig = TrackerSDKConfig(trDevKey, "development");

    // Set user details
    Trackierfluttersdk.setUserId("009013452535353");
    Trackierfluttersdk.setUserEmail("sanu@gmail.com");
    Trackierfluttersdk.setUserName("SanuTest");
    Trackierfluttersdk.setUserPhone("8130300721");

    // Set app secrets
    trackerSDKConfig.setAppSecret(secretId,secretKey);

    // Initialize Trackier SDK
    Trackierfluttersdk.initializeSDK(trackerSDKConfig);
    print("Trackier SDK initialized successfully.");
  } catch (e) {
    print("Error initializing Trackier SDK: $e");
  }
}

Future<Uri?> _getInitialDeepLink() async {
  try {
    final appLinks = AppLinks();
    final Uri? initialLink = await appLinks.getInitialLink();
    return initialLink;
  } catch (e) {
    print("Error retrieving initial deep link: $e");
    return null;
  }
}
