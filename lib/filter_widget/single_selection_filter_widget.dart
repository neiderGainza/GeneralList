import 'package:flutter/material.dart';
import 'package:general_list/filter_widget/filter_widget.dart';
import 'package:general_list/utils.dart';

class SingleSelectionFilterWidget<T> extends FilterWidget<T>{
  
  const SingleSelectionFilterWidget({
    super.key,

    required this.choices,
    required this.title
  });

  final List<LabelFilter<T>> choices;
  final String title;

  @override
  Widget build(BuildContext context) {
    final selectedFilterLabels = getSelectedFilterLabels(context);
    int ? initialSelection;

    for(int i = 0; i < choices.length; i++){
      if( selectedFilterLabels.contains(choices[i].label) ){
        initialSelection = i;
        break;
      }
    }

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      clipBehavior: Clip.hardEdge,
      
      child: SingleSelectionCheckBoxList(
        choices: choices,
        addFilter: addFilter,
        removeFilter: removeFilter,
        initialSelection: initialSelection,
        title: title,
      ),
    );
  }
}



class SingleSelectionCheckBoxList<T> extends StatefulWidget{
  const SingleSelectionCheckBoxList({
    super.key,
    required this.choices,
    required this.addFilter,
    required this.removeFilter,
    required this.title,
    this.initialSelection
  });
  
  final String title;
  final int? initialSelection;
  final List<LabelFilter<T>> choices;
  final Function(BuildContext context, LabelFilter<T> filter) addFilter;
  final Function(BuildContext context, LabelFilter<T> filter) removeFilter;


  @override
  State<SingleSelectionCheckBoxList<T>> createState() => _SingleSelectionCheckBoxListState<T>();
}


class _SingleSelectionCheckBoxListState<T> extends State<SingleSelectionCheckBoxList<T>> {
  int ? selected;

  @override
  void initState() {
    selected = widget.initialSelection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RadioGroup<int>(
      groupValue: selected,

      onChanged: (value) async {
        if(selected != null) await widget.removeFilter(context, widget.choices[selected!]);
        if(value    != null) await widget.addFilter(context, widget.choices[value]);

        selected = value;
        setState(() {});
      },
      
      child: ExpansionTile(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        collapsedBackgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      
        initiallyExpanded: true,
        shape: Border(
          top: BorderSide.none,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: Theme.of(context).textTheme.bodyLarge!.fontWeight
          ),
        ),
        children: [
          for(int i = 0; i < widget.choices.length; i++)
          RadioListTile(
            value: i, 
            title: Text(
              widget.choices[i].label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant
              ),
            ),
          )
        ],
      ),
    );
  }
}





