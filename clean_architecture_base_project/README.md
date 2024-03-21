# clean_architecture_base_project

A new Flutter project.

## Getting Started

the repository belongs to both the domain and data layers. In fact, it will be defined in the domain first and then implemented in data.

In our contract, we define three methods for our weather functionality: one to retrieve weather data by coordinates, another to obtain weather for a specific city, and a third to retrieve all saved weather information locally. Logically, the return types for the first two methods should be Future, and for the final method, Future>. However, error handling is also an important consideration. We have two options: allowing exceptions to propagate and handling them elsewhere, or catching exceptions early and returning an error object from the methods.

In our architecture, I have chosen the second approach. This means that any method in the repository or use case will return both the entity and failure objects, 


sealed classes are used to represent restricted class hierarchies, where a value can have one of a restricted set's types but not another. They are also an extension of enum classes, except that an enum constant can only have one instance, but a sealed class can have several instances. (shape > triangle:Shape, rectangle:Shape)

Creating the sealed class

The ApiResultModel sealed class will have two states: success and failure. The success state will return the data type specified when calling our sealed class. For example, if we want the method to return a WeatherInfoEntity on success, the return type should be ApiResultModel. When a problem occurs, the return type is an ErrorResultModel object, as defined in the failure state.


Any use case must have the *WeatherRepository * object, which will be provided in the constructor