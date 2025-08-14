import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:govconnect_app/screens/auth/forgot_password_page.dart';
import 'package:govconnect_app/screens/auth/otp_confirmation_page.dart';
import 'package:govconnect_app/screens/auth/register_page.dart';
import 'package:govconnect_app/screens/welcome_page.dart';
import 'package:govconnect_app/screens/auth/login_page.dart';
import 'package:govconnect_app/widgets/main_navigation_wrapper.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    // Authentication routes (no bottom nav)
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const GovConnectWelcomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.otpConfirmation,
      builder: (context, state) => const OTPConfirmationScreen(),
    ),

    // User routes
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const MainNavigationWrapper(initialIndex: 0),
    ),
    GoRoute(
      path: '/tasks',
      builder: (context, state) => const MainNavigationWrapper(initialIndex: 1),
    ),
    GoRoute(
      path: '/appointments',
      builder: (context, state) => const MainNavigationWrapper(initialIndex: 2),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const MainNavigationWrapper(initialIndex: 3),
    ),

    // Admin routes
    GoRoute(
      path: '/admin/dashboard',
      builder: (context, state) => const MainNavigationWrapper(initialIndex: 0),
    ),
    GoRoute(
      path: '/admin/tasks',
      builder: (context, state) => const MainNavigationWrapper(initialIndex: 1),
    ),
    GoRoute(
      path: '/admin/appointments',
      builder: (context, state) => const MainNavigationWrapper(initialIndex: 2),
    ),
    GoRoute(
      path: '/admin/profile',
      builder: (context, state) => const MainNavigationWrapper(initialIndex: 3),
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text('Page not found')),
  ),
);