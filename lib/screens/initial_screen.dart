import 'package:flutter/material.dart';
import 'package:flutter_1/components/task.dart';
import 'package:flutter_1/data/task_dao.dart';
import 'package:flutter_1/data/task_inherited.dart';
import 'package:flutter_1/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 35),
          child: Text('Metas'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            //criar tela baseado em lista de tarefas
            future: TaskDao().findAll(), //a informação será pega pelo findAll
            builder: (context, snapshot) {
              //Constrói a tela
              List<Task>? items = snapshot
                  .data; //Cria uma lista de tarefas(items) podendo ser nula, correspondente aos dados do snapshot
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ],
                    ),
                  );
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ],
                    ),
                  );
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          //Constrói diversas tarefas diferentes
                          itemCount:
                              items.length, //define quantidade de tarefas
                          itemBuilder: (BuildContext context, int index) {
                            final Task tarefa = items[index];
                            return tarefa;
                          });
                    }
                    return Center(
                      child: Column(
                        children: [
                          Icon(Icons.error_outline, size: 128),
                          Text(
                            'Não ha nenhuma tarefa',
                            style: TextStyle(fontSize: 32),
                          ),
                        ],
                      ),
                    );
                  }
                  return Text('Erro ao carregar tarefas');
                  break;
              }
              return Text('Erro desconhecido');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                taskContext: context,
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
