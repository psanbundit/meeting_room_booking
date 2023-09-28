class GeneralResponse<T> {
  T? data;
  String? errors; 
}

enum ResponseStatus {
  init,
  success,
  fail,
}
