class StoreData {
  String StoreName;

  StoreData({
    required this.StoreName,
  });
}

class AuthProvider1 {
  static StoreData? _StoreData;

  static StoreData? get userData => _StoreData;

  static void setStoreData(StoreData data) {
    _StoreData = data;
  }
}
