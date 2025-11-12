# Flutter Advanced API Consumption

Aplicativo Flutter simples que demonstra o consumo avançado de serviços REST utilizando o pacote `http` para operações CRUD (Create, Read, Update, Delete) em uma API de posts fictícia.

## Funcionalidades

- Visualização de lista de postagens obtidas via requisição HTTP GET
- Criação de nova postagem (POST)
- Atualização parcial ou total de postagem (PATCH/PUT)
- Remoção de postagem (DELETE)
- Interface moderna utilizando widgets atualizados e null safety

## Estrutura do Projeto

- `Home`: Tela principal que lista as postagens, opera botões de ação para CRUD.
- `Post`: Modelo de dados para os posts da API, com métodos `toJson` e `fromJson`.

## Como Executar

1. Certifique-se de ter o Flutter instalado.
2. Clone o repositório:

git clone https://github.com/elielrj/requisicoes.git

3. Navegue até a pasta do projeto e instale as dependências:

flutter pub get

4. Execute o aplicativo:

flutter run


## Principais Trechos de Código

````
Future<List<Post>> _recuperarPostagens() async {
    
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    
    if (response.statusCode == 200) {
        final List<dynamic> dadosJson = json.decode(response.body);
        return dadosJson.map((json) => Post.fromJson(json)).toList();
    } else {
        throw Exception('Falha ao carregar as postagens');
    }
}````


## Pacotes Utilizados

- [Flutter](https://flutter.dev)
- [http](https://pub.dev/packages/http)

## Licença

Este projeto é livre para uso educacional e aberto a sugestões.



