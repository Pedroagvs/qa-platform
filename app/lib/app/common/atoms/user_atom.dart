import 'package:asp/asp.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/user_entity.dart';

final userAtom = atom<UserEntity?>(null);
final updateUser = atomAction1<UserEntity?>((set, user) => set(userAtom, user));
