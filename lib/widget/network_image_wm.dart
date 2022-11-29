import 'package:elementary/elementary.dart';
import 'package:elementary_network_image_widget_flutter/widget/network_image_widget.dart';
import 'package:flutter/material.dart';

abstract class INetworkImageWm extends IWidgetModel {
  /// Показывать ли виджет с картинкой.
  ValueNotifier<bool> get isVisible;

  /// Заголовки для передачи в Image виджет.
  Map<String, String> get headers;

  /// Проверка на циклическую ошибку.
  bool get isFirstError;

  /// Коллбэк, который вызывается при ошибке.
  void onError(Object e);
}

class NetworkImageWm extends WidgetModel<NetworkImageWidget, NetworkImageModel>
    implements INetworkImageWm {
  @override
  ValueNotifier<bool> get isVisible => _isVisible;

  @override
  Map<String, String> get headers => _headers;

  @override
  bool get isFirstError => _isFirstError;

  final _isVisible = ValueNotifier(false);
  final _headers = <String, String>{};
  bool _isFirstError = true;

  NetworkImageWm(NetworkImageModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  @override
  void onError(Object e) {
    if (e is NetworkImageLoadException) {
      debugPrint('Loading error. Status code ${e.statusCode}');
      _refreshToken();
    }
    _isFirstError = false;
  }

  @override
  void dispose() {
    _isVisible.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    await _getHeaders();
  }

  Future<void> _getHeaders() async {
    // Get and set headers
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('Load headers');

    _isVisible.value = true;
  }

  Future<void> _refreshToken() async {
    _isVisible.value = false;

    // Refresh token
    await Future.delayed(const Duration(seconds: 3));
    debugPrint('Refresh token');

    _isVisible.value = true;
  }
}

class NetworkImageModel extends ElementaryModel {}

NetworkImageWm networkImageWmFactory(BuildContext context) {
  final model = NetworkImageModel();
  return NetworkImageWm(model);
}
