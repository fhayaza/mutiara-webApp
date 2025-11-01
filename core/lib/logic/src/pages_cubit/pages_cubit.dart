import 'package:core/core.dart';

class PagesCubit extends Cubit<int> {
  PagesCubit() : super(0);
  void refresher() => emit(state + 1);
}
