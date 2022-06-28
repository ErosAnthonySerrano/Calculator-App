
import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(CalculatorApplication());
}

class CalculatorApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator Application',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: CalculatorApp(),
    
    );
  }
}

class CalculatorApp extends StatefulWidget {
  @override
  CalculatorAppState createState() =>CalculatorAppState();
}

class CalculatorAppState extends State<CalculatorApp> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
          equation = "0";
          result = "0";
          equationFontSize = 38.0;
          resultFontSize = 48.0;
      }

      else if(buttonText == "DEL"){
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = equation.substring(0, equation.length - 1);
          if(equation == ""){
            equation = "0";
          }

      }

      else if(buttonText == "="){
          equationFontSize = 38.0;
          resultFontSize = 48.0;

          expression = equation;

          try{
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';

          }catch(e){
            result = "ERROR";
          }
      }
      
      else{
          equationFontSize = 48.0;
          resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }
        else{
        equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
                            height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
                            
                            child:  FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                color: Colors.white,
                                width: 1,
                                style: BorderStyle.solid
                                )
                                ),
                                color: buttonColor,
                                padding: EdgeInsets.all(16.0),
                                onPressed: () => buttonPressed(buttonText),
                                child: Text(
                                  buttonText,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white
                                  ),
                                ),
                            ),
                            
                          );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Calculator Application')),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget> [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize, color: Colors.white),),
          ),

            Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize, color: Colors.white),),
          ),

          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text('Created by: Eros Anthony Serrano', style: TextStyle(fontSize: 10, color: Colors.orangeAccent),),
          ),
          
          Expanded(
            child: Divider(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton("C", 1, Colors.orange.shade300),
                          buildButton("DEL", 1, Colors.teal.shade900),
                          buildButton("/", 1, Colors.tealAccent.shade700)
                        ]
                      ),

                      TableRow(
                        children: [
                          buildButton("7", 1, Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("9", 1, Colors.black54)
                        ]
                      ),

                      TableRow(
                        children: [
                          buildButton("4", 1, Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("6", 1, Colors.black54)
                        ]
                      ),

                      TableRow(
                        children: [
                          buildButton("1", 1, Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("3", 1, Colors.black54)
                        ]
                      ),

                      TableRow(
                        children: [
                          buildButton(".", 1, Colors.black54),
                          buildButton("0", 1, Colors.black54),
                          buildButton("00", 1, Colors.black54)
                        ]
                      ),

                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton("*", 1, Colors.tealAccent.shade700)
                        ]
                      ),
                      TableRow(
                        children: [
                          buildButton("-", 1, Colors.tealAccent.shade700)
                        ]
                      ),
                      TableRow(
                        children: [
                          buildButton("+", 1, Colors.tealAccent.shade700)
                        ]
                      ),
                      TableRow(
                        children: [
                          buildButton("=", 2, Colors.teal)
                        ]
                      ),
                    ],
                  ),

                )

                

              ],
            ),

        ],
        ),
    );
  }
}