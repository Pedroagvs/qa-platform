library data;

import 'dart:async';
import 'dart:typed_data';

import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/aplicacao_dto.dart';
import 'package:back_end/app/api/dto/historico_dto.dart';
import 'package:back_end/app/api/dto/teste_dto.dart';
import 'package:back_end/app/api/dto/user_dto.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/domain/exceptions/register/register_exceptions.dart';
import 'package:back_end/app/domain/usecases/register/register_usecase.dart';

part 'gateways/aplicacao/aplicacao_gateway.dart';
//Gateways
part 'gateways/auth/auth_gateway.dart';
part 'gateways/historico/historico_gateway.dart';
part 'gateways/register/register_gateway.dart';
part 'gateways/teste/teste_gateway.dart';
part 'gateways/user/user_gateway.dart';
part 'services/aplicacao/aplicacao_services.dart';
//Services
part 'services/auth/auth_services.dart';
part 'services/historico/historico_service.dart';
part 'services/register/register_services.dart';
part 'services/teste/teste_services.dart';
part 'services/user/user_services.dart';
