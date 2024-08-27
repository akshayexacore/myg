import 'package:flutter/material.dart';
import 'package:flutter_simple_multiselect/flutter_simple_multiselect.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_claim/models/employee.dart';
import 'package:travel_claim/modules/claim/widgets/select_tag.dart';
import 'package:travel_claim/resources/myg_repository.dart';
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
        borderRadius: 10,
        borderSize: 1,
        multiselect: true,
        inputDecoration: InputDecoration(
          hintText: "Type to search employees",
          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
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
              child: GestureDetector(
                onPanDown: (_) {
                  if(selectedItems.length>=widget.maxSelection){
                    fToast.showToast(
                        child: Center(
                          child: showToastMessage(msg: "You can only select ${widget.maxSelection} employee",
                              iconColor: Colors.red,icon: Icons.close_rounded),
                        ));
                    return;
                  }

                  var existingIndex = selectedItems.indexWhere(
                          (element) => element.id == data.id);
                  if (existingIndex >= 0) {
                    selectedItems.removeAt(existingIndex);
                  } else {
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
                  existingIndex >= 0 ? const Icon(Icons.check) : null,
                  selectedColor: Colors.white,
                  selectedTileColor: Colors.black26,
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
