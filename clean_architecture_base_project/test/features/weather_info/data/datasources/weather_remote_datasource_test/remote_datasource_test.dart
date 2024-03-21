import 'dart:io';
import 'package:clean_architecture_base_project/core/commundomain/entities/based_api_result/api_result_model.dart';
import 'package:clean_architecture_base_project/core/utils/constants/app_constants.dart';
import 'package:clean_architecture_base_project/core/utils/helpers/http_strategy_helper/concrete_strategies/get_request_strategy.dart';
import 'package:clean_architecture_base_project/features/weather_info/data/datasource/remote_datasource/weather_remote_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../../core/utils/helpers/api_call_helper_test.mocks.dart';

void main() {
  late WeatherRemoteDataSourceImpl _sut;
  late MockApiCallHelperTest _apiCallHelper;
  setUp(() {
    _apiCallHelper = MockApiCallHelperTest();
    _sut = WeatherRemoteDataSourceImpl(_apiCallHelper);
  });
  group('test getWeatherDataByCity()', () {
    const String _cityName = 'Sousse';
    final Map<String, dynamic> _params = <String, dynamic>{
      cityNameKey: _cityName,
      appIdKey: appIdValue
    };
    void _arrangeResponse() {
      when(_apiCallHelper.makeRequest(
        uri: getWeatherDetails,
        requestData: _params,
        httpRequestStrategy: GetRequestStrategy(),
      )).thenAnswer((_) async {
        final http.Response _response = http.Response(
          File('test_assets/weather_info_json_data.json').readAsStringSync(),
          200,
        );
        return ApiResultModel<http.Response>.success(data: _response);
      });
    }

    test(
      'should perform GET request on a URL with extra headers and a body',
      () async {
        //arrange
        _arrangeResponse();
        //act
        _sut.getWeatherDataByCity(cityName: _cityName);
        //assert
        verify(_apiCallHelper.makeRequest(
          uri: getWeatherDetails,
          requestData: _params,
          httpRequestStrategy: GetRequestStrategy(),
        ));
      },
    );
  });
}
