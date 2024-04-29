import 'package:flutter_riverpod/flutter_riverpod.dart';

// to manage state of the radio button selected
final radioProvider = StateProvider<int>((ref) {
  return 0;
});
