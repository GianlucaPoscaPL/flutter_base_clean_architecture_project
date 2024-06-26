///The repositories are classes that can interact with zero or some data sources in order to expose the data to the rest of the app
///The Repositories are the app's data layer's brain; they are in charge of:
///1. Exposing data to the rest of the app.
///2. Centralizing changes to the data.
///3. Resolving conflicts between multiple data sources.
///4. Abstracting sources of data from the rest of the app.
///


import 'package:clean_architecture_base_project/core/commundomain/entities/based_api_result/api_result_model.dart';
import 'package:clean_architecture_base_project/core/commundomain/entities/based_api_result/error_result_model.dart';
import 'package:clean_architecture_base_project/core/utils/helpers/custom_exceptions/custom_connection_exception.dart';
import 'package:clean_architecture_base_project/features/weather_info/data/datasource/local_datasource/weather_local_datasource.dart';
import 'package:clean_architecture_base_project/features/weather_info/data/datasource/remote_datasource/weather_remote_datasource.dart';
import 'package:clean_architecture_base_project/features/weather_info/data/models/weather_info_remote_response_model/weather_info_response_model.dart';
import 'package:clean_architecture_base_project/features/weather_info/domain/entities/weather_remote_info_response_entity/weather_info_entity.dart';
import 'package:clean_architecture_base_project/features/weather_info/domain/repositories/weather_repository.dart';
import 'package:clean_architecture_base_project/features/weather_info/utils/requests_models/weather_by_coordinates_request_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final WeatherRemoteDataSource remoteDataSource;

  final WeatherLocalDataSource localDataSource;

  @override
  Future<ApiResultModel<WeatherInfoEntity?>> getWeatherDataByCity(
      {String? cityName}) async {
    try {
      final ApiResultModel<WeatherInfoResponseModel?> _result =
          await remoteDataSource.getWeatherDataByCity(cityName: cityName);
      return _result.when(
        success: (WeatherInfoResponseModel? weatherInfoResponseModel) async {
          if (weatherInfoResponseModel != null) {
            _cacheLocalData(weatherInfoResponseModel);
          }
          return ApiResultModel<WeatherInfoEntity?>.success(
            data: weatherInfoResponseModel?.mapToEntity(),
          );
        },
        failure: (ErrorResultModel errorResultModel) {
          return ApiResultModel<WeatherInfoEntity>.failure(
            errorResultEntity: errorResultModel,
          );
        },
      );
    } on CustomConnectionException catch (_) {
      final ApiResultModel<WeatherInfoEntity?> _result =
          await _getLastLocalWeatherInfo();
      return _result;
    }
  }

  Future<ApiResultModel<WeatherInfoEntity?>> _getLastLocalWeatherInfo() async {
    final WeatherInfoEntity? _localResult =
        await localDataSource.getLastWeatherInfo();
    return ApiResultModel<WeatherInfoEntity?>.success(
      data: _localResult,
    );
  }

  @override
  Future<ApiResultModel<WeatherInfoEntity?>> getWeatherDataByCoordinates(
      {WeatherByCoordinatesRequestModel?
          weatherByCoordinatesRequestModel}) async {
    try {
      final ApiResultModel<WeatherInfoResponseModel?> _result =
          await remoteDataSource.getWeatherDataByCoordinates(
              weatherByCoordinatesRequestModel:
                  weatherByCoordinatesRequestModel);
      return _result.when(
        success: (WeatherInfoResponseModel? weatherInfoResponseModel) async {
          if (weatherInfoResponseModel != null) {
            _cacheLocalData(weatherInfoResponseModel);
          }
          return ApiResultModel<WeatherInfoEntity?>.success(
            data: weatherInfoResponseModel?.mapToEntity(),
          );
        },
        failure: (ErrorResultModel errorResultModel) {
          return ApiResultModel<WeatherInfoEntity>.failure(
            errorResultEntity: errorResultModel,
          );
        },
      );
    } on CustomConnectionException catch (_) {
      final ApiResultModel<WeatherInfoEntity?> _result =
          await _getLastLocalWeatherInfo();
      return _result;
    }
  }

  void _cacheLocalData(WeatherInfoResponseModel? weatherData) {
    localDataSource.cacheWeatherInfo(weatherData);
  }

  @override
  Future<ApiResultModel<List<WeatherInfoEntity?>?>>
      getAllLocalWeathers() async {
    final List<WeatherInfoEntity?>? _result =
        await localDataSource.getAllLocalWeathers();
    return ApiResultModel<List<WeatherInfoEntity?>?>.success(
      data: _result,
    );
  }
}
