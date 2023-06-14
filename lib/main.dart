import "package:flutter/material.dart";

void main() {
  runApp(const MaterialApp(
    title: "Calculadora IMC",
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';

    setState(() {
      _infoText = "Informe seus dados";
      
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText =
            "Levemente acima do peso do Peso ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                //---Botão de Resete ---//
                _resetFields();
                //---------------------//
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white10,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outlined,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                  // Peso
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Peso (kg)"),
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25),
                  controller: weightController, //<- Controlador Weight
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira seu Peso !";
                    }
                  }),
              TextFormField(
                //Altura
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Altura (cm)"),
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25),
                controller: heightController, //<- Controlador Height
                validator: (value) {
                  if (value!.isEmpty) {
                    return "insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    // <------ BOTÃO
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _calculate();
                      }
                    }, //<-- Função calcular
                    child: Text('Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText, // <- Variavei String Info
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
