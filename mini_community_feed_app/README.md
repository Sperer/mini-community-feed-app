# Mini Community App

The **Mini Community App** is a social feed application that allows users to view posts, like them, and explore image content in fullscreen mode.  
It demonstrates **Clean Architecture**, **Bloc State Management**, and robust **API integration** with proper error handling and caching mechanisms.

## Flutter SDK Version
- **Minimum Flutter Version:** `3.22.0`  
- **Recommended Flutter Version:** `3.35.7 (stable)`  

Make sure Flutter and Dart versions meet the above requirements.

---

## Packages Used

| Package Name | Purpose |
|---------------|----------|
| `flutter_bloc` | Bloc state management |
| `equatable` | Simplifies equality checks for Bloc states/events |
| `cached_network_image` | Efficient image caching and loading |
| `shimmer` | Loading shimmer animation |
| `dartz` | Functional programming utilities for Either/Right/Left |
| `http` | HTTP requests for APIs |
| `get_it` | Dependency injection |
| `connectivity_plus` | Network connectivity checking |

---

## Architecture Used

The project follows **Clean Architecture**, promoting scalability, testability, and maintainability.
```
lib/
├── core/
│ ├── network/ → Network utilities and connectivity checks
│ ├── typedef/ → Type definitions (e.g., ResultFuture)
│ ├── errors/ → Custom exceptions and error handling
│ └── usecase/ → Use case definitions
│
├── feature/
│ ├── data/
│ │ ├── data_sources/ → API data sources (remote/local)
│ │ ├── models/ → Data models extending domain entities
│ │ └── repositories/ → Implementation of domain repositories
│ │
│ ├── domain/
│ │ ├── entities/ → Core business entities (e.g., Post)
│ │ ├── repositories/ → Abstract repository interfaces
│ │ └── usecases/ → Application-specific business logic
│ │
│ ├── presentation/
│ │ ├── Bloc/ → Bloc files (Events, States, Blocs)
│ │ └── pages/ → UI screens and widgets
│ │
│ └── service_locator.dart → Dependency injection setup using GetIt
│
└── main.dart → App entry point and BlocProviders
```

## How To Run The App
- Run command ```flutter pub get``` to get all the dependencies
- Run command ```flutter run``` 

