import 'package:clean_architecture_base_project/features/weather_info/data/datasource/local_datasource/local_database.dart';
import 'package:injectable/injectable.dart';


@module
abstract class AppModule {
  @preResolve
  Future<AppLocalDatabase> get prefs => AppLocalDatabase.create();
}
