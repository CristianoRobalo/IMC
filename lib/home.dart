import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  String _result;

  @override
  void initState() {
    super.initState();
    _resetFields();
  }

  void _resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      _result = 'Informe seus dados';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: _buildForm(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text('Calculadora de IMC'),
      centerTitle: true,
      backgroundColor: Colors.black45,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () => _resetFields(),
        ),
      ],
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTextFormField(
            label: 'Peso:',
            error: 'Peso (Kg)',
            controller: _weightController,
          ),
          _buildTextFormField(
            label: 'Altura:',
            error: 'Altura (m)',
            controller: _heightController,
          ),
          _buildTextResult(),
          _buildCalculateButton(),
        ],
      ),
    );
  }

  _buildTextFormField(
      {String label, String error, TextEditingController controller}) {
        return TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: label),
          controller: controller,
          validator: (text) {
            if (text.isEmpty) return '$error inválido.';
            else if (double.parse(text) <= 0) return '$error não pode ser menor ou igual a zero.';
            return null;
          },
        );
      }

  _buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.center,
      ),
    );
  }

  _buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _calculateImc();
          }
        },
        child: Text(
          'Calcular',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.black26,
      ),
    );
  }

  void _calculateImc() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text);
    double imc = weight / (height * height);
    
    setState(() {
      _result = 'IMC = ${imc.toStringAsPrecision(2)}\n';
      
      if (imc < 16) _result += 'Magreza grave';
      else if (imc > 16 && imc < 17) _result += 'Magreza moderada';
      else if (imc > 17 && imc < 18.5) _result += 'Magreza leve';
      else if (imc > 18.5 && imc < 25) _result += 'Saudável';
      else if (imc > 25 && imc < 30) _result += 'Sobrepeso';
      else if (imc > 30 && imc < 35) _result += 'Obesidade grau I';
      else if (imc > 35 && imc < 40) _result += 'Obesidade grau II (severa)';
      else if (imc >= 40) _result += 'Obesidade grau III (mórbida)';
    });
  }
  
}
