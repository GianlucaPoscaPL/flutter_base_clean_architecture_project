import 'package:clean_architecture_base_project/features/weather_info/data/datasource/local_datasource/weather_local_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockWeatherLocalDataSource extends Mock
    implements WeatherLocalDataSource {}

@GenerateMocks([MockWeatherLocalDataSource])
class Mocks {}
