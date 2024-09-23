
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


import 'package:intl/intl.dart';
import 'package:travel_claim/global/globalValues.dart';
import 'package:travel_claim/views/components/common.dart';

class Addexpensecontroller extends GetxController{

    RxString lstrbranchName = ''.obs;
    RxString lstrTypeofTrip = ''.obs;

    RxString lstrTrainClass= 'AC 2 tier class'.obs;
    RxString lstrBusClass= 'AC Sleeper'.obs;
    late FocusNode amountfocusNode;
    final NumberFormat _numberFormat = NumberFormat("#,##0.00");
    late Future <dynamic> futureform;
    var g = Global();
     TextEditingController txtNoOfEmployee=TextEditingController(text: "1");
     TextEditingController txtSuggestionEmpCode=TextEditingController();
     RxBool airButtonTapped =false.obs;
    TextEditingController txtpurposeTrip = TextEditingController();
    Rx<DateTime> fromDate = DateTime.now().obs;
    Rx<DateTime> checkInDate = DateTime.now().obs;
    Rx<DateTime> checkOutDate = DateTime.now().obs;
    RxList selectedChips = [].obs;
    RxList selectedCtegory = [].obs;
    RxList addmoreList = [].obs;

    RxList   filteredEmployees= [].obs;
    RxList<String> chipsList = ['Abh(MYGX-1234)', 'Abh(Myg)',"Bobi isac", 'vibhin', 'Subhin(MYGX-1234)'].obs;
    RxList<String> trainClassList = ['AC 2 tier class', 'AC 3 tier class', 'AC 2tier class/chainr class', 'Sleeper'].obs;
    RxList<String> busClassList = ['AC Sleeper', 'AC Semi - Sleeper'].obs;

    final Rx<TextEditingController> txtAmount = TextEditingController().obs;
    void deleteChip(String chip) {

      selectedChips.remove(chip);

    }
    var typeOfTripList = [

    ].obs;
     var branchList=[

     ].obs;


    // final RxList<Map<String, dynamic>> expenseCategory = [
    //   {"image":"assets/icons/flight.png",'label': 'Air', 'value': false,"expand":false,'addmore':1},
    //   {"image":"assets/icons/train.png",'label': 'Train', 'value': false,"expand":false,'addmore':1},
    //   {"image":"assets/icons/bedrom.png",'label': 'Lodging', 'value': false,"expand":false,'addmore':1},
    //   {"image":"assets/icons/fastfood.png",'label': 'Food', 'value': false,"expand":false,'addmore':1},
    //   {"image":"assets/icons/bus.png",'label': 'Bus', 'value': false,"expand":false,'addmore':1},
    //   {"image":"assets/icons/fuel.png",'label': 'Fuel', 'value': false,"expand":false,'addmore':1},
    //   {"image":"assets/icons/entertain.png",'label': 'Entertainment', 'value': false,"expand":false,'addmore':1},
    // ].obs;
    var expenseCategory = [
      // {
      //   "CategoryID": 1,
      //   "CategoryName": "Air",
      //   "TripFrom": "1",
      //   "TripTo": "1",
      //   "FromDate": "0",
      //   "ToDate": "0",
      //   "DocumentDate": "1",
      //   "StartMeter": "0",
      //   "EndMeter": "0",
      //   "ImageUrl": "https://info91.co.in/myg/images/category/Air.png",
      //   "Expand": false,
      //   "Oncheck": false
      // },
      // {
      //   "CategoryID": 2,
      //   "CategoryName": "Train",
      //   "TripFrom": "1",
      //   "TripTo": "1",
      //   "FromDate": "",
      //   "ToDate": "",
      //   "DocumentDate": "1",
      //   "StartMeter": "0",
      //   "EndMeter": "0",
      //   "ImageUrl": "https://info91.co.in/myg/images/category/Train.png",
      //   "Expand": false,
      //   "Oncheck": false
      // },
      // {
      //   "CategoryID": 3,
      //   "CategoryName": "Cab",
      //   "TripFrom": "1",
      //   "TripTo": "1",
      //   "FromDate": "0",
      //   "ToDate": "0",
      //   "DocumentDate": "0",
      //   "StartMeter": "0",
      //   "EndMeter": "0",
      //   "ImageUrl": "https://info91.co.in/myg/images/category/Cab.png",
      //   "Expand": false,
      //   "Oncheck": false
      // },
      // {
      //   "CategoryID": 4,
      //   "CategoryName": "Lodging",
      //   "TripFrom": "0",
      //   "TripTo": "0",
      //   "FromDate": "1",
      //   "ToDate": "1",
      //   "DocumentDate": "1",
      //   "StartMeter": "0",
      //   "EndMeter": "0",
      //   "ImageUrl": "https://info91.co.in/myg/images/category/Lodging.png",
      //   "Expand": false,
      //   "Oncheck": false
      // },
    ].obs;
    fnOnChnageTrip(val,mode) {
      if(mode=="Trip"){
        lstrTypeofTrip.value = val;
        update();
      }
      if(mode=="Bus"){
        lstrBusClass.value = val;
      }
      else if(mode=="Branch"){
        lstrbranchName.value = val;
        update();
      }
      else if(mode=="Train"){
        lstrTrainClass.value = val;
      }


    }
    fnOnChnageSuggestionValue(val){
      dprint("saaaaaaaaaaaa>>>>>>>>>>>>>>>>>>>>>>> ${val}");
      // final filterlist = chipsList.contains(val.toString().toLowerCase());
      // dprint("FINA;;SDSA > > >> >${filterlist}");
      filteredEmployees.value = chipsList.where((e) => e.toLowerCase().contains(txtSuggestionEmpCode.text.toLowerCase())).toList();
      dprint("Fweweweewew > >> >${filteredEmployees}");


    }


