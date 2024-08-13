import 'package:get/get.dart';

class Claimconfirmationcontroller extends GetxController{
  final RxList<Map<String, dynamic>> expenseCategory = [
    {"image":"assets/icons/flight.png",'label': 'Air', 'value': false,"expand":false},
    {"image":"assets/icons/train.png",'label': 'Train', 'value': false,"expand":false},
    {"image":"assets/icons/bedrom.png",'label': 'Lodging', 'value': false,"expand":false},
    {"image":"assets/icons/fastfood.png",'label': 'Food', 'value': false,"expand":false},
    {"image":"assets/icons/bus.png",'label': 'Bus', 'value': false,"expand":false},
    {"image":"assets/icons/fuel.png",'label': 'Fuel', 'value': false,"expand":false},
    {"image":"assets/icons/entertain.png",'label': 'Entertainment', 'value': false,"expand":false},
  ].obs;

}