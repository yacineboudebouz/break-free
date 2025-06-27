The should be built with flutter and riverpod 3.0 and have the following features:

## Customized UI

Main app features:

- The main screen should have habits i am trying to quit and habits i am trying to build.
- The main screen should have a button to add a new habit and search bar to search habits.
- When tapping on a habit, it should show the details of the habit and also the history of relapses.
- When adding a relapse or success, it resets the habit to the current date and i can also add a note to the relapse.

Other features:

- There is a screen where you can read useful articles about habits and success we can access it from the drawer.
- There is also a screen where the user find the credits of the app and the license of the used packages.
- The app should have a settings screen where the user can change the theme and other preferences.

## Technical Requirements

- The app should be built with Flutter and use Riverpod 3.0 for state management.
- The app should be responsive and work on Android.
- Use GoRouter package for navigation.
- Use sqflite for local storage.
- Use a propper architecture with riverpod and separate layers for data, domain, and presentation.
- Use a clean architecture approach to separate concerns and make the codebase maintainable.
- Use a proper error handling mechanism to handle errors gracefully.
- Use a proper logging mechanism to log errors and important events for debug mode.
- Prefer small composable widgets to build the UI.
- use `logger` package for logging rather than print statements.
- I want the code to be well documented and follow best practices for Flutter development.
- I want the code to be maintainable and scalable, so it should follow SOLID principles and be easy to extend in the future and i can write unit tests for the code.

## Theming and styling

- The theme should be done by setting the `theme` property of the `MaterialApp` widget rather than hzrdcoding the colors in the widgets.
- In the main screen, i want a veru customized UI which the part of bad habits are in devil theme and the part of good habits are in angel theme.
- The app should have a dark mode and light mode and we can switch between them somewhere in the drawer and use riverpod to manage the theme state.
