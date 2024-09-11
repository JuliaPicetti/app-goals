import 'package:flutter_1/components/task.dart';
import 'package:flutter_1/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'nome';
  static const String _difficulty = 'dificuldade';
  static const String _image = 'imagem';

  save(Task tarefa) async {
    print('Iniciando o save: ');
    final Database bancoDeDados = await getDatabase(); // Abre o BD
    var itemExists = await find(
        tarefa.nome); //verifica se uma tarefa com aquele nome não existe
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      print('A tarefa não existia.');
      return await bancoDeDados.insert(_tablename,
          taskMap); //se não existe uma tarefa com um nome igual, ela será inserido no BD (em formato de mapa)
    } else {
      print('A tarefa já existia');
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.nome],
      ); // se existir tarefa com nome igual, ela será atualizada com os da
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print('Convertendo tarefa em Map: ');
    final Map<String, dynamic> mapaDetarefas = Map();
    mapaDetarefas[_name] = tarefa.nome;
    mapaDetarefas[_difficulty] = tarefa.dificuldade;
    mapaDetarefas[_image] = tarefa.foto;
    print('Mapa de Tarefas: $mapaDetarefas');
    return mapaDetarefas;
  }

  Future<List<Task>> findAll() async {
    print('Acessando o findAll');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('Convertendo to List:');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    print('Lista de Tarefas $tarefas');
    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    print('Acessando find: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?', //busca no local referente aos nomes das tarefas
      whereArgs: [
        nomeDaTarefa
      ], //onde o nome for equivalnete ao nomeDaTarefa, retorna do dado (nome pesquisado, nome existente)
    );
    print('Tarefa encontrada: ${toList(result)}');
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('Deletando tarefa: $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
      //deletando
      _tablename, //dentro da tabela
      where: '$_name = ?', //no local onde tem o nome
      whereArgs: [
        nomeDaTarefa
      ], //verificando se o nome da tarefa é igual ao nome da tarefa que é pra deletar, se sim, apaga.
    );
  }
}
