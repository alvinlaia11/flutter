import 'package:flutter/material.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Detail'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Ini adalah detail Profile'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 152, 201, 224),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          'Strawberry Pavlova',
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 152, 201, 224),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          'Paviova is a meringue-based desert \nname after the Russian \nballerina Anna Pavlova, \nfeatures a erisp crust and soft, \nlight inside, \ntopped with fruit and \nwhipped cream',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 152, 201, 224),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.horizontal()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star),
                                const Icon(Icons.star),
                                const Icon(Icons.star),
                                const Icon(Icons.star),
                                const Icon(Icons.star),
                              ],
                            ),
                            Text('170 Reviews')
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 152, 201, 224),
                            border:
                                Border.all(color: Colors.black, width: 1.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    const Icon(Icons.business),
                                    Row(
                                      children: [Text('PREP'), Text(':')],
                                    ),
                                    Row(
                                      children: [
                                        Text('25 '),
                                        Text('min'),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Icon(Icons.alarm),
                                    Row(
                                      children: [Text('COOK'), Text(':')],
                                    ),
                                    Row(
                                      children: [Text('1 '), Text('hr')],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Icon(Icons.dinner_dining),
                                    Row(
                                      children: [Text("FEEDS"), Text(':')],
                                    ),
                                    Row(
                                      children: [Text('4-6')],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Image.asset(
                    'assets/img3.jpg',
                    width: 200,
                  )
                ],
              )
            ]),
      ),
    );
  }
}
