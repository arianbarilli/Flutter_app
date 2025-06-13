/* 
Função da classe: Responsável por fazer a requisição HTTP à API do OpenWeather, 
transformar a resposta JSON em um modelo Weather e retornar para o restante do 
app.
*/

/*
Importa a biblioteca padrão do Dart para converter texto JSON em objetos Dart 
com json.decode.
*/
import 'dart:convert';
/*
Importa a biblioteca http (do pacote http) para realizar requisições à internet.
  O as http permite usar http.get() com esse prefixo.
*/
import 'package:http/http.dart' as http;
/*
Importa a classe Weather, que é o modelo usado para representar os dados do 
clima (cidade, temperatura e descrição).*/
import 'package:app_tempo/models/weather_model.dart';

/*
Define a classe WeatherService, que será responsável por fazer o acesso remoto 
à API de clima.
*/
class WeatherService {
  /*
   Armazena a chave de API do OpenWeather. 
   Essa chave permite que seu app se autentique para fazer requisições.
  */
  final String _apiKey = '806ea9d63ea8349e2ff35089b9f6e35c';
  /*
  Armazena a URL base do endpoint de clima da API do OpenWeather.
  */
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  /*
  Função assíncrona que recebe o nome da cidade e retorna um objeto Weather.
    É Future<Weather> porque espera uma resposta futura da API.
  */
  Future<Weather> getWeather(String cityName) async {
    /*
     Monta a URL completa da requisição:
     q=...: nome da cidade.
     appid=...: a chave de API.
     units=metric: para mostrar temperatura em Celsius.
     lang=pt_br: idioma português para descrição do clima.
     Uri.encodeComponent evita erros com acentos e espaços no nome da cidade.
    */
    final url =
        '$_baseUrl?q=${Uri.encodeComponent(cityName)}&appid=$_apiKey&units=metric&lang=pt_br';
    /*
    Envia a requisição GET para a API usando a URL montada, e espera a resposta 
    (await).
    */
    final response = await http.get(Uri.parse(url));

    //Verifica se a resposta foi bem-sucedida (200 OK)
    if (response.statusCode == 200) {
      /*
      Converte a resposta (que vem em JSON como texto) para um objeto Map em 
      Dart (Map<String, dynamic>)
      */
      final jsonData = json.decode(response.body);
      /*
      Usa o método fromJson da classe Weather para converter o JSON em um 
      objeto Weather com as informações de cidade, temperatura e descrição.
      */
      return Weather.fromJson(jsonData);
    } else {
      //Caso a resposta não seja 200, lança uma exceção com mensagem de erro.
      throw Exception('Erro ao buscar clima');
    }
  }
}
