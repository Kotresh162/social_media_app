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

# 

## Structure of the project
 lib/
├── models/
│   ├── post_model.dart        // Model class for Post
│   ├── comment_model.dart     // Model class for Comment
│   ├── user_model.dart        // Model class for User
│   └── app_data.dart          // Singleton class to manage data
│
├── api/
│   └── api_service.dart       // Class for handling API calls (GET, POST, etc.)
│
├── screens/
│   ├── home_screen.dart       // Screen to display list of posts
│   ├── post_details_screen.dart // Screen to display post details and comments
│   └── user_profile_screen.dart // Screen to display user profile
│
├── exceptions/
│   └── app_exceptions.dart    // Custom exceptions for handling API errors
│
└── main.dart                  // Entry point of the application

## Getting Started

@copyWrite KotreshHiremath-2025
