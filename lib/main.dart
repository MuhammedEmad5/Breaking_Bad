import 'package:bloc/bloc.dart';
import 'package:breaking_bad/shared/constant/themes.dart';
import 'package:breaking_bad/shared/routes/app_route.dart';
import 'package:breaking_bad/shared/constant/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      runApp(const CharactersApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class CharactersApp extends StatelessWidget {
  const CharactersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: lightTheme(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerate.generateRoute,
          );
        });
  }
}
