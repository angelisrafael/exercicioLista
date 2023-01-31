import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Lista.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Lista>> leiloes;

  @override
  void initState() {
    super.initState();
    leiloes = pegarLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista do Exercício'),
      ),
      body: Center(
        child: FutureBuilder<List<Lista>>(
          future: leiloes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Lista lista = snapshot.data![index];
                  return ListTile(
                    
                    leading: CircleAvatar(
                      child: Text(lista.id.toString()),
                    ),
                    title: Text(lista.nome!),
                    subtitle: Text(lista.lotes.toString()),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<List<Lista>> pegarLista() async {
    var url = Uri.parse('http://api.kleiloes.com.br/tipo-bem/ativos');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List listaKLeiloes = json.decode(response.body);
      return listaKLeiloes.map((json) => Lista.fromJson(json)).toList();
    } else {
      throw Exception('Erro não foi possível carregar a lista');
    }
  }
}
