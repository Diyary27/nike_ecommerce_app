import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_app/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_app/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_app/ui/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onBackground = Colors.white;
    final TextEditingController _username = TextEditingController();
    final TextEditingController _password = TextEditingController();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
          data: themeData.copyWith(
            snackBarTheme: SnackBarThemeData(
              backgroundColor: themeData.colorScheme.primary,
              contentTextStyle: TextStyle(fontFamily: 'IranYekan'),
            ),
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
            colorScheme:
                themeData.colorScheme.copyWith(onSurface: onBackground),
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
            body: BlocProvider<AuthBloc>(
              create: (context) {
                final bloc = AuthBloc(authRepository);
                bloc.add(AuthStarted());
                bloc.stream.forEach((state) {
                  if (state is AuthSuccess) {
                    cartRepository.count();
                    Navigator.of(context).pop();
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      state.exception.message,
                      style: TextStyle(color: Colors.red),
                    )));
                  }
                });
                return bloc;
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) {
                    return current is AuthInitial ||
                        current is AuthLoading ||
                        current is AuthError;
                  },
                  builder: (context, state) {
                    return Column(
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
                          state.isLoginMode ? 'خوش آمدید' : 'ثبت نام',
                          style: TextStyle(
                            color: onBackground,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          state.isLoginMode
                              ? 'لطفا وارد حساب کاربری خود شوید'
                              : 'حساب کاربری جدید ایجاد کنید',
                          style: TextStyle(color: onBackground),
                        ),
                        SizedBox(height: 24),
                        TextField(
                          controller: _username,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            label: Text('آدرس ایمیل'),
                          ),
                        ),
                        SizedBox(height: 16),
                        _PasswordTextField(
                          onBackground: onBackground,
                          controller: _password,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<AuthBloc>(context).add(
                                AuthButtonIsClicked(
                                    _username.text, _password.text));
                          },
                          child: state is AuthLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  state.isLoginMode ? 'ورود' : 'ثبت نام',
                                ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.isLoginMode
                                  ? 'حساب کاربری ندارید؟'
                                  : 'حساب کاربری دارید؟',
                              style: TextStyle(
                                  color: onBackground.withOpacity(0.7)),
                            ),
                            TextButton(
                              onPressed: () async {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(AuthModeChangeIsClicked());
                              },
                              child: Text(
                                state.isLoginMode ? 'ثبت نام' : 'ورود',
                                style: TextStyle(
                                    color: themeData.colorScheme.primary,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          )),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  _PasswordTextField({
    super.key,
    required this.onBackground,
    required this.controller,
  });

  final Color onBackground;
  final TextEditingController controller;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool passHide = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
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
