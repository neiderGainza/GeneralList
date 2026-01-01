typedef Filter<T>       = Future<bool> Function(T value);
typedef Order<T>        = int Function(T itemA, T itemB);

typedef LabelFilter<T>  = ({String label, Filter<T> filter});
typedef LabelOrder<T>   = ({String label, Order<T> order});