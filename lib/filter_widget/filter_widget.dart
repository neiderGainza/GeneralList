import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/utils.dart';
import 'package:general_list/view_model/list_bloc.dart';
import 'package:general_list/view_model/list_event.dart';

abstract class FilterWidget<T> extends StatelessWidget{
  const FilterWidget({
    super.key,

  });
  

  void addFilter(BuildContext context, LabelFilter<T> filter){
    context.read<ListBloc<T>>().add(
      FilterAddedEvent<T>(filter: filter)
    );
  }

  void removeFilter(BuildContext context, LabelFilter<T> filter){
    context.read<ListBloc<T>>().add(
      FilterRemovedEvent<T>(filter: filter)
    );
  }
  

  
  List<LabelFilter<T>> getSelectedFilters(BuildContext context){
    return context.watch<ListBloc<T>>().state.filters;
  }

  List<String> getSelectedFilterLabels(BuildContext context){
    return [ for(final filter in context.watch<ListBloc<T>>().state.filters) filter.label];
  }

  List<Filter<T>> getSelectedFilterFunctions(BuildContext context){
    return [ for(final filter in context.watch<ListBloc<T>>().state.filters) filter.filter];
  }

}








