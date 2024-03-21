///BaseParamsUseCase: one represents the data type in case of success, and the Request type is 
///for the parameters that will be passed through the use case, such as the latitude and longitude
/// for the previous 'GetWeatherDataByCoordinates'. So, in order to implement the base class, 
/// each use case must specify the parameter Request that will be passed to the "call" method. 
/// However, if a use case does not require any parameters, we can use the NoParams class as the
///  Request type, as in the case of 'GetAllLocalWeathers'.
import 'package:clean_architecture_base_project/core/commundomain/entities/based_api_result/api_result_model.dart';
import 'package:equatable/equatable.dart';

abstract class BaseParamsUseCase<Type, Request> {
  Future<ApiResultModel<Type>> call(Request? params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => <Object>[];
}
