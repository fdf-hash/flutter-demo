import 'package:event_bus/event_bus.dart';
//Bus初始化
EventBus eventBus = EventBus();

class UserLoggedInEvent {
  dynamic text;
  UserLoggedInEvent(dynamic text){
    this.text = text;
  }
}

class ClassPage {
  dynamic text;
  ClassPage(dynamic text){
    this.text = text;
  }
}