class GeneralResponse<T> {
  T? data;
  String? errors; 
}

enum ResponseStatus {
  init,
  sucess,
  fail,
}