    Future<void> wSelectFromDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2023, 1),
          lastDate: DateTime(2050, 8),
          initialDate: DateTime.now());
      if (pickedDate != null && pickedDate != fromDate.value) {
        fromDate.value = pickedDate;


      }
    }
    Future<void> wSelectCheckInDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2023, 1),
          lastDate: DateTime(2050, 8),
          initialDate: DateTime.now());
      if (pickedDate != null && pickedDate != checkInDate.value) {
        checkInDate.value = pickedDate;


      }
    }
    Future<void> wSelectCheckOutDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2023, 1),
          lastDate: DateTime(2050, 8),
          initialDate: DateTime.now());
      if (pickedDate != null && pickedDate != checkOutDate.value) {
        checkOutDate.value = pickedDate;


      }
    }
    void formatNumber() {
      if (txtAmount.value.text.isNotEmpty) {

          txtAmount.value.text = _numberFormat.format(double.tryParse(txtAmount.value.text));
          dprint("ADSADADAS  >>>  >>> ${txtAmount.value.text}");
      }
    }

    fetchData()async{
      dprint("api callllll");


      selectedCtegory.value = [];
      amountfocusNode = FocusNode();
      filteredEmployees.value =
          chipsList;

      // Add listener to the FocusNode
      amountfocusNode.addListener(() {
        if (!amountfocusNode.hasFocus) {
          // Perform action when keyboard is dismissed
          print('Keyboard dismissed');
          formatNumber();
          // You can replace this with any action you want to perform
        }
      });
    }

    void fnCheckCategory(oncheck,val){


      expenseCategory.value[oncheck]["Oncheck"] = val;
      dprint("ONCHECK >>>> ${oncheck}");
      // oncheck.value = !val;
      update();
    }

    //===================================================API
    apiGetListofBranches(){
     // futureform = ApiCall().apiGetBranches();
     //  futureform.then((value) => apiGetListofBranchesRes(value));
    }

    apiGetListofBranchesRes(value){
      try{
        dprint("Apiiiivaluee......................");
        dprint(value);

        if(g.fnValCheck(value)){
          var sts  =  value["success"];
          var msg  =  value["message"]??"";
          if(sts=="success"){
            dprint("4444444444444444444444444444444444444444444");
            var data =  value["data"];
            branchList.value = data;
            dprint("g.wstrBranchList ${  branchList.value}");
            lstrbranchName.value = branchList.value[0]["BranchName"].toString();
            dprint("lstrBranchName.value .valueDATA >>> ${ lstrbranchName.value  }");
          }

        }
      }catch(e){
        dprint(e);
      }


    }


    apiGetListofTypeTrip(){
    //  futureform = ApiCall().apiGettypeTrip();
    //  futureform.then((value) => apiGetListofTypeTripRes(value));
    }

    apiGetListofTypeTripRes(value){
      try{
        dprint("Apiiiivaluee......................");
        dprint(value);

        if(g.fnValCheck(value)){
          var sts  =  value["success"];
          var msg  =  value["message"]??"";
          if(sts=="success"){
            dprint("4444444444444444444444444444444444444444444");
            var data =  value["data"];
            typeOfTripList.value = data;
            dprint("g.typeOfTripList ${ typeOfTripList}");
            lstrTypeofTrip.value = typeOfTripList.value[0]["TripTypeName"].toString();
          }

        }
      }catch(e){
        dprint(e);
      }


    }



    apiGetCategories(){
    //  futureform = ApiCall().apiGetCategorys();
     // futureform.then((value) => apiGetCategoriesRes(value));
    }

    apiGetCategoriesRes(value){
      try{
        dprint("Apiiiivaluee......................");
        dprint(value);

        if(g.fnValCheck(value)){
          var sts  =  value["success"];
          var msg  =  value["message"]??"";
          if(sts=="success"){
            dprint("4444444444444444444444444444444444444444444");
            var data =  value["data"]??"";
            dprint("Ctegoryss>>>> ${data}");
            expenseCategory.value = data;
            update();

            dprint("sdfssd22222222222222}");
          }

        }
      }catch(e){
        dprint(e);
      }


    }



}