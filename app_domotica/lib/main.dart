import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'package:http/http.dart' as http;

void main()
{
  runApp( MyApp() );
}

class MyApp extends StatelessWidget{
  
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        appBar: AppBar( 
            title: Text('CONTROLE DA CASA'),         
         ),
         body: Center(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [ 
              TextField( 
                  decoration: InputDecoration(
                    hintText: "Digite seu nome",
                  ),
               ),
               LargeButton(
                  buttonText: 'LAMPÂDAS EXTERNAS',
                  buttonColor: Colors.red,
               ),
               LargeButton(
                  buttonText: 'LAMPÂDAS INTERNAS',
                  buttonColor: Colors.blue,
               ),
               LargeButton(
                  buttonText: 'AR CONDICIONADO',
                  buttonColor: Colors.orange,
               ),
               LargeButton(
                  buttonText: 'PORTÃO',
                  buttonColor: Colors.green,
               ),
             ],
           ),
          ),
       ),
     ); 
  } // função para definir o contexto, estrutura do App
} // fim da classe MyApp, era Asdrubal mas esse nome fica estranho

class LargeButton extends StatelessWidget
{
    final String buttonText;
    final Color buttonColor;

    const LargeButton(
      {
        required this.buttonText,
        required this.buttonColor
      }
    );
    Widget build(BuildContext context)
    {
      return ElevatedButton(
        onPressed: () => sendCommand('/acender'),

        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
                                  buttonColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0)
          )
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0),
        ),
        );
    }

    void sendCommand(String command) async 
    {
        final String serverIp = '192.168.3.21';
        final url = Uri.http(serverIp, command);
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          print('Comando enviado com sucesso');
        } else {
          print('Erro ao enviar comando');
        }
      } catch (e) {
        print('Erro: $e');
      } // fim do catch
  } // fim do método sendCommand
} // fim da classe LargeButton