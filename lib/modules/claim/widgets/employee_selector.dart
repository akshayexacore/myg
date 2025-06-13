import 'package:flutter/material.dart';
import 'package:flutter_simple_multiselect/flutter_simple_multiselect.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_claim/models/employee.dart';
import 'package:travel_claim/models/fromto.dart';
import 'package:travel_claim/modules/claim/widgets/select_tag.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/views/components/app_dialog.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class EmployeeSelector extends StatefulWidget {
  final int maxSelection;
  final ValueChanged<List<Employee>> onChanged;
  List<Employee> items;
  EmployeeSelector({super.key, required this.maxSelection, required this.onChanged,this.items = const []});

  @override
  State<EmployeeSelector> createState() => _EmployeeSelectorState();
}

class _EmployeeSelectorState extends State<EmployeeSelector> {

  bool isLoading = false;
  List<Employee> selectedItems = [];
  late FToast fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    selectedItems = widget.items.isNotEmpty ? widget.items : [];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FlutterMultiselect<Employee>(
        autofocus: false,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        enableBorderColor: Colors.grey.shade400,
        focusedBorderColor: Colors.grey.shade400,
        backgroundColor: Colors.white,
        suggestionsBoxBackgroundColor: Colors.white,
        borderRadius: 10,
        borderSize: 1,
        multiselect: true,
        inputDecoration: InputDecoration(
          hintText: "Type Employee Code to search",
          contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
          errorStyle: TextStyle(fontSize: 1,color: Colors.transparent),
          hintStyle: hintTextStyle()
        ),
        textStyle: const TextStyle(fontFamily: 'Roboto',fontSize: 14,color: Colors.black,fontWeight: FontWeight.normal),
        suggestionsBoxRadius: 12,
        resetTextOnSubmitted: true,
        minTextFieldWidth: 300,
        validator: (value) {
          if (selectedItems.length < widget.maxSelection) {
                  return "Min ${widget.maxSelection} employee${widget.maxSelection==1?'':'s'} required";
                }
          return null;
        },
        suggestionsBoxMaxHeight: 300,
        length: selectedItems.length,
        isLoading: isLoading,
        tagBuilder: (context, index) => SelectTag(
          index: index,
          label: '${selectedItems[index].name} (${selectedItems[index].employeeId})',
          onDeleted: (value) {
            selectedItems.removeAt(index);
            setState(() {});
            widget.onChanged.call(selectedItems);
          },
        ),
        suggestionBuilder: (context, state, data) {
          var existingIndex = selectedItems
              .indexWhere((element) => element.id == data.id);
          var selectedData = data;
          return Material(
            color: Colors.white,
              child: GestureDetector(
                onPanDown: (_) {

                  var existingIndex = selectedItems.indexWhere(
                          (element) => element.id == data.id);
                  if (existingIndex >= 0) {
                    selectedItems.removeAt(existingIndex);
                  } else {
                    if(selectedItems.length>=widget.maxSelection){
                      AppDialog.showToast("You can only select ${widget.maxSelection} employee",isError: true);
                      /*fToast.showToast(
                        child: Center(
                          child: showToastMessage(msg: ,
                              iconColor: Colors.red,icon: Icons.close_rounded),
                        ));*/
                      return;
                    }
                    selectedItems.add(data);
                  }

                  state.selectAndClose(data);
                  setState(() {});
                  widget.onChanged.call(selectedItems);
                },
                child: ListTile(
                  selected: existingIndex >= 0,
                  titleTextStyle: TextStyle(fontSize: 14,color: existingIndex >= 0 ? Colors.white : Colors.black),
                  trailing:
                  existingIndex >= 0 ? const Icon(Icons.close) : null,
                  selectedColor: Colors.white,
                  selectedTileColor: primaryColorLight.withOpacity(0.7),
                  title: Text('${selectedData.name} (${selectedData.employeeId})'),
                ),
              ));
        },
        suggestionsBoxElevation: 0,
        findSuggestions: (String query) async {
          if(query.isEmpty){
            return [];
          }
          setState(() {
            isLoading = true;
          });

          var data = await searchFunctionAsync(query);
          setState(() {
            isLoading = false;
          });
          return data;
        });
  }


  Future<List<Employee>> searchFunctionAsync(query) async {
    var response =  await MygRepository().getEmployees(query: query);
    if(response.success){
      return response.employee;
    }else{
      return [];
    }
  }
}
class FromToSector extends StatefulWidget {
  final int maxSelection;
  final ValueChanged<List<LocationModel>> onChanged;
  List<LocationModel> items;
  final TextEditingController? controller;
  final String? title;
  final bool? isTo;
  final String? lat;
  final String? lon;
  final bool? readOnly;
  final Function? valueClear;

