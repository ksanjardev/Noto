import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/screen/auth/register/bloc/register_bloc.dart';
import 'package:my_notes_eslatma_ilovasi/utils/status_enum.dart';

import '../../../components/auth_button.dart';
import '../../../components/input_comp.dart';
import '../../../res/app_strings.dart';
import '../../home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final bloc = RegisterBloc();

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
        body: BlocConsumer<RegisterBloc, RegisterState>(
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
                    AppStrings.welcomeRegister,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  Gap(8),
                  Text(
                    AppStrings.welcomeMessageRegister,
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
                      text: AppStrings.register,
                      isActive: userNameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty,
                      isLoading: state.status == Status.loading,
                      onTap: () {
                        context.read<RegisterBloc>().add(OnRegisterClick(
                            userName: userNameController.text.trim(),
                            password: passwordController.text.trim()));
                      }).paddingSymmetric(horizontal: 50),
                  Gap(10),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '${AppStrings.haveAccount}\u00A0',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pop();
                          },
                        text: AppStrings.signUp,
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
