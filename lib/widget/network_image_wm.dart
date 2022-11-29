import 'dart:io';

import 'package:elementary/elementary.dart';
import 'package:elementary_network_image_widget_flutter/widget/network_image_widget.dart';
import 'package:flutter/material.dart';

abstract class INetworkImageWm extends IWidgetModel {
  ValueNotifier<bool> get isVisible;
  Map<String, String> get headers;
  String get testUrl;
  void onError(Object e);
}

class NetworkImageWm extends WidgetModel<NetworkImageWidget, NetworkImageModel>
    implements INetworkImageWm {
  @override
  ValueNotifier<bool> get isVisible => _isVisible;

  @override
  Map<String, String> get headers => _headers;

  @override
  String get testUrl => _testUrl;

  final _isVisible = ValueNotifier(false);
  final _headers = <String, String>{};
  String _testUrl = 'https://i.ibb.co/jgkB4ZN1/Elementary-Logo.png';

  NetworkImageWm(NetworkImageModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  @override
  void onError(Object e) {
    if (e is NetworkImageLoadException) {
      debugPrint('Status code ${e.statusCode}');
      _refreshToken();
    }
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
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('Refresh token');

    _testUrl = 'https://i.ibb.co/jgkB4ZN/Elementary-Logo.png';
    _isVisible.value = true;
  }
}

class NetworkImageModel extends ElementaryModel {}

NetworkImageWm networkImageWmFactory(BuildContext context) {
  final model = NetworkImageModel();
  return NetworkImageWm(model);
}
