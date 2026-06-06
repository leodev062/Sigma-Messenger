// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationResponseWrapper _$RegistrationResponseWrapperFromJson(
  Map<String, dynamic> json,
) => RegistrationResponseWrapper(
  status: json['status'] as String,
  data: RegistrationSessionResponse.fromJson(
    json['data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$RegistrationResponseWrapperToJson(
  RegistrationResponseWrapper instance,
) => <String, dynamic>{'status': instance.status, 'data': instance.data};

CreateAccountResponseWrapper _$CreateAccountResponseWrapperFromJson(
  Map<String, dynamic> json,
) => CreateAccountResponseWrapper(
  status: json['status'] as String,
  data: CreateAccountResponse.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateAccountResponseWrapperToJson(
  CreateAccountResponseWrapper instance,
) => <String, dynamic>{'status': instance.status, 'data': instance.data};

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main,avoid_redundant_argument_values

class _RegistrationService implements RegistrationService {
  _RegistrationService(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<RegistrationResponseWrapper> createRegistrationSession(
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _options = _setStreamType<RegistrationResponseWrapper>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'v2/registration/session',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late RegistrationResponseWrapper _value;
    try {
      _value = RegistrationResponseWrapper.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<RegistrationResponseWrapper> getRegistrationSession(
    String sessionId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<RegistrationResponseWrapper>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'v2/registration/session/${sessionId}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late RegistrationResponseWrapper _value;
    try {
      _value = RegistrationResponseWrapper.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<RegistrationResponseWrapper> requestSmsVerificationCode(
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _options = _setStreamType<RegistrationResponseWrapper>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'v2/registration/send-code',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late RegistrationResponseWrapper _value;
    try {
      _value = RegistrationResponseWrapper.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<RegistrationResponseWrapper> verifyAccount(
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _options = _setStreamType<RegistrationResponseWrapper>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'v2/registration/check-code',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late RegistrationResponseWrapper _value;
    try {
      _value = RegistrationResponseWrapper.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<CreateAccountResponseWrapper> registerAccount(
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _options = _setStreamType<CreateAccountResponseWrapper>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'v2/registration/create-account',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late CreateAccountResponseWrapper _value;
    try {
      _value = CreateAccountResponseWrapper.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on
