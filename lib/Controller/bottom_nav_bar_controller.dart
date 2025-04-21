import 'package:get/get.dart';
import 'package:mind_space/pages/AI_feedback.dart';
import 'package:mind_space/pages/feedback_page.dart';
import 'package:mind_space/pages/home.dart';
import 'package:mind_space/pages/settings_page.dart';

class BottomNavBarController extends GetxController {
  RxInt index = 0.obs;

  var pages = [
    Home(),
    AiFeedback(),
    SettingsPage(),
  ];
}