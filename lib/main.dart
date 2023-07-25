import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_app/theme.dart';
import 'package:nike_ecommerce_app/ui/auth/auth.dart';
import 'package:nike_ecommerce_app/ui/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      fontFamily: 'IranYekan',
      color: LightThemeColors.primaryTextColor,
    );
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: LightThemeColors.primaryTextColor,
          elevation: 0,
        ),
        textTheme: TextTheme(
            titleMedium: defaultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor),
            bodyMedium: defaultTextStyle,
            bodySmall: defaultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor),
            titleLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.bold)),
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondaryColor,
          onSecondary: Colors.white,
          surfaceVariant: Color(0xfff5f5f5),
        ),
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: RootScreen(),
      ),
    );
  }
}
