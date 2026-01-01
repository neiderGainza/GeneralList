
import 'package:general_list/utils.dart';

class ListState<T> {

  final List<LabelFilter<T>> filters;
  final LabelOrder<T>? order;  
  final bool inverseOrder;

  final List<T>         items;
  final String ?        searchTerm;

  
  const ListState({
    this.items = const [],
    this.filters = const [],
    this.order,
    this.inverseOrder = false,
    this.searchTerm,
  });


  ListState<T> copyWith({
    List<T> ? items,
    final List<LabelFilter<T>> ? filters,
    LabelOrder<T> ? order,
    String ? searchTerm,
    bool ? inverseOrder,
  }){
    return ListState<T>(
      filters: filters ?? this.filters,
      order:  order ?? this.order,
      searchTerm:  searchTerm ?? this.searchTerm,
      inverseOrder: inverseOrder ?? this.inverseOrder,
      items: items ?? this.items
    );
  }
}