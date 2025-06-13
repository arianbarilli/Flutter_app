/*
Importa os pacotes principais do Flutter e bibliotecas do projeto.
provider: biblioteca para gerenciar estado (nesse caso, o ViewModel).
Widgets personalizados (input, botão, card, chips de cidades salvas).
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_tempo/viewmodels/weather_viewmodel.dart';
import 'package:app_tempo/widgets/search_input.dart';
import 'package:app_tempo/widgets/search_button.dart';
import 'package:app_tempo/widgets/weather_card.dart';
import 'package:app_tempo/widgets/saved_city_chip_list.dart';

/*
Tela principal do app — por ser Stateful, ela pode reagir a mudanças de estado, 
como quando o usuário digita ou clica.
*/
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
  Define o controlador do campo de texto, que será usado para capturar a cidade digitada.
  */
  final TextEditingController _controller = TextEditingController();

  /*
  build define o que será desenhado na tela.
  viewModel é recuperado via Provider para acessar os dados do clima e estado 
  (loading, cidades salvas etc.).
  */
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context);

    /*
    Define a estrutura da tela com um corpo centralizado.
    Stack permite sobrepor widgets livremente (decoração, conteúdo central etc.).
    */
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1366,
          height: 768,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFF46C8C4),
              ),
              // Decorações de canto
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 220,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  width: 220,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 220,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  width: 220,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // Conteúdo central
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Clima Tempo',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Campo de entrada customizado
                    /*
                    Widget reutilizável para digitar o nome da cidade.
                    Recebe o controlador que armazena o texto digitado.
                    */
                    SearchInput(controller: _controller),
                    const SizedBox(height: 16),

                    // Botão customizado
                    /*
                    Botão customizado para buscar o clima.
                    Ao clicar:
                    Verifica se o campo está preenchido.
                    Chama fetchWeather() no ViewModel, que buscará os dados e salvará a cidade.              
                    */
                    SearchButton(
                      onPressed: () async {
                        final city = _controller.text.trim();
                        if (city.isNotEmpty) {
                          await viewModel.fetchWeather(city);
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    // Lista de cidades salvas
                    /*
                    Exibe uma lista de chips clicáveis com as cidades salvas.
                    Ao clicar em um chip, a cidade é usada para fazer nova busca e atualizar os dados.
                    */
                    if (viewModel.savedCities.isNotEmpty)
                      SavedCityChipList(
                        cities: viewModel.savedCities,
                        onSelected: (city) async {
                          _controller.text = city;
                          await viewModel.fetchWeather(city);
                        },
                      ),

                    const SizedBox(height: 30),

                    // Resultado da pesquisa
                    /*
                    Enquanto busca o clima: mostra o spinner (CircularProgressIndicator).
                    Quando finaliza e há dados: mostra o WeatherCard, um cartão com o resultado (ícone, temperatura, clima).
                    */
                    if (viewModel.isLoading)
                      const CircularProgressIndicator()
                    else if (viewModel.weather != null)
                      WeatherCard(weather: viewModel.weather!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
