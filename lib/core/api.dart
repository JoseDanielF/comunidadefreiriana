import 'package:dio/dio.dart';
import 'package:comunidadefreiriana/core/models/instituicao_model.dart';
import 'package:flutter/cupertino.dart';

class Api {
  // ignore: unused_field
  final _dio = Dio();
  static const String baseUrl = 'http://185.28.23.76:8010/api';

  getAllInstitutions(BuildContext context) async {
    try {
      var response = await _dio.get<List>(baseUrl + '/instituicao/aprovados');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future cadastrar(InstituicaoModel cadastroModel) async {
    final body = FormData.fromMap({
      'nome': cadastroModel.nome,
      'categoria': cadastroModel.categoria,
      'pais': cadastroModel.pais,
      'estado': cadastroModel.estado,
      'cidade': cadastroModel.cidade,
      'endereco': cadastroModel.endereco,
      'cep': cadastroModel.cep,
      'telefone': cadastroModel.telefone,
      'email': cadastroModel.email,
      'site': cadastroModel.site,
      'coordenador': cadastroModel.coordenador,
      'latitude': cadastroModel.latitude,
      'longitude': cadastroModel.longitude,
      'info': cadastroModel.info,
      'autorizado': false,
      'confirmacaoEmail': false,
      'datafundacao':
          ('${cadastroModel.datafundacao!.year}-${cadastroModel.datafundacao!.month}-${cadastroModel.datafundacao!.day}')
              .toString()
    });
    try {
      Response response = await _dio.post(baseUrl + '/instituicao/store',
          data: body,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
              'Accept': 'application/json',
            },
          ));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
