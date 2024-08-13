import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ClaimapprovelController extends GetxController{
  RxString lstrApprover = 'GM'.obs;
  RxList claimList = [
    {"image":"assets/icons/flight.png",'Amount':'34 INR','AttachedFile':'tickets.pdf','Remark':'Economyclass','DocDate':'22/02/2024','From':'Kozhikode','To':'Thrissure','label': 'Air',"expand":false},
    {"image":"assets/icons/train.png",'Amount':'123 INR','AttachedFile':'tickets.pdf','Remark':'Aclass','DocDate':'22/02/2024','From':'Manjeri','To':'Thrissure','label': 'Train',"expand":false},
    {"image":"assets/icons/bedrom.png",'Amount':'546 INR','AttachedFile':'tickets.pdf','Remark':'Economyclass','DocDate':'22/02/2024','From':'Kozhikode','To':'Wayanadu','label': 'Lodging',"expand":false},
    { "image":"assets/icons/fastfood.png",'Amount':'456 INR','AttachedFile':'tickets.pdf','Remark':'Secondclass','DocDate':'22/02/2024','From':'Kochi','To':'Palakkad','label': 'Food',"expand":false},
    {"image":"assets/icons/bus.png",'Amount':'234 INR','AttachedFile':'tickets.pdf','Remark':'Fistclass','DocDate':'22/02/2024','From':'Kozhikode','To':'Thrissure','label': 'Bus',"expand":false},
    {"image":"assets/icons/fuel.png",'Amount':'356 INR','AttachedFile':'tickets.pdf','Remark':'Economyclass','DocDate':'22/02/2024','From':'Malappuram','To':'Kochi','label': 'Fuel',"expand":false},
    {"image":"assets/icons/entertain.png",'Amount':'6786 INR','AttachedFile':'tickets.pdf','Remark':'Economyclass','DocDate':'22/02/2024','From':'Mannarkad','To':'Malappuram','label': 'Entertainment',"expand":false},

  ].obs;

  RxList numberOfemployeelist = [
    'Abhin (MYGX-1234)',
    'Abhin (MYGX-1534)',
    'Abhin (MYGX-1334)',

  ].obs;
  var approverList =[
    'GM','CBDO'
  ];
  fnOnsselectApprover(val) {

    lstrApprover.value = val;


    }


  }
