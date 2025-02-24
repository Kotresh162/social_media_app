# social_media_app
It's a simple social media app that fetches and displays data from the JSONPlaceholder
 API. The project is about API fetching and posting, working with a singleton class, using GetX for state management, JSON parsing,async/await, Dio for HTTP requests, and exception handling.

 
# instalation of the project:
1. git clone `https://github.com/Kotresh162/social_media_app.git`
2. cd social_media_app
3. flutter pub get
4. flutter pub run

# api end points are the jsonplaceholder fake apis
- https://jsonplaceholder.typicode.com/users //userDetails
- https://jsonplaceholder.typicode.com/photos //post details
- https://jsonplaceholder.typicode.com/comments //comments


## Components Overview

### Models
- **Post Model** (`post_model.dart`): Represents a Post object containing details like the title, body, and userId.
- **Comment Model** (`comment_model.dart`): Represents a Comment associated with a Post.
- **User Model** (`user_model.dart`): Represents a User with nested Address, Geo, and Company classes.
- **App Data** (`app_data.dart`): A singleton class to manage shared app data, such as the current state or session information.

### API
- **Api Service** (`api_service.dart`): Handles API calls (GET, POST, PUT, etc.) for fetching and submitting data.

### Screens
- **Home Screen** (`home_screen.dart`): Displays a list of posts fetched from the API.
- **Post Details Screen** (`post_details_screen.dart`): Displays the details of a single post and its associated comments.
- **User Profile Screen** (`user_profile_screen.dart`): Displays the profile of a user, including their information and address.

### Exceptions
- **App Exceptions** (`app_exceptions.dart`): Defines custom exceptions for handling different types of API errors and application issues.

### Main Entry Point
- **Main.dart**: This is the entry point of the application where the `runApp()` function is called to start the app.

## Guidelines

### Step 1: Set Up Models
- Create model classes (`Post`, `Comment`, `User`) to represent the data entities.
- Implement the **app_data.dart** singleton class to store and manage app data.

### Step 2: Handle API Calls
- Implement an API service class to handle network requests using libraries like `Dio` or `http`.
- Ensure error handling by using custom exceptions defined in `app_exceptions.dart`.

### Step 3: Design Screens
- Create individual screens (e.g., `HomeScreen`, `PostDetailsScreen`, `UserProfileScreen`) to display data.
- Use `GetX` for navigation and state management.

### Step 4: Implement Exception Handling
- Use the custom exceptions class to catch and manage different types of errors from API calls.


## Getting Started

@copyWrite KotreshHiremath-2025
