import 'package:back_end/app/api/api.dart';

abstract class RegisterUseCase {
  Future<bool> call({required RequestParams requestParams});
}
