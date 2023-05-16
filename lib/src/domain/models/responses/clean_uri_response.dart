import 'package:equatable/equatable.dart';

class CleanUriResponse extends Equatable {
  final String resulUrl;

  const CleanUriResponse({
    required this.resulUrl,
  });

  factory CleanUriResponse.fromMap(Map<String, dynamic> map) {
    return CleanUriResponse(
      resulUrl: (map['result_url'] ?? '') as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [resulUrl];
}
