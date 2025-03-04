import 'package:dio/dio.dart';

final dio = Dio(baseOptions);

BaseOptions baseOptions = BaseOptions(
  // baseUrl: 'https://jsonplaceholder.typicode.com',
  baseUrl: 'https://test-backend-flutter.surfstudio.ru',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
  sendTimeout: const Duration(seconds: 5),
  responseType: ResponseType.json,
  headers: {
    'device-info': 'Nokia 3310 OS 14',
  },
);

Future<dynamic> getPosts() async {
  initInterceptors();
  final postResponse = await dio.get(
    '/posts',
/*     queryParameters: {
      'id': 1,
    }, */
  );

  if (postResponse.statusCode == 200) {
    return postResponse.data;
  }

  throw Exception(
    'error code ${postResponse.statusCode}',
  );
}

Future<dynamic> createPost() async {
  initInterceptors();
  final postResponse = await dio.post(
    '/posts',
    queryParameters: {
      'title': 'title',
      'body': 'body',
      'userId': '1',
    },
  );

  if (postResponse.statusCode == 201) {
    return postResponse.data;
  }

  throw Exception(
    'error code ${postResponse.statusCode}',
  );
}

void initInterceptors() {
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (e, handler) {
        print('error: $e.message');
        handler.next(e);
      },
      onRequest: (r, handler) {
        print('request sent');
        print(r.method);
        print(r.path);
        handler.next(r);
      },
      onResponse: (r, handler) {
        print('response received');
        print(r.data);
        handler.next(r);
      },
    ),
  );
}
