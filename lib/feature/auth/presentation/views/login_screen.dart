import 'package:easacc_task/core/constant/widgets/custom_elevated_button.dart';
import 'package:easacc_task/core/utils/app_colors.dart';
import 'package:easacc_task/core/utils/app_image.dart';
import 'package:easacc_task/core/utils/app_text.dart';
import 'package:easacc_task/core/utils/text_style.dart';
import 'package:easacc_task/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:easacc_task/feature/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
            listener: (context, state) {
              if (state is GoogleAuthFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is GoogleAuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('successfully logged in')),
                );

                Navigator.pushNamed(context, '/SettingsPage');
              }
            },
            builder: (context, state) {
              final isLoading = state is GoogleAuthLoading;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  const Text(
                    AppText.welcomeTitle,
                    style: AppTextStyle.textStyleBold32,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    AppText.loginToContinue,
                    style: AppTextStyle.textStyleRegular16,
                  ),
                  const Spacer(flex: 2),
                  // Login with Google Button
                  SocialButton(
                    text: AppText.loginWithGoogle,
                    backgroundColor: AppColors.primaryColor,
                    textColor: AppColors.black,
                    onPressed: () {
                      context.read<GoogleAuthCubit>().signInWithGoogle();
                    },
                    image: AppImage.googleLogo,
                  ),
                  const SizedBox(height: 16),
                  // Login with Facebook Button
                  SocialButton(
                    text: AppText.loginWithFacebook,
                    backgroundColor: AppColors.secondaryColor,
                    textColor: AppColors.primaryColor,
                    onPressed: () {
                      context.read<GoogleAuthCubit>().signInWithFacebook();
                    },
                    image: AppImage.facebookLogo,
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: AppTextStyle.textStyleRegular12,
                      children: [
                        TextSpan(text: 'By continuing, you agree to our '),
                        TextSpan(
                          text: 'Terms',
                          style: AppTextStyle.textStyleRegularUnderline,
                        ),
                        TextSpan(text: ' & '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: AppTextStyle.textStyleRegularUnderline,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 3),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
