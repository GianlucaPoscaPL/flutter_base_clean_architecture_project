import 'dart:async';

import 'package:clean_architecture_base_project/core/basecomponents/base_view_model.dart';
import 'package:clean_architecture_base_project/core/commundomain/entities/based_api_result/api_result_state.dart';
import 'package:clean_architecture_base_project/features/weather_info/domain/entities/weather_remote_info_response_entity/weather_info_entity.dart';
import 'package:clean_architecture_base_project/features/weather_info/domain/usecases/get_weather_data_by_coordinates.dart';
import 'package:clean_architecture_base_project/features/weather_info/utils/requests_models/weather_by_coordinates_request_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class WeatherDetailsViewModel extends BaseViewModel {
  WeatherDetailsViewModel(this.getWeatherDataByCoordinates);

  final GetWeatherDataByCoordinates getWeatherDataByCoordinates;

  final StreamController<ApiResultState<WeatherInfoEntity?>?> _weatherResult =
      StreamController<ApiResultState<WeatherInfoEntity?>?>.broadcast();

  StreamController<ApiResultState<WeatherInfoEntity?>?> get weatherResult =>
      _weatherResult;

  Future<void> getWeatherByCoordinates(
      {WeatherByCoordinatesRequestModel?
          weatherByCoordinatesRequestModel}) async {
    final ApiResultState<WeatherInfoEntity?>? _result =
        await executeParamsUseCase(
      useCase: getWeatherDataByCoordinates,
      query: weatherByCoordinatesRequestModel,
    );
    _weatherResult.add(_result);
  }

  @override
  void onDispose() {
    super.onDispose();
    _weatherResult.close();
  }
}
