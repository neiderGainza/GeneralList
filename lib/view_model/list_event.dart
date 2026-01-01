
import 'package:general_list/utils.dart';

class ListEvent<T> { const ListEvent(); }


/// List level Events
class RefreshEvent<T>        extends ListEvent<T>{
  final List<T> items;
  const RefreshEvent({required this.items});
}

class UpdateFilterOrderEvent<T> extends ListEvent<T>{}

/// Item level Events
class ItemAddedEvent         extends ListEvent{}

class ItemUpdatedEvent       extends ListEvent{}


/// Filters
class FilterAddedEvent<T>       extends ListEvent<T>{
  final LabelFilter<T> filter;

  const FilterAddedEvent({
    required this.filter
  });
}

class FilterRemovedEvent<T>     extends ListEvent<T>{
  final LabelFilter<T> filter;

  const FilterRemovedEvent({
    required this.filter
  });  
}

class FiltersClearEvent      extends ListEvent{}


/// Order
class OrderChangedEvent<T>      extends ListEvent<T>{
  final LabelOrder<T> order;
  const OrderChangedEvent({
    required this.order
  });
}

class InverseOrderEvent<T>      extends ListEvent<T>{}   


/// Search
class SearchTermChangedEvent<T> extends ListEvent<T>{
  final String searchTerm;

  const SearchTermChangedEvent ({
    required this.searchTerm
  });
}
