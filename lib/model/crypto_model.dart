import 'package:hive/hive.dart';

part 'crypto_model.g.dart';

@HiveType(typeId: 0)
class Crypto {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double quantity;

  Crypto({
    required this.id,
    required this.name,
    required this.quantity,
  });
}
