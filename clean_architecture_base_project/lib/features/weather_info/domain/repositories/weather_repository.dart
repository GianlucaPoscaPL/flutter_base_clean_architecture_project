///the repository belongs to both the domain and data layers. 
///In fact, it will be defined in the domain first and then implemented in data.
///Creating the repository contract with the use of the sealed class
///So, in our abstract repository class, we'll have three methods: 
///getWeatherDataByCoordinates, getWeatherDataByCity, and getAllLocalWeathers. 
///These methods return Future>, where T is the data type:
import 'package:clean_architecture_base_project/core/commundomain/entities/based_api_result/api_result_model.dart';
import 'package:clean_architecture_base_project/features/weather_info/domain/entities/weather_remote_info_response_entity/weather_info_entity.dart';
import 'package:clean_architecture_base_project/features/weather_info/utils/requests_models/weather_by_coordinates_request_model.dart';

abstract class WeatherRepository {
  Future<ApiResultModel<WeatherInfoEntity?>> getWeatherDataByCoordinates(
      {WeatherByCoordinatesRequestModel? weatherByCoordinatesRequestModel});

  Future<ApiResultModel<WeatherInfoEntity?>> getWeatherDataByCity(
      {String? cityName});

  Future<ApiResultModel<List<WeatherInfoEntity?>?>> getAllLocalWeathers();
}
