# Album Viewer App

A Flutter application that displays albums with photos in an infinite scrolling interface, built using Clean Architecture and BLoC pattern.

## Features

- **Infinite Horizontal Scrolling**: Photos within each album scroll infinitely horizontally, looping back to the first photo after the last one
- **Infinite Vertical Scrolling**: Albums scroll infinitely vertically, allowing users to continuously browse through all available albums
- **Independent Scrolling**: Each album's photos scroll independently from other albums
- **Data Caching**: Uses Hive for local storage to cache albums and photos
- **Offline Support**: App shows cached data immediately when reopened
- **Fallback Images**: Uses dummyimage.com as fallback when original image URLs fail
- **Clean Architecture**: Follows SOLID principles with proper separation of concerns

## Architecture

The app follows Clean Architecture principles with the following structure:

```
lib/
├── core/
│   ├── constants/          # App constants and configuration
│   ├── errors/            # Error handling and failure classes
│   ├── network/           # Network service using Dio
│   ├── usecases/          # Base use case interface
│   └── utils/             # Utility functions
├── features/
│   ├── albums/            # Album feature
│   │   ├── data/          # Data layer
│   │   │   ├── datasources/   # Remote and local data sources
│   │   │   ├── models/        # Data models with JSON serialization
│   │   │   └── repositories/  # Repository implementations
│   │   ├── domain/        # Domain layer
│   │   │   ├── entities/      # Business entities
│   │   │   ├── repositories/  # Repository interfaces
│   │   │   └── usecases/      # Business logic use cases
│   │   └── presentation/  # Presentation layer
│   │       ├── bloc/          # BLoC for state management
│   │       ├── pages/         # UI pages
│   │       └── widgets/       # Reusable UI components
│   └── photos/            # Photo feature (similar structure)
└── injection_container.dart  # Dependency injection setup
```

## Technologies Used

- **Flutter**: UI framework
- **BLoC**: State management
- **Dio**: HTTP client for API calls
- **Hive**: Local database for caching
- **GetIt**: Dependency injection
- **Cached Network Image**: Image loading and caching
- **JSON Serialization**: Data model serialization
- **Equatable**: Value equality for objects

## API Endpoints

- **Albums**: `GET https://jsonplaceholder.typicode.com/albums`
- **Photos**: `GET https://jsonplaceholder.typicode.com/photos?albumId={id}`

## Key Features Implementation

### Infinite Scrolling
- **Horizontal Scrolling**: Each album's photos are duplicated 3 times for infinite horizontal scrolling
- **Vertical Scrolling**: Albums are displayed in a vertical list with infinite scrolling capability
- **Independent Controllers**: Each album has its own horizontal scroll controller for independent scrolling

### Data Caching
- **Hive Database**: Albums and photos are cached locally using Hive
- **Immediate Loading**: Cached data is loaded immediately when the app starts
- **Automatic Updates**: New data from the API automatically updates the cache

### Error Handling
- **Network Failures**: Proper error handling for network issues
- **Image Fallbacks**: Fallback images when original URLs fail
- **Graceful Degradation**: App continues to work with cached data when offline

## Project Structure Benefits

1. **Testability**: Clean separation makes unit testing easier
2. **Maintainability**: Clear structure makes code maintenance straightforward
3. **Scalability**: Easy to add new features following the same pattern
4. **Dependency Management**: GetIt handles all dependencies centrally
5. **State Management**: BLoC provides predictable state management

## Future Enhancements

- Add pull-to-refresh functionality
- Implement image zoom and full-screen view
- Add search functionality for albums
- Implement pagination for better performance
- Add unit and widget tests
- Implement dark mode support