import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizz/controllers/auth_controller.dart';

import '../commons/custom_text.dart';
import '../commons/custom_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _passEditingController.dispose();
  }

  void login() {
    ref.read(authControllerProvider.notifier).login(
          email: _textEditingController.text.trim(),
          pass: _passEditingController.text.trim(),
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(authControllerProvider);
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                width: double.infinity,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                    //logo
                    const Center(
                      child: CustomText(shadow: [
                        Shadow(
                          blurRadius: 80,
                          color: Colors.blue,
                        )
                      ], text: 'QUIZZ', fontSize: 70),
                    ),
                    //gap
                    const SizedBox(
                      height: 60.0,
                    ),
                    //text field email
                    CustomTextField(
                        textEditingController: _textEditingController,
                        text: 'Enter Email or Username',
                        textInputType: TextInputType.emailAddress),
                    //gap
                    const SizedBox(
                      height: 30,
                    ),
                    //text field password
                    CustomTextField(
                        textEditingController: _passEditingController,
                        text: 'Enter Password',
                        textInputType: TextInputType.text,
                        isPass: true),
                    const SizedBox(
                      height: 30,
                    ),
                    //login button
                    InkWell(
                      onTap:login,
                      child:
                          // child: _isLoading
                          //     ? const Center(
                          //         child: CircularProgressIndicator(
                          //           color: Colors.white,
                          //         ),
                          //       ):
                          Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            color: Colors.blue),
                        child: const Text('Log In'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                    //transition to signup
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.symmetric(vertical: 8),
                    //       child: const Text('Are You A New User ?'),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(vertical: 8),
                    //         child: const Text(
                    //           'Sign up',
                    //           style: TextStyle(fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
    );
  }
}
