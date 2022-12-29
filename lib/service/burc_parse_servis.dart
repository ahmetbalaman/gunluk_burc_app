import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

Future<List<String>?> getirBurclar(
    whereCameFrom, String hangi, String site) async {
  try {
    if (site == "günlük") {
      final response = await http.Client().get(Uri.parse(
          "https://www.elele.com.tr/astroloji/burclar/$whereCameFrom/$hangi"));
      if (response.statusCode == 200) {
        dynamic document = parse(response.body);
        List<String> dizi = [
          document.getElementsByTagName("strong")[0].text,
          document.getElementsByTagName("p")[hangi == "yillik" ? 1 : 0].text,
          document
              .getElementsByClassName("bg-white rounded-lg p-5 news-content")[0]
              .text,
        ];
        return dizi;
      } else {
        return null;
      }
    } else {
      final response = await http.Client().get(Uri.parse(
          "https://www.elele.com.tr/astroloji/burc-ozellikleri/$whereCameFrom/$hangi"));
      if (response.statusCode == 200) {
        dynamic document = parse(response.body.replaceAll("<br>", "\n\n"));

        List<String> dizi = [
          document.getElementsByTagName("strong")[0].text,
          document.getElementsByTagName("p")[0].text,
          document
              .getElementsByClassName("bg-white rounded-lg p-5 news-content")[0]
              .text,
        ];
        return dizi;
      } else {
        return null;
      }
    }
  } on SocketException catch (_) {
    return null;
  }
}
