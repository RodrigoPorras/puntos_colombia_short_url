import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:puntos_colombia_short_url/src/domain/models/repositories/clean_uri_api_repository.dart';
import 'package:puntos_colombia_short_url/src/utils/resources/data_state.dart';

part 'clean_uri_state.dart';

class CleanUriCubit extends Cubit<CleanUriState> {
  final CleanUriApiRepository _cleanUriApiRepository;

  CleanUriCubit(this._cleanUriApiRepository) : super(CleanUriLoading());

  Future<void> shortenUrl({required String url}) async {
    final response = await _cleanUriApiRepository.shortenUrl(url: url);

    if (response is DataSuccess) {
      emit(CleanUriSuccess(resultUrl: response.data?.resulUrl ?? ''));
    } else if (response is DataFailed) {
      emit(CleanUriError(
          errorMessage: response.error?.message ?? 'Uknown Error'));
    }
  }
}
