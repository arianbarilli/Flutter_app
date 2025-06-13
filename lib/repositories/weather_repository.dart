/* A classe WeatherRepository faz parte da camada de repositório (Repository 
Layer) do padrão de arquitetura MVVM. Ela atua como intermediária entre a camada
 de serviços (que acessa a internet) e a camada de ViewModel (que controla a 
 lógica de exibição).
*/

/*
weather_model.dart: o modelo Weather que define como os dados do clima são 
armazenados.
*/
/*
weather_service.dart: classe que faz a requisição HTTP para a API do tempo 
(ex: OpenWeather).
*/
import 'package:app_tempo/models/weather_model.dart';
import 'package:app_tempo/services/weather_service.dart';

/* 
Cria a classe WeatherRepository, que será usada para centralizar o acesso 
aos dados do clima, separando a lógica de requisição da lógica de apresentação.
*/
class WeatherRepository {
  /* 
  Cria um atributo privado chamado _weatherService que representa o 
  serviço responsável por fazer chamadas HTTP para buscar os dados do clima.
  */
  final WeatherService _weatherService;

  /*
  Construtor com injeção de dependência opcional:
  Permite criar a classe WeatherRepository passando ou não um WeatherService.
  Se nenhum serviço for informado, ele cria um novo WeatherService() por padrão.
  Isso facilita testes, porque podemos injetar um WeatherService fake (mock) 
  durante os testes unitários.
  */
  WeatherRepository({WeatherService? service})
    : _weatherService = service ?? WeatherService();

  /*
  Esta é a função principal da classe:
  Chamada fetchWeather, recebe o nome da cidade.
  Usa o _weatherService para buscar o clima da cidade via API (getWeather).
  Retorna um objeto do tipo Weather (modelo com cidade, temperatura e 
  descrição).
  */
  Future<Weather> fetchWeather(String city) async {
    return await _weatherService.getWeather(city);
  }
}

/* Resumo geral:
Componente
WeatherRepository
Responsável por encapsular o acesso ao serviço da API e 
oferecer um ponto de consulta de dados para a ViewModel.

fetchWeather(city)	
Executa a busca do clima usando o WeatherService e devolve um modelo Weather.

Construtor com ??	
Permite usar injeção de dependência (usar um mock em testes, por exemplo) 
ou criar um novo serviço padrão se nenhum for passado.*/
