import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:puntos_colombia_short_url/config/router/app_router.dart';
import 'package:puntos_colombia_short_url/config/themes/color_schemes.dart';
import 'package:puntos_colombia_short_url/generated/l10n.dart';
import 'package:puntos_colombia_short_url/src/domain/models/repositories/clean_uri_api_repository.dart';
import 'package:puntos_colombia_short_url/src/domain/models/repositories/database_repository.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/clean_uri/clean_uri_cubit.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/local_short_urls/local_short_urls_cubit.dart';
import 'package:puntos_colombia_short_url/src/utils/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LocalShortUrlsCubit(locator<DatabaseRepository>())
                ..getAllSavedShortUrls(),
        ),
        BlocProvider(
          create: (context) => CleanUriCubit(locator<CleanUriApiRepository>()),
        ),
      ],
      child: OKToast(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter.config(),
          theme: ThemeData(colorScheme: lightColorScheme),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        ),
      ),
    );
  }
}
