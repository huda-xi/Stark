import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:stark/core/app_colors.dart';
import 'package:stark/core/app_text_style.dart';
import 'package:stark/core/controllers.dart';
import 'package:stark/core/toastHealper.dart';
import 'package:stark/core/validator.dart';
import 'package:stark/features/auth/presentation/cubits/auth_cubits.dart';
import 'package:stark/features/auth/presentation/cubits/cubit_states.dart';
import 'package:stark/features/auth/presentation/customs/button_custom.dart';
import 'package:stark/features/auth/presentation/customs/continue_button.dart';
import 'package:stark/features/auth/presentation/customs/textfeild_custom.dart';
import 'package:stark/features/auth/presentation/screens/login_screen.dart';
import 'package:stark/features/auth/presentation/screens/verify_email.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPassHidden = true;
  bool isEmailValidate = false;
  final GlobalKey<FormState> mykey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: mykey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Your Account',
                    style: AppTextStyles.style28Medium,
                  ),
                  Text(
                    'Join STARK and discover something exceptional.',
                    style: AppTextStyles.style14regular.copyWith(
                      color: AppColors.textDarkBrown,
                    ),
                  ),
                  Gap(30),

                  TextfeildCustom(
                    text: 'First Name',
                    hint: 'huda',
                    controller: fnamectrl,
                    validator: (name) {
                      return Validator.validateUserName(name!);
                    },
                  ),
                  Gap(15),
                  TextfeildCustom(
                    text: 'Last Name',
                    hint: 'yasser',
                    controller: lnamectrl,
                    validator: (name) {
                      return Validator.validateUserName(name!);
                    },
                  ),
                  Gap(15),
                  TextfeildCustom(
                    text: 'Email',
                    hint: 'hudayasser@gmail.com',
                    onChanged: (value) {
                      setState(() {
                        isEmailValidate =
                            Validator.validateEmail(value) == null;
                      });
                    },
                    suffixicon: Icon(
                      isEmailValidate
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: isEmailValidate ? Colors.green : Colors.grey,
                    ),
                    controller: emailctrl,
                    validator: (email) {
                      return Validator.validateEmail(email!);
                    },
                  ),
                  Gap(15),
                  TextfeildCustom(
                    obscureText: isPassHidden,
                    text: 'PASSWORD',
                    hint: '..........',
                    suffixicon: IconButton(
                      onPressed: () {
                        setState(() {});
                        isPassHidden = !isPassHidden;
                      },
                      icon: isPassHidden
                          ? Icon(Icons.visibility_off_outlined)
                          : Icon(Icons.visibility_outlined),
                    ),
                    controller: passctrl,
                    validator: (pass) {
                      return Validator.validatePassword(pass!);
                    },
                  ),

                  Gap(20),

                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Expanded(
                        child: Text(
                          "I agree to the Terms & Conditions and Privacy Policy.",
                          style: TextStyle(color: AppColors.rememberGrey),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Expanded(
                        child: Text(
                          "Receive private salon invitations and bespoke runway allocations.",
                          style: TextStyle(color: AppColors.rememberGrey),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  BlocConsumer<SignUpCubit, SignUpStates>(
                    listener: (context, state) {
                      debugPrint('SIGNUP STATE: ${state.runtimeType}');

                      if (state is SignUpSuccess) {
                        debugPrint('SIGNUP SUCCESS - NAVIGATING');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VerifyEmailScreen(email: emailctrl.text.trim()),
                          ),
                        );
                      }

                      if (state is SignUpFailure) {
                        debugPrint('SIGNUP FAILURE: ${state.message}');

                        ToastHelper.show(context, message: state.message);
                      }
                    },
                    builder: (context, state) {
                      return ButtonCustom(
                        title: state is SignUpLoading
                            ? 'Loading...'
                            : 'Create Account',
                        onpressed: () {
                          if (mykey.currentState!.validate()) {
                            context.read<SignUpCubit>().postSignUp();
                          }
                        },
                      );
                    },
                  ),
                  Gap(20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey, thickness: 0.5),
                      ),
                      Text(
                        ' OR CONTINUE WITH ',
                        style: AppTextStyles.style12SemiBold.copyWith(
                          color: AppColors.textDarkBrown,
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey, thickness: 0.5),
                      ),
                    ],
                  ),
                  Gap(20),
                  ContinueButton(),

                  Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())),
                        child: Text(
                          'LOG IN',
                          style: TextStyle(color: AppColors.textBrown),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
