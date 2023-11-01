import 'package:flutter_riverpod/flutter_riverpod.dart';

final resetPassProvider = StateProvider((ref) => false);
final loadingProvider = StateProvider((ref) => false);
final errorMsgProvider = StateProvider((ref) => '');
final contactUsProvider = StateProvider((ref) => false);
