import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onBackground = Colors.white;

    return Theme(
        data: themeData.copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(onBackground),
              foregroundColor:
                  MaterialStatePropertyAll(themeData.colorScheme.secondary),
              minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
            ),
          ),
          colorScheme: themeData.colorScheme.copyWith(onSurface: onBackground),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            labelStyle: TextStyle(
              color: onBackground,
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: themeData.colorScheme.secondary,
          body: Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/nike_logo.png',
                  color: onBackground,
                  width: 120,
                ),
                SizedBox(height: 24),
                Text(
                  isLogin ? 'خوش آمدید' : 'ثبت نام',
                  style: TextStyle(
                    color: onBackground,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  isLogin
                      ? 'لطفا وارد حساب کاربری خود شوید'
                      : 'حساب کاربری جدید ایجاد کنید',
                  style: TextStyle(color: onBackground),
                ),
                SizedBox(height: 24),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text('آدرس ایمیل'),
                  ),
                ),
                SizedBox(height: 16),
                _PasswordTextField(onBackground: onBackground),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(isLogin ? 'ورود' : 'ثبت نام'),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin ? 'حساب کاربری ندارید؟' : 'حساب کاربری دارید؟',
                      style: TextStyle(color: onBackground.withOpacity(0.7)),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin ? 'ثبت نام' : 'ورود',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    super.key,
    required this.onBackground,
  });

  final Color onBackground;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool passHide = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: passHide,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              passHide = !passHide;
            });
          },
          icon: Icon(
            passHide
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: widget.onBackground.withOpacity(0.6),
          ),
        ),
        label: Text('رمز عبور'),
      ),
    );
  }
}
