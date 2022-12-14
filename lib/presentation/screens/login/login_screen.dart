import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/bussiness/login_cubit/login_cubit.dart';
import 'package:test_flutter/presentation/common/loading_widget.dart';
import 'package:test_flutter/util/consant/const_text.dart';
import 'package:test_flutter/util/consant/pages.dart';
import 'package:test_flutter/util/validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("login"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                key: const Key("emailKey"),
                controller: _emailController,
                decoration: const InputDecoration(label: Text("Email")),
                validator: (val) {
                  if (Validation.email("$val")) return null;
                  return Messages.invalidEmail;
                },
              ),
              TextFormField(
                key: const ValueKey("passwordKey"),
                controller: _passwordController,
                decoration: const InputDecoration(label: Text("password")),
                validator: (val) {
                  if (Validation.password("$val")) return null;
                  return Messages.invalidPassword;
                },
              ),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginErrorState) {
                    _passwordController.clear();
                    final snackBar = SnackBar(
                      content: Text(state.exception.toString()),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (state is LoginSuccessState) {
                    Navigator.of(context).pushNamed(Pages.home);
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoadingState) {
                    return const LoadingWidget();
                  }
                  return ElevatedButton(
                    key: const ValueKey("loginBtnKey"),
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        context.read<LoginCubit>().login(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                      }
                    },
                    child: const Text("login"),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
