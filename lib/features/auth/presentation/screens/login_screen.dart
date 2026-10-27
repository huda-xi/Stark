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
import 'package:stark/features/auth/presentation/screens/signup_screen.dart';
import 'package:stark/features/home/presentation/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassHidden = true;
  bool isEmailValidate = false;
  final GlobalKey<FormState> mykey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: mykey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  Text('Welcome Back', style: AppTextStyles.style28Medium),
                  Gap(5),
                  Text(
                    'Access your curated wardrobe and private allocations.',
                    style: AppTextStyles.style14regular.copyWith(
                      color: AppColors.textDarkBrown,
                    ),
                  ),
                  Gap(30),

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
                    controller: logemailctrl,
                    validator: (email) {
                      return Validator.validateEmail(email!);
                    },
                  ),

                  Gap(20),

                  TextfeildCustom(
                    obscureText: isPassHidden,
                    text: 'Password',
                    hint: '••••••••••••',
                    suffixicon: IconButton(
                      onPressed: () {
                        setState(() {});
                        isPassHidden = !isPassHidden;
                      },
                      icon: isPassHidden
                          ? Icon(Icons.visibility_off_outlined)
                          : Icon(Icons.visibility_outlined),
                    ),
                    controller: logpassctrl,
                    validator: (pass) {
                      return Validator.validatePassword(pass!);
                    },
                  ),
                  Gap(5),

                  Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: AppTextStyles.style11Medium.copyWith(
                          color: AppColors.textBrown,
                        ),
                      ),
                    ),
                  ),
                  Gap(10),

                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Text(
                        "Remember me",
                        style: TextStyle(color: AppColors.rememberGrey),
                      ),

                      Spacer(),

                      Icon(
                        Icons.lock_outline_rounded,
                        size: 12,
                        color: AppColors.rememberGrey,
                      ),
                      Text(
                        '256-bit',
                        style: AppTextStyles.style11Medium.copyWith(
                          color: AppColors.rememberGrey,
                        ),
                      ),
                    ],
                  ),

                  Gap(5),

                  BlocConsumer<LogInCubit, LogInStates>(
                    listener: (context, state) {
                      if (state is LogInSuccess) {
                        ToastHelper.show(context, message: 'Welcome back');

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  HomeScreen(),
                          ),
                          (route) => false,
                        );
                      }

                      if (state is LogInFailure) {
                        debugPrint('LOGIN ERROR: ${state.message}');

                        ToastHelper.show(context, message: state.message);
                      }
                    },
                    builder: (context, state) {
                      return ButtonCustom(
                        title: state is LogInLoading ? 'Loading...' : 'Log In',
                        onpressed: () {
                          if (mykey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            context.read<LogInCubit>().postLogIn();
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
                        'New in STEARK? ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen())),
                        child: Text(
                          'Create Account',
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
