# clean_architecture_base_project

## Presentation

Uncle Bob's architecture is based on the dependency inversion principle to define boundaries between high-level and low-level components.

Nothing in an inner circle can know anything at all about something in an outer circle.

https://res.cloudinary.com/practicaldev/image/fetch/s--8Fs2hOeU--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_800/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/fqeiepngw5aeco73r3wx.png

When a user interacts with the Widget, we communicate their action to the Provider class, which then connects to the useCase to retrieve the action's result. Following that, the useCase communicates with the Repository class in order to obtain the solution from a remote or local DataSource

I have decided to use the Provider technique for state management in this project, as seen in the figure above. However, as clean architecture is not connected to any particular state management methodology.

The first is called “core”, and it contains all of the shared and basic components, as well as the implementation of core features such as dependency injection. The second folder is titled "features," and it contains every "feature" of the app. For example, in our case, we only have one feature that represents weather information, and it contains two interfaces: one for details and another for adding new cities. Each feature will also be separated into three layers: data, domain, presentation, and utils.

## Domain Layer

The domain layer acts as a bridge between the presentation and data layers, utilizing business objects and use cases to execute the application's logic. Each use case relies on the Repository to fetch data, maintaining a separation of concerns.

To ensure independence, an abstract Repository class is defined in the domain layer, outlining the required functionality. Its concrete implementation is then handled in the data layer, sourcing data from various origins like REST APIs or local databases.

The Repository serves as a data aggregator, shielding other components from the complexities of data retrieval. It is a pivotal component shared between the domain and data layers, initially defined in the domain and subsequently implemented in data. Overriding the methods in the usecase.

Weather data is represented by an entity, tailored to mirror the structure of the Weather API response JSON.

Error handling is integral, with two approaches considered: either allowing exceptions to propagate and handling them elsewhere or preemptively catching exceptions and returning error objects. Regardless of the approach, both the entity and failure objects are returned by methods in the repository or use case.

A sealed class, ApiResultModel, is introduced to encapsulate success and failure states. The success state yields the specified data type when calling the sealed class, denoted as ApiResultModel<T>, with T representing the model type.

To enhance flexibility, two type parameters are added to the BaseParamsUseCase: one for the success data type and the other for request parameters, such as latitude and longitude.

## Data Layer

The data layer is responsible for retrieving data from various sources, facilitated by models that represent objects fetched from these sources. The repository is a crucial component shared between the domain and data layers, initially defined in the domain and then implemented in the data layer.

Models encapsulate data retrieved from specific sources, enhanced with additional functionality like JSON conversion. In our case, we augment each model with to/from JSON functions to facilitate conversion to Dart objects.

The WeatherRemoteDataSource interface closely mirrors the Repository interface, featuring methods like getWeatherDataByCoordinates and getWeatherDataByCity. These methods return response models instead of entities, such as WeatherInfoResponseModel, utilizing the shared ApiResultModel.

A helper class is introduced to manage the creation of the HTTP client and provide generic HTTP request methods. Notably, the getWS function, representing the HTTP GET method, is the last function in the file. It accepts parameters such as request URI and optional headers or request parameters. This function returns an HTTP response encapsulated within the ApiResultModel sealed class. Successful responses yield a success state with received data, while other status codes trigger a failure state with error information. Network exceptions are handled by throwing a CustomConnectionException.

With dependencies established, the implementation class, WeatherRemoteDataSourceImpl, is developed to encapsulate the actual logic for data retrieval.

## Presentation Layer

This layer acts as a mediator between the domain/business logic layer and the presentation layer, facilitating communication and state management. It comprises three main sections: the 'widgets' folder, the 'view' folder, and the 'presentation logic holder', implemented using the Provider dependency.

The view model serves as a conduit between the domain and presentation layers, extending the ChangeNotifier class provided by Provider. A basic view model class is established, named BaseViewModel, which includes a private StreamController attribute named toggleLoading to manage loading states, along with other utility methods like executeParamsUseCase.

For instance, consider the weather details interface. In the presentation layer, a dedicated folder named 'weather_details' is created, housing the view model class alongside 'view' and 'widgets' subfolders.

The WeatherDetailsViewModel class, responsible for retrieving weather information based on coordinates, depends on the GetWeatherDataByCoordinates use case. Its constructor includes the use case, and it extends BaseViewModel to leverage common functionality. By calling the executeParamsUseCase method with appropriate parameters, it manages the API request and loading states. Additionally, it maintains a StreamController attribute named weatherResult to handle API responses and overrides the onDispose() method to ensure proper resource management.

A generic class, BaseViewModelView, is developed to handle view model initialization, connectivity state, and loader widget toggling during API calls.

The final step involves creating the WeatherDetails interface as a stateful widget due to its reliance on API calls. Initialization of weather information is achieved using the onInitState method provided by BaseViewModelView. To ensure a responsive UI, the BaseResponsiveWidget is incorporated into the widget tree, resulting in a user-friendly interface.

## Conclusion

While the app's functionality may be on the simpler side, what's important are the principles behind it. I've demonstrated the importance of breaking your architecture down into layers and how they communicate with one another. Additionally, I've created generic components that make it easier for developers to create their interfaces.