import 'package:get/get.dart';

class NotificationController extends GetxController {
  List<Map<String, String>> notificationList = [
    {
      "text":
          "The finance approver has [red]rejected[/red] the category [red]Train[/red] in claim [red]#TMG1234.[/red]"
    },
    {
      "text":
          "Your claim [red]#TMG1234[/red] has been [red]rejected[/red] by the reporting person"
    },
    {
      "text":
          "Your claim[red] #TMG1234[/red] has been [green]approved[/green], and the claim amount will be credited"
    },
    {
      "text":
          "The finance approver has [red]rejected[/red] the category [red]Train[/red] in claim [red]#TMG1234.[/red]"
    },
    {
      "text":
          "Your claim [red]#TMG1234[/red] has been [green]approved[/green] by the reporting person"
    },
  ];
}
