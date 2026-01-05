import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/utils.dart';
import 'package:general_list/view_model/list_event.dart';
import 'package:general_list/view_model/list_state.dart';


class ListBloc<T> extends Bloc<ListEvent<T>, ListState<T>>{
  
  final Stream< List<T> > Function() getItemsStream;
  final bool Function(T item, String searchTerm) ? searchFunction;
  late List<T> allItems;

  ListBloc({
    required this.getItemsStream,
    required List<LabelFilter<T>> actualFilters,
    required LabelOrder<T> ? actualOrder,
    this.searchFunction
  }):
  super(
    ListState<T>(
      filters: actualFilters,
      order: actualOrder
    )
  ){
    on<RefreshEvent<T>>           ( onRefreshEvent );
    on<SearchTermChangedEvent<T>> ( onSearchTermChangedEvent );
    
    on<InverseOrderEvent<T>>      ( onInverseOrderEvent );
    on<OrderChangedEvent<T>>      ( onOrderChangeEvent  );

    on<FilterAddedEvent<T>>       ( onFilterAddedEvent   );
    on<FilterRemovedEvent<T>>     ( onFilterRemovedEvent );

    _subscribeToListChanges();
  }


  void _subscribeToListChanges() async {
    await for(final itemList in getItemsStream()){
      allItems = itemList;

      add(
        RefreshEvent<T>(items: itemList)
      );
    }
  }

  void onRefreshEvent(RefreshEvent<T> event, Emitter emit) async {
    emit(
      state.copyWith(
        items: await _updateFilterOrder(
                              event.items, 
                              filters     : state.filters, 
                              order       : state.order,
                              inverseOrder: state.inverseOrder
        )
      )
    );
  }


  void onSearchTermChangedEvent(SearchTermChangedEvent<T> event, Emitter emit) async {
    assert(searchFunction != null);
    final itemList = await _updateFilterOrder(
                          allItems, 
                          filters     : state.filters, 
                          order       : state.order,
                          inverseOrder: state.inverseOrder
    );


    emit(
      state.copyWith(
        searchTerm: event.searchTerm,

        items: itemList.where(
          (item) => searchFunction!(item, event.searchTerm)
        ).toList(),
      ),
    );
  }


  void onOrderChangeEvent(OrderChangedEvent<T> event, Emitter emit) async {
    emit(
      state.copyWith(
        items: await _updateFilterOrder(
                              state.items, 
                              order: event.order,
                              inverseOrder: state.inverseOrder
        ),
        order: event.order
      )
    );
  }


  void onInverseOrderEvent(InverseOrderEvent<T> event , Emitter emit) async {
    emit(
      state.copyWith(
        items: await _updateFilterOrder(
                              state.items, 
                              inverseOrder: true
        ),
        inverseOrder: !state.inverseOrder
      )
    );
  }

  void onFilterAddedEvent(FilterAddedEvent<T> event , Emitter emit) async {
    emit(
      state.copyWith(
        items: await _updateFilterOrder(
                              state.items, 
                              filters: [...state.filters, event.filter]
        ),
        filters: [...state.filters, event.filter]
      )
    );
  }

  void onFilterRemovedEvent(FilterRemovedEvent<T> event, Emitter emit) async {
    emit(
      state.copyWith(
        items: await _updateFilterOrder(
                              allItems, 
                              filters: state.filters.where( 
                                  (labelFilter) => labelFilter.label != event.filter.label 
                                ).toList(),
                              order: state.order,
                              inverseOrder: state.inverseOrder
        ),
        filters: state.filters.where( 
          (labelFilter) => labelFilter.label != event.filter.label 
        ).toList()
      )
    );
  }




  Future<List<T>> _updateFilterOrder(List<T> items, {List<LabelFilter<T>> filters= const [], LabelOrder<T> ? order, bool inverseOrder = false}) async {
    List<T> result = [];

    item_loop:
    for( final item in items){
      for(final filter in filters ){
        if( ! await filter.filter(item) ){
          continue item_loop;
        }
      }

      result.add(item);
    }

    if( order != null ){
      result = result..sort( order.order );    
    }

    if (inverseOrder){
      result = result.reversed.toList();
    }


    return result;
  }
}


