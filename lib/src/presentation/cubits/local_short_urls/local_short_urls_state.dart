part of 'local_short_urls_cubit.dart';

abstract class LocalShortUrlsState extends Equatable {
  final List<ShortUrl> allUrlsHistory;

  const LocalShortUrlsState({this.allUrlsHistory = const []});

  @override
  List<Object> get props => [allUrlsHistory];
}

class LocalShortUrlsLoading extends LocalShortUrlsState {}

class LocalShortUrlsSuccess extends LocalShortUrlsState {
  const LocalShortUrlsSuccess({super.allUrlsHistory});
}
