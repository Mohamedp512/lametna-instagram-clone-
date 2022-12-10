enum LottieAnimation {
  dataNotFound(name: "data_not_found"),
  empty(name: "empty"),
  loading(name: "loading"),
  error(name: "error"),
  smallError(name: "small_error");

  final String name;
  const LottieAnimation({required this.name});
}

extension GetFullPath on LottieAnimation {
  String get fullPath => 'assets/animations/$name.json';
}
