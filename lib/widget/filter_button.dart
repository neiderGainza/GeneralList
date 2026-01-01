import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/filter_widget/filter_widget.dart';
import 'package:general_list/view_model/list_bloc.dart';



class FilterButton<T> extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.filterWidgets
  });


  final List<FilterWidget<T>> filterWidgets;


  @override
  Widget build(BuildContext context) {
    
    return FilledButton(
      onPressed: (){
        final listBLoc = context.read<ListBloc<T>>();
        
        showModalBottomSheet(
          context: context, 
          builder: (context){
            
            return BlocProvider<ListBloc<T>>.value(
              value: listBLoc,
              child : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,  
                  children: [
                    SizedBox(height: 16,),
                    for (var filterWidget in filterWidgets)
                    filterWidget
                  ],
                ),
              )
            );
          }
        );
      }, 
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        padding: WidgetStatePropertyAll(EdgeInsets.all(2))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.filter_list, 
            color: Theme.of(context).colorScheme.onSurfaceVariant, 
            size: 24,
          ),
          Text(
            "Filter", 
            style: TextStyle( 
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 16),
            )
        ],
      ),
      
    );
  }
}

