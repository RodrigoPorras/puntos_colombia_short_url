part of 'clean_uri_cubit.dart';

abstract class CleanUriState extends Equatable {
  final String resultUrl;

  const CleanUriState({this.resultUrl = ''});

  @override
  List<Object> get props => [resultUrl];
}

class CleanUriLoading extends CleanUriState {}

class CleanUriInit extends CleanUriState {}

class CleanUriSuccess extends CleanUriState {
  const CleanUriSuccess({super.resultUrl});
}

class CleanUriError extends CleanUriState {
  final String errorMessage;

  const CleanUriError({required this.errorMessage});
}
