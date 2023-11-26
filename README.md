# Back4App-Integration-Assignment
created a Flutter app that connects to Back4App, a Backend-as-a-Service (BaaS) platform, to manage tasks. You will be responsible for setting up the Back4App backend, creating the Flutter app, and implementing the necessary functionality to interact with the backend.

**README for Flutter App with Back4App Integration**

---

### Project Title: Task Manager Flutter App

#### Overview:

This Flutter app integrates with Back4App to provide a simple task management system. Users can view a list of tasks, create new tasks, view task details, and optionally edit or delete tasks.

#### Setup:

1. **Back4App Setup:**
   - Sign up for a Back4App account if you don't have one.
   - Create a new Back4App app.
   - In the Back4App dashboard, create a class named "Task" with columns "title" (String) and "description" (String).

2. **Flutter Setup:**
   - Clone this repository: [[GitHub Repository Link](https://github.com/2022mt93699/Back4App-Integration-Assignment.git)].
   - Open the project in your preferred Flutter development environment (e.g., VS Code, Android Studio).
   - Run `flutter pub get` to fetch the dependencies.
   - Initialize the Parse SDK in your Flutter app. Update the `applicationId` and `clientKey` in the `main.dart` file with your Back4App credentials.

#### Screens:

1. **Task List:**
   - Displays a list of tasks retrieved from Back4App.
   - Each task shows the title and a brief description.

2. **Task Creation:**
   - Allows users to add new tasks with a title and description.
   - Newly created tasks are saved to Back4App.

3. **Task Details:**
   - Shows detailed information about a selected task.
   - Displays the title and full description.

4. **Bonus Features:**
   - **Task Editing:**
     - Users can edit the title and description of existing tasks.
   - **Task Deletion:**
     - Users can delete tasks.
   - *Any additional features or enhancements you implemented.*

#### Running the App:

1. Connect your device or start an emulator.
2. Run `flutter run` in the project directory.

#### Bonus Features Overview:

- **Task Editing:**
  - Accessed by tapping the "Edit" button on the Task Details screen.
  - Allows modification of the task's title and description.

- **Task Deletion:**
  - Performed by tapping the "Delete" button on the Task Details screen.
  - Deletes the task from both the app and Back4App.

- *Any other bonus features or enhancements you implemented.*

**Note:** Ensure that your Back4App credentials and any sensitive information are not exposed in our public repository.
