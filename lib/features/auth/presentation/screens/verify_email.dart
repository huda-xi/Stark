import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:stark/core/app_colors.dart';
import 'package:stark/core/app_text_style.dart';
import 'package:stark/core/controllers.dart';
import 'package:stark/features/auth/presentation/cubits/auth_cubits.dart';
import 'package:stark/features/auth/presentation/cubits/cubit_states.dart';
import 'package:stark/features/auth/presentation/customs/button_custom.dart';
import 'package:stark/features/auth/presentation/customs/otp_textfeild_custom.dart';
import 'package:stark/features/auth/presentation/customs/textfeild_custom.dart';
import 'package:stark/features/home/presentation/screens/home_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key, required this.email});

  final String email;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final f1 = FocusNode();
  final f2 = FocusNode();
  final f3 = FocusNode();
  final f4 = FocusNode();
  final f5 = FocusNode();
  final f6 = FocusNode();

  void verifyOtp() {
  final state = context.read<VerifyEmailCubit>().state;

  if (state is VerifyEmailLoading) return;

  final otp = [
    c1.text,
    c2.text,
    c3.text,
    c4.text,
    c5.text,
    c6.text,
  ].join();

  if (otp.length != 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter all 6 digits'),
      ),
    );
    return;
  }

  context.read<VerifyEmailCubit>().verifyEmail(
    email: widget.email,
    otp: otp,
  );
}

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyEmailCubit, VerifyEmailStates>(
      listener: (context, state) {
        if (state is VerifyEmailSuccess) {

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        }

        if (state is VerifyEmailFailure) {

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final loading = state is VerifyEmailLoading;
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(30),
                    Text(
                      'Verify Your Email',
                      style: AppTextStyles.style28Medium,
                    ),
                    Gap(10),
                    Text(
                      'We have dispatched an ephemeral 6-digit cryptographic security key to activate your private client privileges.',
                      style: AppTextStyles.style14regular.copyWith(
                        color: AppColors.rememberGrey,
                      ),
                    ),
                    Gap(30),

                    TextfeildCustom(
                      text: 'Recipient Account',
                      hint: widget.email,
                      suffixicon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                      ),
                    ),
                    Gap(25),

                    Container(
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'ONE-TIME TOKEN',
                                  style: AppTextStyles.style12SemiBold.copyWith(
                                    color: AppColors.textGrey,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.auto_awesome,
                                        color: AppColors.textBrown,
                                      ),
                                      Text(
                                        'AUTO-FILL',
                                        style: AppTextStyles.style12SemiBold
                                            .copyWith(
                                              color: AppColors.textBrown,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Gap(25),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OtpTextfeildCustom(
                                  first: true,
                                  last: false,
                                  controller: c1,
                                  focusNode: f1,
                                  nextFocusNode: f2,
                                ),
                                OtpTextfeildCustom(
                                  first: false,
                                  last: false,
                                  controller: c2,
                                  focusNode: f2,
                                  nextFocusNode: f3,
                                  previousFocusNode: f1,
                                ),
                                OtpTextfeildCustom(
                                  first: false,
                                  last: false,
                                  controller: c3,
                                  focusNode: f3,
                                  nextFocusNode: f4,
                                  previousFocusNode: f2,
                                ),
                                OtpTextfeildCustom(
                                  first: false,
                                  last: false,
                                  controller: c4,
                                  focusNode: f4,
                                  nextFocusNode: f5,
                                  previousFocusNode: f3,
                                ),
                                OtpTextfeildCustom(
                                  first: false,
                                  last: false,
                                  controller: c5,
                                  focusNode: f5,
                                  nextFocusNode: f6,
                                  previousFocusNode: f4,
                                ),
                                OtpTextfeildCustom(
                                  first: false,
                                  last: true,
                                  controller: c6,
                                  focusNode: f6,
                                  previousFocusNode: f5,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      verifyOtp();
                                    }
                                  },
                                ),
                              ],
                            ),

                            Gap(25),

                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: AppColors.textGrey,
                                ),
                                Text(
                                  ' Expires in 04:47',
                                  style: AppTextStyles.style12SemiBold.copyWith(
                                    color: AppColors.textGrey,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  child: Text(
                                    'RESEND CODE',
                                    style: AppTextStyles.style12SemiBold
                                        .copyWith(color: AppColors.textBrown),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Gap(20),

                    ButtonCustom(
                      title:  loading? 'Verifying...' : 'Verify Email ->',
                      onpressed: loading ? () {} : verifyOtp,
                    ),

                    Gap(30),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.boxbackground,
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: AppColors.textBrown,
                            ),

                            SizedBox(width: 7),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Key Delivery Advisory',
                                    style: AppTextStyles.style17SemiBold
                                        .copyWith(color: AppColors.textBlack),
                                  ),
                                  Text(
                                    'Transmission takes up to 45 seconds through encrypted relays. If undetected in your inbox, consult your spam vault or re-dispatch.',

                                    style: AppTextStyles.style12Medium.copyWith(
                                      color: AppColors.rememberGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    f5.dispose();
    f6.dispose();
    super.dispose();
  }
}
