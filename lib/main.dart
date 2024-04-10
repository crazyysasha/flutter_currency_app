import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_currency_app/converter/cubit/converter_cubit.dart';
import 'package:flutter_currency_app/converter/repositories/rates.dart';

import 'package:flutter_currency_app/core/colors.dart';
import 'package:flutter_currency_app/converter/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

void main() async {
  runApp(const CurrencyApp());
}

class CurrencyApp extends StatelessWidget {
  const CurrencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RatesRepository(),
      child: MaterialApp.router(
        title: 'Currency APP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.bg,
          textTheme: const TextTheme(
            displayMedium: TextStyle(
              color: AppColors.primary,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(
              color: AppColors.onBg,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            labelMedium: TextStyle(
              color: AppColors.label,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: "/",
              builder: (context, state) => BlocProvider(
                create: (context) => ConverterCubit(
                  repository: context.read<RatesRepository>(),
                )..init(),
                child: HomeScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
