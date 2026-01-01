import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/filter_widget/filter_widget.dart';
import 'package:general_list/utils.dart';
import 'package:general_list/view_model/list_bloc.dart';
import 'package:general_list/widget/filter_bar.dart';
import 'package:general_list/widget/filter_button.dart';
import 'package:general_list/widget/my_grid_view.dart';
import 'package:general_list/widget/my_list_view.dart';
import 'package:general_list/widget/my_search_bar.dart';
import 'package:general_list/widget/sort_button.dart';

class GeneralList<T> extends StatelessWidget {
  const GeneralList({
    super.key,
    required this.itemBuilder,
    required this.getItems,
    
    this.viewAsList = true, // display as list or grid
    this.gridDelegate,

    this.filters = const [], // filters
    this.filterWidgets,

    this.order, //order
    this.orderChoices, 

    this.searchFunction, // search
    this.searchThreshold = 0.7
  });


  /// If true the items will be display in a list
  /// if false [gridDelegate] cat not be null  
  final bool viewAsList;

  /// If [viewAsList] is false this can not be false
  final SliverGridDelegate ? gridDelegate;

  
  final Widget Function(BuildContext context, T object) itemBuilder; 
  final Stream<List<T>> Function() getItems;


  final List<LabelFilter<T>> filters;
  final int? order;  

  final List<FilterWidget<T>> ? filterWidgets;
  final List<LabelOrder<T>>? orderChoices;


  final double Function(T item, String searchTerm) ? searchFunction;
  final double searchThreshold;


  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => ListBloc<T>(
        getItemsStream: getItems,
        actualFilters: [],
        actualOrder: orderChoices?[0]
      ),

      child: Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Column(
          children: [
            // if (searchFunction != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MySearchBar<T>(),
            ),
            (MediaQuery.of(context).size.width < 600)
            ? filterBarOnDiferentLine(context)
            : filterBarOnSameLine(context),

            Expanded(
              child: (viewAsList)
                    ? MyListView(itemBuilder: itemBuilder)
                    : MyGridView(itemBuilder: itemBuilder, gridDelegate: gridDelegate!)
            ),
          ],
        ),
      ),
    );
  }


  Widget filterBarOnDiferentLine(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(filterWidgets != null)
              FilterButton<T>( filterWidgets: filterWidgets! ),
              Spacer(),
              if(orderChoices != null && orderChoices!.length > 1)
              SortButton<T>( orderChoices: orderChoices! ,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: FilterBar<T>(),
        ),
      ],
    );
  }  


  Widget filterBarOnSameLine(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(filterWidgets != null)
          FilterButton<T>( filterWidgets: filterWidgets! ),
          SizedBox(width: 32,),
          Expanded(child: FilterBar<T>()),
          if(orderChoices != null && orderChoices!.length > 1)
          SortButton<T>( orderChoices: orderChoices! ,),
        ],
      ),
    );
  }  
}
