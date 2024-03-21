///the data sources, as the name implies, are in charge of giving the app the data it needs to perform a function
import 'package:clean_architecture_base_project/core/commundomain/entities/based_api_result/api_result_model.dart';
import 'package:clean_architecture_base_project/features/weather_info/data/models/weather_info_remote_response_model/weather_info_response_model.dart';
import 'package:clean_architecture_base_project/features/weather_info/utils/requests_models/weather_by_coordinates_request_model.dart';


abstract class WeatherRemoteDataSource {
  Future<ApiResultModel<WeatherInfoResponseModel?>> getWeatherDataByCoordinates(
      {WeatherByCoordinatesRequestModel? weatherByCoordinatesRequestModel});

  Future<ApiResultModel<WeatherInfoResponseModel?>> getWeatherDataByCity(
      {String? cityName});
}
