
import 'dart:io' show HttpStatus;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:puntos_colombia_short_url/src/utils/resources/data_state.dart';
import 'package:retrofit/retrofit.dart';

abstract class BaseApiRepository {
  @protected
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        throw DioError(
          error: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        );
      }
    } on DioError catch (error) {
      return DataFailed(error);
    }
  }
}