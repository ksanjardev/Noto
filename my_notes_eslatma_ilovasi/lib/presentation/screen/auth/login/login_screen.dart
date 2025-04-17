import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/components/auth_button.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/components/input_comp.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/res/app_strings.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/screen/auth/login/bloc/login_bloc.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/screen/auth/register/register_screen.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/screen/home/home_screen.dart';
import 'package:my_notes_eslatma_ilovasi/utils/status_enum.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final bloc = LoginBloc();

  @override
  void initState() {
    userNameController.addListener(_onTextChanged);
    passwordController.addListener(_onTextChanged);
    super.initState();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    bloc.close();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: Color(0xFF00224F),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            switch (state.status) {
              case Status.loading:
                break;
              case Status.success:
                context.push(HomeScreen());
              case Status.fail:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMsg.toString()),
                    backgroundColor: Colors.red,
                  ),
                );
              case Status.initial:
                break;
            }
          },
          builder: (context, state) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.welcomeBack,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  Gap(8),
                  Text(
                    AppStrings.welcomeMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Color(0xFF667a95)),
                  ).paddingSymmetric(horizontal: 100),
                  Gap(50),
                  CustomTextField(
                          isPassword: false,
                          controller: userNameController,
                          hint: AppStrings.userName,
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ).paddingOnly(right: 5))
                      .paddingSymmetric(horizontal: 20),
                  Gap(20),
                  CustomTextField(
                          isPassword: true,
                          controller: passwordController,
                          hint: AppStrings.password,
                          icon: Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                            size: 30,
                          ).paddingOnly(right: 7))
                      .paddingSymmetric(horizontal: 20),
                  Gap(30),
                  AuthButton(
                      text: AppStrings.login,
                      isActive: userNameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty,
                      isLoading: state.status == Status.loading,
                      onTap: () {
                        context.read<LoginBloc>().add(OnLoginClick(
                            userName: userNameController.text.trim(),
                            password: passwordController.text.trim()));
                      }).paddingSymmetric(horizontal: 50),
                  Gap(10),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '${AppStrings.notHaveAccount}\u00A0',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push(RegisterScreen());
                          },
                        text: AppStrings.signIn,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.blue))
                  ]))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
