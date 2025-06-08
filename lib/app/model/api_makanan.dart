import 'package:dio/dio.dart';

class ApiMakananService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> getProductData(String barcode) async {
    final String url =
        'https://id.openfoodfacts.org/api/v2/product/$barcode.json';

    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return null;
  }
}
