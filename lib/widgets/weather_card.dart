/*
Esse widget é responsável por exibir as informações do clima em um cartão 
estilizado. Ele mostra: Ícone do clima, Nome da cidade, Temperatura, Descrição 
do clima
*/

/*
flutter/material.dart: importa os componentes visuais padrão do Flutter 
(como Container, Text, Icon, etc.).
weather_model.dart: importa a classe Weather, que contém os dados que 
serão exibidos no card.
*/
import 'package:flutter/material.dart';
import 'package:app_tempo/models/weather_model.dart';

/*
WeatherCard: é um widget do tipo StatelessWidget, ou seja, ele não muda seu
estado durante a execução.
final Weather weather: recebe os dados climáticos como parâmetro (nome da 
cidade, temperatura, descrição).
O required exige que esses dados sejam fornecidos ao usar o WeatherCard.
*/
class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  // Método responsável por construir e retornar a interface do card.
  @override
  Widget build(BuildContext context) {
    /*
    Com base na temperatura:
    Se for acima de 30°C → sol ☀️ (wb_sunny)
    Se for abaixo de 15°C → neve ❄️ (ac_unit)
    Caso contrário → nublado ☁️ (wb_cloudy
    */
    IconData icon =
        weather.temperature > 30
            ? Icons.wb_sunny
            : weather.temperature < 15
            ? Icons.ac_unit
            : Icons.wb_cloudy;

    return Container(
      width: 350,
      padding: const EdgeInsets.all(16),
      /*
      BoxDecoration: define a aparência do card.
      color: branco com opacidade de 90%.
      borderRadius: cantos arredondados com raio de 16.
      */
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.9 * 255).round()),
        borderRadius: BorderRadius.circular(16),
      ),
      /*
      Utiliza um Column para empilhar os elementos verticalmente.
      crossAxisAlignment.start: alinha os itens à esquerda.
      */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*
          Cria uma linha (Row) com:
          Um ícone baseado na temperatura
          Espaço (SizedBox)
          Texto "Condições atuais" em negrito
          */
          Row(
            children: [
              Icon(icon, color: Colors.blue, size: 32),
              const SizedBox(width: 12),
              const Text(
                'Condições atuais:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          /*
          Exibe a cidade:
          "Cidade: " em negrito
          Nome real da cidade em seguida
          */
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Cidade: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: weather.cityName),
              ],
            ),
          ),
          //Mostra a temperatura arredondada (sem casa decimal), com o texto "Temperatura: " em negrito.
          const SizedBox(height: 6),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Temperatura: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '${weather.temperature.round()} °C'),
              ],
            ),
          ),
          //Exibe a descrição do clima (ex: "céu limpo", "nublado", etc.) com o texto "Clima: " em negrito.
          const SizedBox(height: 6),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Clima: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: weather.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
