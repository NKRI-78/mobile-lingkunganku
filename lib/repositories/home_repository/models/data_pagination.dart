import 'pagination_model.dart';

class DataPagination<T> {
  final List<T> list;
  final PaginationModel paginate;
  DataPagination({this.list = const [], PaginationModel? paginate})
      : paginate = paginate ?? PaginationModel(current: 1, perPage: 1);
}
