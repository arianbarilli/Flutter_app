/*
Esse componente (SearchInput) é um widget personalizado do tipo campo de texto 
(TextField), criado para o usuário digitar o nome da cidade. Ele vem com estilo 
e controle embutidos.
*/

/*
Importa a biblioteca principal do Flutter, necessária para usar widgets 
visuais como TextField, Container, Text, BoxDecoration, etc.
*/
import 'package:flutter/material.dart';

/*
Cria um widget chamado SearchInput. Ele estende StatelessWidget, o que 
significa que não armazena estado interno — seu conteúdo depende apenas dos 
dados que recebe.
*/
class SearchInput extends StatelessWidget {
  /*
  Declara uma variável chamada controller do tipo TextEditingController.
  Essa variável serve para controlar o texto digitado no campo — é usada para 
  ler, alterar ou limpar o conteúdo do TextField.
  */
  final TextEditingController controller;

  /*
  Construtor da classe:
  Permite passar o controller quando o widget é criado.
  O parâmetro required obriga que o controller seja informado.
  O super.key é padrão em widgets e ajuda o Flutter a otimizar a reconstrução 
  do widget na interface.
  */
  const SearchInput({super.key, required this.controller});

  //Método obrigatório em todo widget. Ele retorna o layout que será desenhado na tela.
  @override
  Widget build(BuildContext context) {
    /*
    Define um Container com:
    Largura de 340px (fixa).
    Padding interno horizontal de 16px (espaço entre a borda e o conteúdo).
    */
    return Container(
      width: 340,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      /*
      Aplica uma decoração ao Container:
      Cor de fundo: amarelo bem claro (shade100).
      Bordas arredondadas com raio de 28px.
      */
      decoration: BoxDecoration(
        color: Colors.yellow.shade100,
        borderRadius: BorderRadius.circular(28),
      ),
      // Adiciona um campo de texto (TextField) dentro do container.
      child: TextField(
        /*Vincula o campo de texto ao TextEditingController que foi passado 
        ao widget. Isso permite capturar o texto que o usuário digita.*/
        controller: controller,
        /*
        Define a aparência interna do campo:
        hintText: texto cinza que aparece como dica enquanto o usuário ainda não digitou nada.
        InputBorder.none: remove as bordas padrão do campo para combinar com o visual customizado.
        */
        decoration: const InputDecoration(
          hintText: 'Digite a cidade que tem interesse',
          border: InputBorder.none,
        ),
        // Centraliza o texto digitado horizontalmente dentro do campo.
        textAlign: TextAlign.center,
      ),
    );
  }
}
