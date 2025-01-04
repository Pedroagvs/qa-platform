import 'package:asp/asp.dart';

final msgAtom = atom<String>('');

void updateMsg = atomAction1((set, String newMsg) {
  set(msgAtom, newMsg);
});
