import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/app_text_style.dart';
import 'package:se7ety/feature/auth/presentation/view/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC50XAJti0mPVpVzHCx9dwGHskjzTwcJ4w',
          appId: 'com.example.se7ety',
          messagingSenderId: '929136657421',
          projectId: 'se7ety-95e42'));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          appBarTheme: AppBarTheme(
              backgroundColor: AppColors.white,
              elevation: 0,
              titleTextStyle: getTitleStyle(color: AppColors.white),
              actionsIconTheme: IconThemeData(color: AppColors.color1),
              centerTitle: true),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide.none,
            ),
            filled: true,
            suffixIconColor: AppColors.color1,
            prefixIconColor: AppColors.color1,
            fillColor: AppColors.scaffoldBG,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          fontFamily: GoogleFonts.cairo().fontFamily),
      home: const RegisterView(),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
  }
}
