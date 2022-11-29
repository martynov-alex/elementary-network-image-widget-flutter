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
            ? Image.network(
                url,
                headers: headers ?? wm.headers,
                errorBuilder: (_, Object e, ___) {
                  if (wm.isFirstError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      wm.onError(e);
                    });
                    return const Text('Обновление токена...');
                  }
                  return const Text(
                    'Ошибка.\nПопробуйте еще раз позже.',
                    textAlign: TextAlign.center,
                  );
                },
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
