
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/app_state.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BelanjaKu',
          themeMode: appState.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF168BFF),
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: const Color(0xFFEAF4FF),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF0D47A1),
              foregroundColor: Colors.white,
              elevation: 2,
            ),
            navigationBarTheme: const NavigationBarThemeData(
              backgroundColor: Color(0xFFDCEEFF),
              indicatorColor: Color(0xFFB8DCFF),
            ),
            cardTheme: CardThemeData(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF168BFF),
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF081525),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF0B2545),
              foregroundColor: Colors.white,
              elevation: 2,
            ),
            navigationBarTheme: const NavigationBarThemeData(
              backgroundColor: Color(0xFF102943),
              indicatorColor: Color(0xFF164D80),
            ),
            cardTheme: CardThemeData(
              color: const Color(0xFF172B45),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
