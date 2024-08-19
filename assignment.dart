import 'dart:io';

const String adminUsername = "admin";
const String adminPassword = "password";

final String taskFile = "task.txt";

void main() {
  print("Welcome to the Task Manager!");

  if (adminLogin()) {
    print("\nLogin successful!\n");
    runTaskManager();
  } else {
    print("Invalid credentials. Exiting...");
  }
}

bool adminLogin() {
  stdout.write("Enter username: ");
  String username = stdin.readLineSync()!;

  stdout.write("Enter password: ");
  String password = stdin.readLineSync()!;

  return username == adminUsername && password == adminPassword;
}

void runTaskManager() {
  while (true) {
    print("\nTask Manager Options:");
    print("1. View tasks");
    print("2. Add task");
    print("3. Remove task");
    print("4. Exit");

    stdout.write("Select an option: ");
    String? option = stdin.readLineSync();

    switch (option) {
      case '1':
        viewTasks();
        break;
      case '2':
        addTask();
        break;
      case '3':
        removeTask();
        break;
      case '4':
        print("Exiting Task Manager...");
        return;
      default:
        print("Invalid option. Please try again.");
    }
  }
}

void viewTasks() {
  List<String> tasks = _readTasks();
  if (tasks.isEmpty) {
    print("\nNo tasks available.");
  } else {
    print("\nCurrent Tasks:");
    for (int i = 0; i < tasks.length; i++) {
      print("${i + 1}. ${tasks[i]}");
    }
  }
}

void addTask() {
  stdout.write("\nEnter the task to add: ");
  String task = stdin.readLineSync()!;

  List<String> tasks = _readTasks();
  tasks.add(task);
  _writeTasks(tasks);

  print("Task added successfully.");
}

void removeTask() {
  List<String> tasks = _readTasks();

  if (tasks.isEmpty) {
    print("\nNo tasks available to remove.");
    return;
  }

  viewTasks();
  stdout.write("\nEnter the number of the task to remove: ");
  String? input = stdin.readLineSync();
  int? taskNumber = int.tryParse(input!);

  if (taskNumber == null || taskNumber <= 0 || taskNumber > tasks.length) {
    print("Invalid task number.");
  } else {
    tasks.removeAt(taskNumber - 1);
    _writeTasks(tasks);
    print("Task removed successfully.");
  }
}

List<String> _readTasks() {
  File file = File(taskFile);

  if (file.existsSync()) {
    return file.readAsLinesSync();
  } else {
    return [];
  }
}

void _writeTasks(List<String> tasks) {
  File file = File(taskFile);
  file.writeAsStringSync(tasks.join("\n"));
}
