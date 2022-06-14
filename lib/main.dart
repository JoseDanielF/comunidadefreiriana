import 'app.dart' show App;
import 'package:comunidadefreiriana/screens/cadastro/cadastro_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => CadastroController(),
      ),
    ],
    child: const App(),
  ));
}
