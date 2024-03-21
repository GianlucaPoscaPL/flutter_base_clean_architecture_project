// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_architecture_base_project/core/di/app_component/app_module.dart'
    as _i19;
import 'package:clean_architecture_base_project/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart'
    as _i3;
import 'package:clean_architecture_base_project/core/utils/helpers/connectivity_helper/connectivity_checker_helper.dart'
    as _i5;
import 'package:clean_architecture_base_project/core/utils/helpers/http_strategy_helper/http_request_context.dart'
    as _i6;
import 'package:clean_architecture_base_project/core/utils/helpers/responsive_ui_helper/responsive_config.dart'
    as _i7;
import 'package:clean_architecture_base_project/features/weather_info/data/datasource/local_datasource/local_database.dart'
    as _i4;
import 'package:clean_architecture_base_project/features/weather_info/data/datasource/local_datasource/weather_local_datasource.dart'
    as _i8;
import 'package:clean_architecture_base_project/features/weather_info/data/datasource/local_datasource/weather_local_datasource_impl.dart'
    as _i9;
import 'package:clean_architecture_base_project/features/weather_info/data/datasource/remote_datasource/weather_remote_datasource.dart'
    as _i10;
import 'package:clean_architecture_base_project/features/weather_info/data/datasource/remote_datasource/weather_remote_datasource_impl.dart'
    as _i11;
import 'package:clean_architecture_base_project/features/weather_info/data/repositories/weather_repository_impl.dart'
    as _i13;
import 'package:clean_architecture_base_project/features/weather_info/domain/repositories/weather_repository.dart'
    as _i12;
import 'package:clean_architecture_base_project/features/weather_info/domain/usecases/get_all_local_weathers.dart'
    as _i14;
import 'package:clean_architecture_base_project/features/weather_info/domain/usecases/get_weather_data_by_city.dart'
    as _i15;
import 'package:clean_architecture_base_project/features/weather_info/domain/usecases/get_weather_data_by_coordinates.dart'
    as _i16;
import 'package:clean_architecture_base_project/features/weather_info/presentation/add_new_city/add_new_city_viewmodel.dart'
    as _i18;
import 'package:clean_architecture_base_project/features/weather_info/presentation/weather_details/weather_details_viewmodel.dart'
    as _i17;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i3.AppConfigurations>(() => _i3.AppConfigurations());
    await gh.factoryAsync<_i4.AppLocalDatabase>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i5.ConnectivityCheckerHelper>(
        () => _i5.ConnectivityCheckerHelper());
    gh.factory<_i6.HttpRequestContext>(
        () => _i6.HttpRequestContext(gh<_i5.ConnectivityCheckerHelper>()));
    gh.singleton<_i7.ResponsiveUiConfig>(() => _i7.ResponsiveUiConfig());
    gh.factory<_i8.WeatherLocalDataSource>(
        () => _i9.WeatherRemoteDataSourceImpl(gh<_i4.AppLocalDatabase>()));
    gh.factory<_i10.WeatherRemoteDataSource>(
        () => _i11.WeatherRemoteDataSourceImpl(gh<_i6.HttpRequestContext>()));
    gh.factory<_i12.WeatherRepository>(() => _i13.WeatherRepositoryImpl(
          remoteDataSource: gh<_i10.WeatherRemoteDataSource>(),
          localDataSource: gh<_i8.WeatherLocalDataSource>(),
        ));
    gh.factory<_i14.GetAllLocalWeathers>(
        () => _i14.GetAllLocalWeathers(gh<_i12.WeatherRepository>()));
    gh.factory<_i15.GetWeatherDataByCity>(
        () => _i15.GetWeatherDataByCity(gh<_i12.WeatherRepository>()));
    gh.factory<_i16.GetWeatherDataByCoordinates>(
        () => _i16.GetWeatherDataByCoordinates(gh<_i12.WeatherRepository>()));
    gh.factory<_i17.WeatherDetailsViewModel>(() =>
        _i17.WeatherDetailsViewModel(gh<_i16.GetWeatherDataByCoordinates>()));
    gh.factory<_i18.AddNewCityViewModel>(() => _i18.AddNewCityViewModel(
          gh<_i15.GetWeatherDataByCity>(),
          gh<_i14.GetAllLocalWeathers>(),
        ));
    return this;
  }
}

class _$AppModule extends _i19.AppModule {}
