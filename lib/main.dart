import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/core/utils/app_colors.dart';
import 'package:quiz_app/core/utils/theme_provider.dart';

import 'features/menu/presentation/pages/menu_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dependency injection
  await di.init();

  // run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        child: const MenuPage(),
        builder: (_, themeProvider, child) {
          return MaterialApp(
            title: 'Quiz App',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.selectedThemeMode,
            home: child,
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.purpleAccent,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: AppColors.darkPrimary,
              scaffoldBackgroundColor: AppColors.darkPrimary,
              primaryColorLight: AppColors.darkPrimaryLight,
              primaryColorDark: AppColors.darkPrimaryDark,
              hintColor: AppColors.darkText,
              highlightColor: AppColors.darkSecondary,
              canvasColor: AppColors.darkSecondary,
            ),
          );
        },
      ),
    );
  }
}
