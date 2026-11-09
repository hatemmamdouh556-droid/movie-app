import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app/cubit/language_cubit.dart';
import 'package:movies_app/features/auth/presentation/auth_gate.dart';
import 'package:movies_app/features/auth/presentation/screens/register_screen.dart';
import 'package:movies_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:movies_app/features/auth/presentation/screens/update_profile_screen.dart';
import 'package:movies_app/features/movie_details/presentation/screens/movie_details_screen.dart';
import 'package:movies_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:movies_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_prefs.dart';
import 'package:movies_app/utils/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) => MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: AppPrefs.onboardingSeen
            ? AppRoutes.homeRouteName
            : AppRoutes.onBoardingRouteName,
        routes: {
          AppRoutes.homeRouteName: (context) => const AuthGate(),
          AppRoutes.onBoardingRouteName: (context) => BlocProvider(
            create: (_) => OnboardingCubit(),
            child: const OnboardingScreen(),
          ),
          AppRoutes.registerRouteName: (context) => const RegisterScreen(),
          AppRoutes.forgotPasswordRouteName: (context) =>
              const ResetPasswordScreen(),
          AppRoutes.updateProfileRouteName: (context) =>
              const UpdateProfileScreen(),
          AppRoutes.detailsRouteName: (context) => const MovieDetailsScreen(),
        },
      ),
    );
  }
}
