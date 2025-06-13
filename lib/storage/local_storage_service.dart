/*
Essa classe é responsável por salvar e recuperar as cidades pesquisadas 
localmente no dispositivo do usuário, usando o pacote shared_preferences, que 
permite armazenar dados simples em cache (como strings, números e listas).
*/

/*
 Importa o pacote shared_preferences, que permite salvar dados localmente como 
 se fosse um "banco de dados chave-valor" simples. Muito usado para guardar 
 configurações e pequenas listas
*/
import 'package:shared_preferences/shared_preferences.dart';

/*
Define a classe LocalStorageService, que centraliza o acesso ao armazenamento 
local para guardar e recuperar as cidades pesquisadas.
*/
class LocalStorageService {
  /*
  Essa função retorna uma lista de strings (cidades) que foram salvas 
  anteriormente. Como o acesso ao armazenamento local é assíncrono, ela retorna 
  um Future<List<String>>
  */
  Future<List<String>> getSavedCities() async {
    // Recupera a instância de SharedPreferences, necessária para acessar o armazenamento local.
    final prefs = await SharedPreferences.getInstance();
    // Tenta recuperar a lista salva com a chave 'cities'.
    // Se não houver nenhuma cidade salva ainda, retorna uma lista vazia ([]).
    return prefs.getStringList('cities') ?? [];
  }

  // Essa função salva uma nova cidade na lista de cidades, se ela ainda não estiver salva.
  Future<void> saveCity(String city) async {
    // Pega a instância do armazenamento local, como antes.
    final prefs = await SharedPreferences.getInstance();
    //Lê a lista atual de cidades salvas. Se estiver vazia (primeiro uso), cria uma lista nova.
    final cities = prefs.getStringList('cities') ?? [];
    //Verifica se a cidade já está salva. Isso evita duplicação.
    if (!cities.contains(city)) {
      // Adiciona a nova cidade à lista.
      cities.add(city);
      //Atualiza a lista no SharedPreferences, sobrescrevendo o valor da chave 'cities' com a nova lista.
      await prefs.setStringList('cities', cities);
    }
  }
}
