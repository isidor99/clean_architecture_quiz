import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/core/utils/app_themes.dart';
import 'package:quiz_app/core/utils/theme_provider.dart';

import 'theme_item.dart';

// TODO: place this widget in proper feature
// TODO: implement animation
class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  void _onTap(ThemeProvider provider, int i) {
    if (AppThemes.themes[i].mode != provider.selectedThemeMode) {
      provider.setSelectedThemeMode(AppThemes.themes[i].mode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) => ListView.builder(
          itemCount: AppThemes.themes.length,
          itemBuilder: (_, i) => ThemeItem(
            title: AppThemes.themes[i].title,
            onTap: () => _onTap(themeProvider, i),
          ),
        ),
      ),
    );

    /*
    return Consumer<ThemeProvider>(
      builder: (c, themeProvider, _) => SizedBox(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          crossAxisCount: appThemes.length,
          children: List.generate(
            appThemes.length,
            (i) {
              bool _isSelectedTheme =
                  appThemes[i].mode == themeProvider.selectedThemeMode;
              return GestureDetector(
                onTap: _isSelectedTheme
                    ? null
                    : () =>
                        themeProvider.setSelectedThemeMode(appThemes[i].mode),
                child: AnimatedContainer(
                  height: 100,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: _isSelectedTheme
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(appThemes[i].icon),
                          Text(
                            appThemes[i].title,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );*/
  }
}
