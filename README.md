# Gaming Web App

A Flutter web application for managing gaming teams and lineups.

## Project Overview

This web application helps coaches and team managers create fair and balanced lineups for their sports teams. Key features include:

- **User Authentication**: Sign up, login, and account management
- **Team Dashboard**: View team statistics and player information
- **Lineup Management**: Create and optimize game-ready lineups
- **Player Management**: Add, edit, and track player statistics
- **Game Tracking**: Record and analyze game performance

## Project Structure

```
lib/
├── constants/              # App-wide constants (colors, styles, shared widgets)
├── screens/                # UI screens
│   ├── authentication/     # Login, signup, forgot password screens
│   ├── main_dashboard/     # Main app dashboard
│   ├── organization_dashboard/ # Organization management
│   └── team_dashboard/     # Team management screens
├── routes/                 # App navigation routes
├── base/               # API services and business logic
│   ├── apiservice/                # RESTful API integration
│   └── controllers/        # GetX controllers for state management
└── main.dart               # App entry point
```

## State Management

This project uses GetX for state management, providing:

- Simple and reactive state management with `Rx` variables and `Obx` widgets
- Separation of UI and business logic using controller classes
- Dependency injection for better code organization
- Streamlined navigation with `Get.toNamed()` instead of Navigator

## Responsive Design

The app is fully responsive with different layouts for:

- **Mobile**: Stack elements vertically, optimized for small screens
- **Tablet**: Hybrid layout with some horizontal arrangements
- **Desktop**: Full table views and optimized use of horizontal space

## Getting Started

### Prerequisites

- Flutter SDK (2.10.0 or higher)
- Dart SDK (2.16.0 or higher)
- A code editor (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/gaming_web_app.git
   ```

2. Navigate to the project directory:
   ```
   cd gaming_web_app
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run -d chrome
   ```

## Development Guidelines

### Coding Standards

- Use GetX controllers for state management instead of setState
- Add detailed comments to help other developers understand the code
- Follow responsive design patterns for all screens
- Maintain consistent styling using the constants provided

### Adding New Features

1. Create a controller in `services/controllers/`
2. Add models in `models/` if needed
3. Create UI components in the appropriate screen directory
4. Update routes if adding new screens

## Resources

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Additional resources specific to this project:

- [GetX Documentation](https://pub.dev/packages/get)
- [Flutter Web Development](https://docs.flutter.dev/platform-integration/web)
- [Responsive Design in Flutter](https://docs.flutter.dev/ui/layout/responsive)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.#   l i n e u p  
 #   l i n e u p  
 