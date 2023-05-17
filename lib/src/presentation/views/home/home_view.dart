import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:puntos_colombia_short_url/config/labels.dart';
import 'package:puntos_colombia_short_url/config/themes/color_schemes.dart';
import 'package:puntos_colombia_short_url/src/domain/models/short_url.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/clean_uri/clean_uri_cubit.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/local_short_urls/local_short_urls_cubit.dart';
import 'package:puntos_colombia_short_url/src/presentation/views/home/widgets/animated_button.dart';
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
        appBar: AppBar(title: Text(labels.home_title)),
        body: Column(
          children: [
            Padding(
              padding: defaultPadding,
              child: TextFormField(
                key: inputKey,
                controller: inputController,
                validator: (value) =>
                    (value ?? '').isURL() ? null : labels.input_url_error,
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
                                      SelectableText(
                                          '${labels.original} ${e.original}',style: TextStyle(fontSize: 15),),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      SelectableText.rich(
                                        TextSpan(
                                          style: TextStyle(fontSize: 15),
                                          children: [
                                            TextSpan(
                                                text: '${labels.short_url} ',
                                                style: TextStyle(
                                                    color: lightColorScheme
                                                        .primary)),
                                            TextSpan(
                                              text: '${e.short}',
                                            ),
                                          ],
                                        ),
                                      )
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
            AnimatedButton(
              onPressed: () {
                if (!inputKey.currentState!.validate() ||
                    inputController.text.isEmpty) {
                  return;
                }
                context
                    .read<CleanUriCubit>()
                    .shortenUrl(url: inputController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
