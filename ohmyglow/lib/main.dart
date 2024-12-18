import 'package:flutter/material.dart';
import 'package:ohmyglow/guestMainScreen.dart';
import 'package:ohmyglow/mainScreen.dart';
import 'package:ohmyglow/utils/token_storage.dart';

// late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the cameras and handle any errors that may occur.
  // try {
  //   _cameras = await availableCameras();
  // } catch (e) {
  //   print('Error initializing cameras: $e');
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          colorSchemeSeed:
              Color(0xFFF8F8F8), //colorScheme bukan deepPurple tp #F8F8F8!!!
          useMaterial3: true,
          fontFamily: 'Inter'),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _scaleController;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize scale animation
    _scaleController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController!,
      curve: Curves.easeInOutCubicEmphasized,
    );

    // Check login status after a delay
    Future.delayed(Duration(seconds: 3), () async {
      _scaleController?.stop();

      // Check if the user is logged in
      bool loggedIn = await TokenStorage.isLoggedIn();

      // Navigate to the appropriate screen
      if (loggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  GuestMainScreen()), // Use GuestMainScreen here
        );
      }
    });
  }

  @override
  void dispose() {
    _scaleController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE9E0FC), Color(0xFFFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation!,
            child: Image.asset("images/logoSplash.png", width: 130),
          ),
        ),
      ),
    );
  }
}
