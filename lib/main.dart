import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Core/Constants/app_constanst.dart';
import 'Core/Notifier/app_provider.dart';
import 'Core/Notifier/themeprovider.dart';
import 'Core/Service/Localization/language_service.dart';
import 'View/View/home_view.dart';

void main() {
  runApp(
    EasyLocalization(
      path: LanguageService.path,
      saveLocale: true,
      supportedLocales: LanguageService.instance.locales,
      child: MultiProvider(
          providers: AppProvider.instance.providers, child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: AppConstansts.appName,
      theme: Provider.of<ThemeProvider>(context).getTheme,
      home: HomeView(),
    );
  }
}
