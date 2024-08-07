# Flutter Course Management App

This Flutter application is an example about course management system built using the BLoC (Business Logic Component) architecture. It includes features for user authentication, managing course listings, viewing course details, and user settings. The app also integrates with the camera and maps to provide enhanced functionality.

## Features

- **Login View:** Secure user authentication with a simple login interface.
- **Course List View:** Displays a list of available courses. Users can add or delete courses.
- **Course Detail View:** Provides detailed information about each course, including the ability to edit the course.
- **User Detail View:** Shows detailed information about the logged-in user.
- **Settings View:** Allows users to configure whether the app fetches data from an API or uses a local database.
- **Camera Access:** Integrated camera access for capturing images related to user profile.
- **Map Access:** Uses maps to obtain and display the user's address.
- **Theme Management:** Supports both dark and light themes, allowing users to switch based on their preference.
- **Adaptive Design:** Provides a responsive and adaptive layout for a seamless experience on different devices and screen sizes.

## Add Demo
![App Demo](gifs/Continental.gif)

## Add dark theme
![Dark App](gifs/Continental2.gif)

## Unit tests
This project includes unit tests to ensure the reliability and correctness of the application's business logic and core functionalities.

## Getting Started

### Prerequisites

To run this project, you will need:

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- A supported IDE (e.g., [Visual Studio Code](https://code.visualstudio.com/)).

### Installation

1. Clone this repository:
```bash
   git clone https://github.com/daniel190392/FlutterProject.git
```

2. Navigate to the project directory:
```bash
    cd flutterProject
```

3. Get the dependencies:
```bash
    flutter pub get
```

4. Run the app:
```bash
    flutter run
```

### Run unit tests
```bash
    flutter test
```