import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/view_model/list_bloc.dart';
import 'package:general_list/view_model/list_event.dart';
import 'package:general_list/view_model/list_state.dart';


class FilterBar<T> extends StatelessWidget {
  const FilterBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc<T>, ListState<T>>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerLeft,
          
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                
                for(final filter in state.filters)
                ...[
                  Chip(
                    label: Text(filter.label), 
                    deleteIcon: Icon(Icons.close), 
                    onDeleted: (){
                      context.read<ListBloc<T>>().add(
                        FilterRemovedEvent(filter: filter)
                      );
                    },
                    padding:EdgeInsets.all(0)),
                  const SizedBox(width: 2,),
                ]
              ],
            ),
          ),
        ); 
      }
    );
  }
}
