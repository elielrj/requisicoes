import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:requisicoes/Home.dart';
import 'package:requisicoes/Post.dart';

void main() {
  test('Post toJson e fromJson funcionam', () {
    final post = Post(userId: 1, id: 2, title: 'Teste', body: 'Corpo');
    final json = post.toJson();
    expect(json['userId'], 1);
    expect(json['id'], 2);
    expect(json['title'], 'Teste');
    expect(json['body'], 'Corpo');

    final novoPost = Post.fromJson(json);
    expect(novoPost.userId, 1);
    expect(novoPost.id, 2);
    expect(novoPost.title, 'Teste');
    expect(novoPost.body, 'Corpo');
  });

  testWidgets('Home exibe botão de salvar', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));
    expect(find.text('Salvar'), findsOneWidget);
  });

  // Adicione mais testes para a UI e lógica conforme a evolução do código.
}
