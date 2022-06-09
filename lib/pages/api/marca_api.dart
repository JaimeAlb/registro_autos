import 'package:http/http.dart' as http;
import 'dart:convert';

class Marca {
  final String name;

  const Marca({
    required this.name,
  });

  static Marca fromJson(Map<String, dynamic> json) => Marca(
        name: json['Marcas1'],
      );
}

class UserApi {
  static Future<List<Marca>> getUserSuggestions(String query) async {
    final url = Uri.parse('https://localhost:44337/api/Marcas');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List marcas = json.decode(response.body);

      return marcas.map((json) => Marca.fromJson(json)).where((marca) {
        final marcaLower = marca.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return marcaLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
