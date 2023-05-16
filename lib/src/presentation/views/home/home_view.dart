import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:puntos_colombia_short_url/src/domain/models/short_url.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/clean_uri/clean_uri_cubit.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/local_short_urls/local_short_urls_cubit.dart';
import 'package:puntos_colombia_short_url/src/utils/constants/sizes.dart';
import 'package:puntos_colombia_short_url/src/utils/extensions/string.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  final inputController = TextEditingController();
  final inputKey = GlobalKey<FormFieldState>();
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CleanUriCubit, CleanUriState>(
      listener: (context, state) {
        if (state is CleanUriSuccess) {
          final shortUrl = ShortUrl(inputController.text, state.resultUrl);
          context.read<LocalShortUrlsCubit>().saveShortUrl(shortUrl: shortUrl);
        } else if (state is CleanUriError) {
          showToast(state.errorMessage);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Url Shortener')),
        body: Column(
          children: [
            Padding(
              padding: defaultPadding,
              child: TextFormField(
                key: inputKey,
                controller: inputController,
                validator: (value) => (value ?? '').isURL()
                    ? null
                    : 'La Url no tiene un formato correcto, ejemplo: https://www.google.com ',
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(),
                )),
              ),
            ),
            Expanded(
              child: BlocBuilder<LocalShortUrlsCubit, LocalShortUrlsState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case LocalShortUrlsLoading:
                      return Center(child: CircularProgressIndicator());
                    case LocalShortUrlsSuccess:
                      return ListView(
                        padding: defaultPadding / 2,
                        children: state.allUrlsHistory
                            .map((e) => Card(
                                  child: Padding(
                                    padding: defaultPadding,
                                    child: Column(children: [
                                      Text('Original:  ${e.original}'),
                                      SizedBox(height: 8.0,),
                                      Text('Short:  ${e.short}')
                                    ]),
                                  ),
                                ))
                            .toList(),
                      );
                    default:
                      return SizedBox();
                  }
                },
              ),
            ),
            Container(
              width: 200,
              height: 70,
              padding: defaultPadding,
              child: ElevatedButton(
                onPressed: () {
                  if (!inputKey.currentState!.validate() ||
                      inputController.text.isEmpty) {
                    return;
                  }
                  context
                      .read<CleanUriCubit>()
                      .shortenUrl(url: inputController.text);
                },
                child: Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
