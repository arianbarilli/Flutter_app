/*
flutter/material.dart: Permite usar componentes e estrutura do Flutter.
local_storage_service.dart: Responsável por salvar e recuperar as cidades no 
armazenamento local (SharedPreferences).
weather_model.dart: Modelo de dados que representa o clima.
weather_repository.dart: Camada de repositório que centraliza o acesso à API de clima.
*/
import 'package:flutter/material.dart';
import 'package:app_tempo/storage/local_storage_service.dart';
import 'package:app_tempo/models/weather_model.dart';
import 'package:app_tempo/repositories/weather_repository.dart';

/*
Esta classe estende ChangeNotifier, o que permite notificar a interface 
gráfica (UI) sempre que houver mudanças nos dados.
*/
class WeatherViewModel extends ChangeNotifier {
  /*
  repository: instância que permite buscar dados do clima via API.
  _weather: armazena os dados do clima da cidade pesquisada.
  _isLoading: indica se a requisição está em andamento.
  _savedCities: lista de cidades já pesquisadas.
  */
  final WeatherRepository repository;

  Weather? _weather;
  bool _isLoading = false;
  List<String> _savedCities = [];

  /*
  Permitem que a interface acesse os dados internos do ViewModel sem permitir 
  alterações diretas, mantendo o encapsulamento.
  */
  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  List<String> get savedCities => _savedCities;

  /*
  * Recebe o repository como dependência.
     Chama loadSavedCities() ao iniciar, carregando as cidades salvas do armazenamento local.
  */
  WeatherViewModel({required this.repository}) {
    loadSavedCities();
  }

  //Ao iniciar a busca, define _isLoading = true e notifica a UI para mostrar um loading.
  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    /*
    Tenta buscar os dados da cidade usando o repositório.
    Se obtido com sucesso:
    Salva a cidade pesquisada no armazenamento local.
    Atualiza a lista de cidades salvas.
    Se falhar: zera o clima atual.
    */
    try {
      _weather = await repository.fetchWeather(city);
      await LocalStorageService().saveCity(city);
      await loadSavedCities();
    } catch (e) {
      _weather = null;
    }

    // Marca como carregamento finalizado e atualiza a interface.
    _isLoading = false;
    notifyListeners();
  }

  /*
  Lê do armazenamento local a lista de cidades salvas.
    Notifica a interface para atualizar a lista visível.
  */
  Future<void> loadSavedCities() async {
    _savedCities = await LocalStorageService().getSavedCities();
    notifyListeners();
  }
}
