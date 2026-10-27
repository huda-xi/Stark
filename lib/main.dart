
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stark/core/Api_Service.dart';
import 'package:stark/features/auth/log%20in/data/repo/repoImpl.dart';
import 'package:stark/features/auth/presentation/cubits/auth_cubits.dart';
import 'package:stark/features/auth/presentation/screens/login_screen.dart';
import 'package:stark/features/auth/presentation/screens/signup_screen.dart';
import 'package:stark/features/auth/signup/data/repo/signup_impl.dart';
import 'package:stark/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:stark/features/details/presentation/cubit/details_cubit.dart';
import 'package:stark/features/home/presentation/cubit/products_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LogInCubit(loginRepo: RepoImpl(apiService: ApiService(Dio())))),
        BlocProvider(create: (context) => SignUpCubit(signupRepo: SignupImpl(apiService: ApiService(Dio())))),
        BlocProvider(create: (context) => VerifyEmailCubit(apiService: ApiService(Dio()))),
        BlocProvider(create: (context) => ProductsCubit()..getProducts()),
        BlocProvider(create: (context) => CategoriesCubit()..getCategories()),
        BlocProvider(create: (context) => DetailsCubit()),
      ],
      child: const StarkApp(),
    ),
  );
}

class StarkApp extends StatelessWidget {
  const StarkApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
