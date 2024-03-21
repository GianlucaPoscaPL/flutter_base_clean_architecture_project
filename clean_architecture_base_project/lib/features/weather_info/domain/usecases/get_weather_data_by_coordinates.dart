import 'package:clean_architecture_base_project/core/commundomain/entities/based_api_result/api_result_model.dart';
import 'package:clean_architecture_base_project/core/commundomain/usecases/base_params_usecase.dart';
import 'package:clean_architecture_base_project/features/weather_info/domain/entities/weather_remote_info_response_entity/weather_info_entity.dart';
import 'package:clean_architecture_base_project/features/weather_info/domain/repositories/weather_repository.dart';
import 'package:clean_architecture_base_project/features/weather_info/utils/requests_models/weather_by_coordinates_request_model.dart';
import 'package:injectable/injectable.dart';

/// each use case should implement the previous base class and override the calling method. 
/// For example, for 'GetWeatherDataByCoordinates', we implement the 'BaseParamsUseCase' with 
/// the addition of two parameters: one representing the return type of this use case and the 
/// other representing the parameters to be passed into it, which in our case is the 
/// 'WeatherByCoordinatesRequestModel', which holds the required latitude and longitude values:

@injectable
class GetWeatherDataByCoordinates
    implements
        BaseParamsUseCase<WeatherInfoEntity?,
            WeatherByCoordinatesRequestModel> {
  GetWeatherDataByCoordinates(this.weatherRepository);

  final WeatherRepository weatherRepository;

  @override
  Future<ApiResultModel<WeatherInfoEntity?>> call(
      WeatherByCoordinatesRequestModel? weatherByCoordinatesRequestModel) {
    return weatherRepository.getWeatherDataByCoordinates(
        weatherByCoordinatesRequestModel: weatherByCoordinatesRequestModel);
  }
}
