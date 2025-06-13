/*
Função da Classe: Esse widget personalizado representa um botão estilizado com 
o texto “Pesquisar”, que pode ser reutilizado em diferentes partes do app. Ele 
executa uma função específica toda vez que for pressionado.
*/

/*
Importa o pacote principal de componentes visuais do Flutter — necessário para 
usar widgets como ElevatedButton, Text, Colors, etc.
*/
import 'package:flutter/material.dart';

/*
Define um widget personalizado chamado SearchButton, que herda de 
StatelessWidget. Isso significa que ele não guarda estado interno — seu conteúdo
visual não muda sozinho.
*/
class SearchButton extends StatelessWidget {
  /*
  Declara uma variável chamada onPressed, do tipo VoidCallback:
  VoidCallback é o tipo usado em Flutter para funções que não têm parâmetros 
  nem retornam nada, geralmente chamadas em eventos como cliques.
  Aqui, será usada para executar uma ação quando o botão for pressionado 
  (ex: buscar dados da API).
  */
  final VoidCallback onPressed;

  /*
  Construtor da classe SearchButton:
  Recebe a função onPressed como parâmetro obrigatório.
  O super.key permite que o Flutter identifique o widget na árvore de 
  renderização (útil para performance).
  */
  const SearchButton({super.key, required this.onPressed});

  //  Método que define como esse botão será exibido na tela.
  @override
  Widget build(BuildContext context) {
    /*
    Cria um botão do tipo ElevatedButton, que tem elevação e sombra por 
    padrão — geralmente usado para ações principais.
    */
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        /*
        Estiliza o botão:
        backgroundColor: cor de fundo rosa claro.
        foregroundColor: cor do texto em branco.
        shape: formato arredondado (com bordas circulares de 28 pixels).
        padding: espaço interno horizontal e vertical (define o tamanho do botão).
        */
        backgroundColor: Colors.pink.shade300,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      ),
      /*
      Define o que acontece ao pressionar o botão. A função que foi 
      passada via parâmetro (onPressed) será chamada aqui.
      */
      onPressed: onPressed,
      //O conteúdo do botão é um texto fixo: "Pesquisar", estilizado automaticamente com a cor branca.
      child: const Text('Pesquisar'),
    );
  }
}
