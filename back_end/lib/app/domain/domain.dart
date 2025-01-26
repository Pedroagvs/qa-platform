library domain;

import 'dart:typed_data';

import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/aplication_dto.dart';
import 'package:back_end/app/api/dto/dashboard_dto.dart';
import 'package:back_end/app/api/dto/historic_dto.dart';
import 'package:back_end/app/api/dto/test_dto.dart';
import 'package:back_end/app/api/dto/user_dto.dart';

part 'usecases/aplicacao/aplicadao_usecase.dart';
part 'usecases/auth/auth_usecase.dart';
part 'usecases/dashboard/dashboard_usecase.dart';
part 'usecases/historico/historico_usecase.dart';
part 'usecases/teste/teste_usecase.dart';
part 'usecases/user/user_usecase.dart';
