import 'package:comunidadefreiriana/core/api.dart';
import 'package:comunidadefreiriana/core/models/cadastro_model.dart';
// ignore: unused_import
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapsRepository extends ChangeNotifier {
  // ignore: unused_field
  final _api = Api();
  bool isLoading = false;

  Future loadInst(BuildContext context) async {
    isLoading = true;
    _api.getInstituition(context).then((value) {
      isLoading = false;
      if (value != null) {
        CadastroModel(
          nome: value['nome'],
          telefone: value['telefone'],
          email: value['email'],
          cidade: value['cidade'],
          estado: value['estado'],
          endereco: value['endereco'],
          dataRealizacao: value['dataRealizacao'],
          nomeRealizacao: value['nomeRealizacao'],
          info: value['info'],
          latitute: value['latitute'],
          longitude: value['longitude'],
        );
      } else {
        //print('Deu Ruim');
      }
    });
  }

  final List<CadastroModel> _cadastro = [
    CadastroModel(
      nome: '',
      telefone: '',
      email: '',
      cidade: '',
      estado: '',
      endereco: '',
      dataRealizacao: '',
      nomeRealizacao: '',
      info: '',
      latitute: -8.830792865216544,
      longitude: -36.00806761533022,
    )
  ];

  List<CadastroModel> get cadastromodel => _cadastro;
}
