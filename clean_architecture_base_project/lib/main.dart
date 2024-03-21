import 'package:flutter/material.dart';
import 'package:clean_architecture_base_project/core/di/app_component/app_component.dart';
import 'package:clean_architecture_base_project/core/utils/auto_router_setup/auto_router.dart';
import 'package:clean_architecture_base_project/features/weather_info/presentation/add_new_city/add_new_city_viewmodel.dart';
import 'package:clean_architecture_base_project/features/weather_info/presentation/weather_details/weather_details_viewmodel.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppComponentLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherDetailsViewModel>(
          create: (BuildContext context) => locator<WeatherDetailsViewModel>(),
        ),
        ChangeNotifierProvider<AddNewCityViewModel>(
          create: (BuildContext context) => locator<AddNewCityViewModel>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
