import 'package:asp/asp.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/user_entity.dart';

final userState = atom<UserEntity>(UserDto.empty());
