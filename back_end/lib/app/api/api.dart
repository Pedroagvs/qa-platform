library api;

import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/domain/exceptions/aplicacao/aplicacao_exeception.dart';
import 'package:back_end/app/domain/exceptions/auth/auth_exceptions.dart';
import 'package:back_end/app/domain/exceptions/common/common_exceptions.dart';
import 'package:back_end/app/domain/exceptions/register/register_exceptions.dart';
import 'package:back_end/app/functions/validates/validates.dart';

part 'controllers/aplicacao/aplicacao_controller.dart';
part 'controllers/auth/auth_controller.dart';
part 'controllers/controller.dart';
part 'controllers/dashboard/dashboard_controller.dart';
part 'controllers/historico/historico_controller.dart';
part 'controllers/teste/teste_controller.dart';
part 'controllers/user/user_controller.dart';

///
part 'handlers/aplicacao/aplicacao_handler.dart';
part 'handlers/auth/auth_handler.dart';
part 'handlers/dasboard/dashboard_handler.dart';
part 'handlers/handler.dart';
part 'handlers/historico/historico_handler.dart';
part 'handlers/teste/teste_handler.dart';
part 'handlers/user/user_handler.dart';
