import 'package:task_manager/ui/widget/task_item_card.dart';

class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String updateProfile = '$_baseUrl/profileUpdate';

  static String verifyEmail(email) => '$_baseUrl/RecoverVerifyEmail/$email';

  static String verifyOtp(email, otp) =>
      '$_baseUrl/RecoverVerifyOTP/$email/$otp';
  static const String resetPass = '$_baseUrl/RecoverResetPass';
  static const String createNewTask = '$_baseUrl/createTask';
  static const String getTaskStatusCount = '$_baseUrl/taskStatusCount';

  static String getNewTask =
      '$_baseUrl/listTaskByStatus/${TaskStatus.New.name}';
  static String getProgressTask =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Progress.name}';
  static String getCompletedTask =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Completed.name}';
  static String getCancelledTask =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Cancelled.name}';

  static String updateTaskStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static String deleteTask(String taskId) => '$_baseUrl/deleteTask/$taskId';
}
