# CodingJr Todo App

Todo app made using `sqflite` and `getx`.

Download release APK from:- [Here]()

## Tech Stack

- Flutter 3.16.5
- Dart 3.2.3
- sqflite (Database)
- GetX (State Management)

## Project Structure

This app is structured based on MVC Architecture and adheres to the best practices guidelines of both `Flutter Framework` and `GetX State Management` while also providing offline capabilities and storage persistence.

```
lib
├── controllers
│   ├── controllers.dart
│   └── todo_controller.dart
│       
├── db
│   ├── db.dart
│   └── todo_db.dart
│       
├── models
│   ├── models.dart
│   └── todo_model.dart
│       
├── views
│   ├── home
│   │   ├── home.dart
│   │   ├── home_view.dart
│   │   └── widgets
│   └── views.dart
```

## Setup Instructions

To run this project locally, follow these steps:

1. Clone the repository: `git clone https://github.com/maranix/codingjr_todo`
2. Navigate to the project directory: `cd codingjr_todo`
3. Ensure you have Flutter and Dart SDK installed. If not, you can download them from the official Flutter website.
5. Install project dependencies: `flutter pub get`
6. Run the project on your preferred device or emulator: `flutter run`

## License

This project is licensed under the MIT License.

## Contact

For any inquiries or questions, you can contact the project maintainers at ramanverma4183@gmail.com.
