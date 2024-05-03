import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railgram/features/PnrNumber/provider/pnrdataprovider.dart';

import 'package:railgram/features/auth/screens/userlogin.dart';
import 'package:railgram/features/auth/screens/userregister.dart';
import 'package:railgram/features/community/provider/chatprovider.dart';
import 'package:railgram/features/community/provider/pnrprovider.dart';
import 'package:railgram/features/posts/globalPost/provider/commentprovider.dart';
// import 'package:railgram/features/posts/globalPost/provider/globalpostprovider.dart';

import 'package:railgram/features/posts/post/provider/postprovider.dart';

import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:railgram/features/splashscreen.dart';
import 'package:railgram/responsive/mobile_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/community/provider/communityprovider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var userid = preferences.getInt('userid');
  var pnr = preferences.getString('PNRNUMBER');
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommunityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PnrProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PnrDataProvider(),
        )
      ],
      child: MyApp(
        userid: userid,
      )));
}

class MyApp extends StatefulWidget {
  final int? userid;
  final String? pnr;
  const MyApp({super.key, required this.userid, this.pnr});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rail Gram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/login': (context) => const UserLogin(),
        '/register': (context) => const UserRegister(),
        '/mobile': (context) => const MobileScreenLayout(),
      },
      home: SplashScreen(userid: widget.userid, pnr: widget.pnr),
      themeMode: ThemeMode.light,
    );
  }
}
