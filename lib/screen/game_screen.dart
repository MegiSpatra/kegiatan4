import 'package:flutter/material.dart';
import 'package:kegiatan4_sore/model/game_model.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Game> listGame = [];
  _getGame() async {
    await Game.connectToApi().then((value) => listGame = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Praktikum4 - 1461900168"),
      ),
      body: FutureBuilder(
        future: _getGame(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return (snapshot.hasError)
                  ? Text('Error: ${snapshot.error}')
                  : ListView.builder(
                      itemCount: listGame.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              listGame[index].thumbnail,
                              width: 50,
                              fit: BoxFit.fill,
                            ),
                            title: Text(listGame[index].title),
                            subtitle: Text(
                                listGame[index].short_description.toString()),
                          ),
                        );
                      },
                    );
          }
        },
      ),
    );
  }
}
