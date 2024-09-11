import 'package:flutter/material.dart';
import 'package:flutter_1/components/difficulty.dart';
import 'package:flutter_1/data/task_dao.dart';

class Task extends StatefulWidget {
  //criou uma classe
  final String nome;
  final String foto;
  final int dificuldade;

  Task(this.nome, this.foto, this.dificuldade,
      {super.key}); //construtor: identifica que a classe tem um nome e uma chave(identificação própria do flutter).
  int nivel = 0;

  @override
  State<Task> createState() => _TaskState(); //criando e nomeando o estado.
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.blue),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromARGB(255, 170, 215, 252)),
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: assetOrNetwork()
                            ? Image.asset(widget.foto, fit: BoxFit.cover)
                            : Image.network(
                                widget.foto,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.nome,
                            style: const TextStyle(
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Difficulty(
                          difficultyLevel: widget.dificuldade,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          onLongPress: () {
                            TaskDao().delete(widget.nome);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Tarefa excluída!'),
                              ),
                            );
                          },
                          onPressed: () {
                            setState(() {
                              //função que diz quem esta mudando, no caso o nível
                              widget.nivel++;
                            });
                            //print(nivel);
                          },
                          style: ButtonStyle(
                              padding: WidgetStateProperty.all(EdgeInsets.zero),
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.blue),
                              shape: WidgetStateProperty
                                  .all< //shape é a definição de forma do botão. Então você tem a propriedade de estado aplicada à (.all) todos da mesma forma.
                                          RoundedRectangleBorder>(
                                      //o arredondamento, abaixo a criação da borda e definição do raio da mesma.
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              6))) // Change button color
                              ),
                          child: const Column(
                            //só de envolver o icon com uma column, o tamanho dele se altera, pode parecer um erro, mas só é preciso que o elevatedbutton esteja envolvido por um container, e você definirá height/width para ele.
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_drop_up,
                                color: Colors.white,
                              ),
                              Text(
                                'Lvl Up',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                        8), //diz qual lado vai ser aplicado o padding, .all = todos os lados. Se for especificar, .only.
                    child: SizedBox(
                      // ignore: sort_child_properties_last
                      child: LinearProgressIndicator(
                        backgroundColor:
                            const Color.fromARGB(255, 133, 196, 248),
                        color: Colors.white,
                        value: (widget.dificuldade > 0)
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                      width: 250,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Nivel: ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
