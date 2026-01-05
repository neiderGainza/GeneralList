import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/utils.dart';
import 'package:general_list/view_model/list_bloc.dart';
import 'package:general_list/view_model/list_event.dart';
import 'package:general_list/view_model/list_state.dart';


class SortButton<T> extends StatelessWidget {
  const SortButton({
    super.key,
    required this.orderChoices
  });

  final List<LabelOrder<T>> orderChoices;

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<ListBloc<T>, ListState<T>>(
      builder: (context, state) {

        return IntrinsicWidth(
          child: Row(
            children: [
              DropdownButton<String>(
                value: state.order?.label,
                items: [
                  for (final orderChoice in orderChoices)
                  DropdownMenuItem<String>(value: orderChoice.label , child: Text(orderChoice.label))
                ], 

                onChanged: (value){
                  if(value != null){
                    for (final orderChoice in orderChoices){
                      if(orderChoice.label == value){
                        context.read<ListBloc<T>>().add(
                          OrderChangedEvent(order: orderChoice)
                        );
                      }
                    }
                  }
                },

                underline: SizedBox.shrink(),
                icon: SizedBox.shrink(),
                focusColor: Colors.transparent,
                hint: Text("Order"),
                alignment: Alignment.centerRight,
              ),
              IconButton(
                onPressed: (){
                  context.read<ListBloc<T>>().add(
                    InverseOrderEvent()
                  );
                }, 
                icon: state.inverseOrder 
                      ? const Icon(Icons.arrow_upward)
                      : const Icon(Icons.arrow_downward) 
              )
            ],
          ),
        ); 
      },
    );
  }
}