  FromToSector(
      {super.key,
      required this.maxSelection,
      required this.onChanged,
      this.items = const [],
      this.title,
      this.valueClear,
      this.controller, this.isTo, this.lat, this.lon, this.readOnly});

  @override
  State<FromToSector> createState() => _FromToSectorState();
}

class _FromToSectorState extends State<FromToSector> {
  bool isLoading = false;
  List<LocationModel> selectedItems = [];
  late FToast fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    selectedItems = widget.items.isNotEmpty ? widget.items : [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title?.isNotEmpty == true) ...[
          Row(
            children: [
              ts(widget.title, Colors.black)
          
            ],
          ),
         gapHC(3),
        ],
        FlutterMultiselect<LocationModel>(
            controller: widget.controller,
            autofocus: false,
            readOnly:widget.readOnly?? selectedItems.isNotEmpty,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            enableBorderColor: Colors.grey.shade400,
            focusedBorderColor: Colors.grey.shade400,
            backgroundColor:Colors.white,
            suggestionsBoxBackgroundColor: Colors.white,
            borderRadius: 10,
            borderSize: 1,
            multiselect: false,
            resetTextOnSubmitted: true,
            inputDecoration: InputDecoration(
              isDense: true,
              hintText: "Search  location",
              suffixIcon: selectedItems.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          selectedItems.clear();
                          widget.controller?.clear();
                        });
                        // widget.onChanged.call(selectedItems);
                        if (widget.valueClear != null) widget.valueClear!();
                      },
                    )
                  : null,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 17),
              errorStyle: TextStyle(fontSize: 1, color: Colors.transparent),
              // hintStyle: hintTextStyle()
            ),
            textStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.normal),
            suggestionsBoxRadius: 12,
            minTextFieldWidth: 300,
            validator: (value) {
              if (selectedItems.length < widget.maxSelection) {
                return "required";
              }
              return null;
            },
            suggestionsBoxMaxHeight: 300,
            length: selectedItems.length,
            isLoading: isLoading,
            tagBuilder: (context, index) => SelectTag(
                  index: index,
                  label: '${selectedItems[index].name}',
                  onDeleted: (value) {
                    selectedItems.removeAt(index);
                    setState(() {});
                    widget.onChanged.call(selectedItems);
                  },
                ),
            suggestionBuilder: (context, state, data) {
              var existingIndex = selectedItems
                  .indexWhere((element) => element.name == data.name);
              var selectedData = data;
              return Material(
                  color: Colors.white,
                  child: GestureDetector(
                    onPanDown: (_) {
                      var existingIndex = selectedItems.indexWhere(
                          (element) => element.name == data.name);
                      if (existingIndex >= 0) {
                        selectedItems.removeAt(existingIndex);
                      } else {
                        if (selectedItems.length >= widget.maxSelection) {
                          AppDialog.showToast(
                              "You can only select ${widget.maxSelection} employee",
                              isError: true);
                          /*fToast.showToast(
                            child: Center(
                              child: showToastMessage(msg: ,
                                  iconColor: Colors.red,icon: Icons.close_rounded),
                            ));*/
                          return;
                        }
                        selectedItems.add(data);
                      }

                      state.selectAndClose(data);
                      setState(() {});
                      widget.onChanged.call(selectedItems);
                    },
                    child: ListTile(
                      selected: existingIndex >= 0,
                      titleTextStyle:
                          TextStyle(fontSize: 14, color: Colors.black),
                      trailing:
                          existingIndex >= 0 ? const Icon(Icons.clear) : null,
                      selectedColor: Colors.black,
                      selectedTileColor: primaryColorLight,
                      tileColor:
                          existingIndex >= 0 ? Colors.red : Colors.transparent,
                      title: Text('${selectedData.name} '),
                    ),
                  ));
            },
            suggestionsBoxElevation: 0,
            findSuggestions: (String searchkey) async {
              print("the query is here$searchkey");
              if (searchkey.isEmpty) {
                return [];
              }
              setState(() {
                isLoading = true;
              });

              var data = await searchFunctionAsyncdEaler(searchkey,isTo: widget.isTo??false,lat: widget.lat,long: widget.lon);
              setState(() {
                isLoading = false;
              });
              return data;
            }),
      ],
    );
  }

  Future<List<LocationModel>> searchFunctionAsyncdEaler(searchkey,{bool isTo=false,String? lat,String? long}) async {
    var response = await MygRepository().getfromTo(query: searchkey,isTo: isTo,lat: lat,long: long);
    print("response$response");
    if (response.isNotEmpty) {
      return response;
    } else {
      return [];
    }
  }
}

