/*
Função da Classe: Esse widget tem a função de exibir uma lista de 
cidades salvas (em forma de botões chamados "Chips") que o usuário pode 
clicar para selecionar uma cidade já pesquisada.
É uma parte visual reutilizável do seu app.
*/

/*
 Importa os componentes de interface do Flutter, necessários para construir a 
 tela (por exemplo: Wrap, Text, ActionChip, etc.).
*/
import 'package:flutter/material.dart';

/*
Define um widget personalizado chamado SavedCityChipList, que herda de 
StatelessWidget (não guarda estado interno).
*/
class SavedCityChipList extends StatelessWidget {
  /*
  Define dois parâmetros obrigatórios:
  cities: lista de nomes de cidades (ex: ['Passo Fundo', 'São Paulo'])).
  onSelected: função que será chamada quando o usuário clicar em uma cidade. 
  Ela recebe o nome da cidade como argumento.
  */
  final List<String> cities;
  final Function(String) onSelected;

  /*Construtor da classe. Usa parâmetros nomeados e marca como required os dois 
  campos (cities e onSelected).*/
  const SavedCityChipList({
    super.key,
    required this.cities,
    required this.onSelected,
  });

  //Método obrigatório do StatelessWidget que retorna a interface visual (UI) do widget.
  @override
  Widget build(BuildContext context) {
    /*Usa o widget Wrap, que organiza os chips como blocos flexíveis 
    (semelhante a "quebrar linha automática"). spacing: 8 define o espaço 
    entre os chips.*/
    return Wrap(
      spacing: 8,
      // Para cada cidade da lista, cria um componente visual (um chip).
      children:
          cities.map((city) {
            /*
            Cria um ActionChip:
            label: exibe o nome da cidade.
            onPressed: ao clicar, chama a função onSelected passando a cidade 
            selecionada como argumento.
            */
            return ActionChip(
              label: Text(city),
              onPressed: () => onSelected(city),
            );
            //Fecha o map e converte os resultados em uma lista de widgets, usada como filhos do Wrap.
          }).toList(),
    );
  }
}
