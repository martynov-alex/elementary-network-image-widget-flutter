import 'package:cached_network_image/cached_network_image.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_network_image_widget_flutter/widget/network_image_wm.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends ElementaryWidget<INetworkImageWm> {
  final String url;
  final Map<String, String>? headers;

  const NetworkImageWidget(
    this.url, {
    this.headers,
    Key? key,
    WidgetModelFactory<NetworkImageWm> wmFactory = networkImageWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(INetworkImageWm wm) {
    return ValueListenableBuilder<bool>(
      valueListenable: wm.isVisible,
      builder: (_, isVisible, __) {
        return isVisible
            ? CachedNetworkImage(
                imageUrl: url,
                httpHeaders: headers ?? wm.headers,
                placeholder: (_, __) => const _Loader(),
                errorWidget: (_, __, error) {
                  if (wm.isFirstError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      wm.onError(error);
                    });
                    return const Text('Обновление токена...');
                  }
                  return const Text(
                    'Ошибка.\nПопробуйте еще раз позже.',
                    textAlign: TextAlign.center,
                  );
                },
              )
            : const _Loader();
      },
    );
  }
}

/// Виджет лоадера при загрузке фотографии и при обновлении токенов.
class _Loader extends StatelessWidget {
  const _Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.amberAccent,
        strokeWidth: 2,
      ),
    );
  }
}
