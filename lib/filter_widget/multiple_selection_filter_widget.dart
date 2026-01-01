import 'package:flutter/material.dart';
import 'package:general_list/filter_widget/filter_widget.dart';
import 'package:general_list/utils.dart';


class MultipleSelectionFilterWidget<T> extends FilterWidget<T>{
  
  const MultipleSelectionFilterWidget({
    super.key,

    required this.choices,
    required this.title
  });

  final List<LabelFilter<T>> choices;
  final String title;

  @override
  Widget build(BuildContext context) {
    final selectedFilterLabels = getSelectedFilterLabels(context);

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      clipBehavior: Clip.hardEdge,
      
      child: ExpansionTile(
        initiallyExpanded: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        collapsedBackgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: Border(
          top: BorderSide.none
        ),
        title: Text(title),
        children: [
          for(final choice in choices)
          MyCheckBoxListTile<T>(choice: choice, addFilter: addFilter, removeFilter: removeFilter, initialValue: selectedFilterLabels.contains(choice.label),)
        ],
      ),
    );
  }
}


class MyCheckBoxListTile<T> extends StatefulWidget {
  const MyCheckBoxListTile({
    super.key,
    required this.choice,
    required this.addFilter,
    required this.removeFilter,
    required this.initialValue,
  });


  final bool initialValue;
  final LabelFilter<T> choice;
  final Function(BuildContext context, LabelFilter<T> filter) addFilter;
  final Function(BuildContext context, LabelFilter<T> filter) removeFilter;

  @override
  State<MyCheckBoxListTile<T>> createState() => _MyCheckBoxListTileState<T>();
}


class _MyCheckBoxListTileState<T> extends State<MyCheckBoxListTile<T>> {
  bool value = false;

  @override 
  void initState() {
    value = widget.initialValue;
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value, 
      title: Text( widget.choice.label ),
      onChanged: (newValue){
        if(newValue != null){
          setState(() {
            value = newValue;
          });

          if(newValue == true){
            widget.addFilter(context, widget.choice);
          }
          if(newValue == false){
            widget.removeFilter(context, widget.choice);
          }
        }
      }
    );
  }
}






