import 'denemo.dart';

class DenemoService {
  static List<DenemoModel> getDenemoListByCity(City city) {
    return denemoList.where((denemo) => denemo.location == city).toList();
  }
}
