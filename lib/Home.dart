import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Post.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _recuperarPostagens() async {
    final response = await http.get(Uri.parse("$_urlBase/posts"));
    if (response.statusCode == 200) {
      final List<dynamic> dadosJson = json.decode(response.body);
      return dadosJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar as postagens');
    }
  }

  Future<void> _post() async {
    final post =
        Post(userId: 120, id: 0, title: "Titulo", body: "Corpo da postagem");
    final corpo = json.encode(post.toJson());

    final response = await http.post(
      Uri.parse("$_urlBase/posts"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: corpo,
    );

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  Future<void> _put() async {
    final post =
        Post(userId: 120, id: 2, title: "Titulo", body: "Corpo da postagem");
    final corpo = json.encode(post.toJson());

    final response = await http.put(
      Uri.parse("$_urlBase/posts/2"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: corpo,
    );

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  Future<void> _patch() async {
    final post =
        Post(userId: 120, id: 2, title: "Titulo", body: "Corpo da postagem");
    final corpo = json.encode(post.toJson());

    final response = await http.patch(
      Uri.parse("$_urlBase/posts/2"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: corpo,
    );

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  Future<void> _delete() async {
    final response = await http.delete(Uri.parse("$_urlBase/posts/2"));
    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consumo de serviço avançado")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: _post,
                  child: const Text("Salvar"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _patch,
                  child: const Text("Atualizar"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _delete,
                  child: const Text("Remover"),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _recuperarPostagens(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text("Erro ao carregar os dados"));
                  } else if (snapshot.hasData) {
                    final lista = snapshot.data!;
                    return ListView.builder(
                      itemCount: lista.length,
                      itemBuilder: (context, index) {
                        final post = lista[index];
                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.id.toString()),
                        );
                      },
                    );
                  }
                  return const Center(child: Text("Nenhum dado encontrado"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
