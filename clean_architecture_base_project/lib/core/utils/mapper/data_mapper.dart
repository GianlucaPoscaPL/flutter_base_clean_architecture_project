///DataMapper whose main role is to map a model into the desired entity. This class will be shared among all app models
///To map the appropriate entity, each model will now extend this class and override the mapToEntity function

abstract class DataMapper<Type> {
  Type mapToEntity();
}
