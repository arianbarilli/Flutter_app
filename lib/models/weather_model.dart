/* Define uma classe chamada Weather, que é usada para representar os dados 
climáticos de uma cidade no aplicativo.
*/
class Weather {
  /*
  Declara três propriedades que armazenam informações sobre o clima:
  * cityName: nome da cidade, temperature: temperatura atual, description: situação do clima
  Essas variáveis são final, ou seja, não podem ser alteradas depois de definidas (imutáveis).
  */
  final String cityName;
  final double temperature;
  final String description;

  /*
  Construtor da classe Weather. 
  Ele permite criar um objeto Weather passando os três campos obrigatórios:
  * cityName, temperature, description
  O required indica que esses valores devem ser fornecidos obrigatoriamente ao criar o objeto.
  */
  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  /*
  Esse é um construtor de fábrica (factory), muito usado quando se precisa criar
  um objeto a partir de dados externos — neste caso, um JSON recebido da API de clima.
  A função recebe um Map<String, dynamic> chamado json, que é como os dados vêm da internet.
  */
  factory Weather.fromJson(Map<String, dynamic> json) {
    /*
    Aqui, ele extrai os dados certos do JSON e os envia para o construtor Weather:
    json['name']: pega o nome da cidade.
    json['main']['temp'].toDouble(): pega a temperatura atual e converte para double.
    json['weather'][0]['description']: pega a descrição textual do clima (como "céu limpo", "nublado").
    Esses valores são usados para criar um objeto Weather completo com os dados da resposta da API.
    */
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}

/* Resumo geral:
Esta classe representa um modelo de dados do clima.
Tem 3 atributos principais.
Permite criar objetos manualmente ou automaticamente a partir de um JSON, usando o método fromJson
*/
