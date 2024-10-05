import 'package:equatable/equatable.dart';

class Emoji extends Equatable {
  final int? id;
  final String? name;
  final String? src;

  const Emoji({
    this.id,
    this.name,
    this.src,
  });

  Emoji copyWith({
    int? id,
    String? name,
    String? src,
  }) {
    return Emoji(
      id: id ?? this.id,
      name: name ?? this.name,
      src: src ?? this.src,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'src': src,
    };
  }

  static Emoji fromJson(Map<String, Object?> json) {
    return Emoji(
      id: json['id'] == null ? null : json['id'] as int,
      name: json['name'] == null ? null : json['name'] as String,
      src: json['src'] == null ? null : json['src'] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        src,
      ];

  @override
  bool get stringify => true;
}
