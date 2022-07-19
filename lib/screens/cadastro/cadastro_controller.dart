import 'package:comunidadefreiriana/core/api.dart';
import 'package:comunidadefreiriana/core/models/instituicao_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:io' show File;

import '../../image_control/image_picker.controller.dart';

class CadastroController with ChangeNotifier {
  bool isLoading = false;
  // ignore: unused_field
  File? _selectedImage;
  String? _imagePath;
  bool hasAddress = false;
  bool hasImg = false;
  String? valorAtualDropbox = 'Selecione';
  final _imagePickerController = ImagePickerController();
  final InstituicaoModel cadastroModel = InstituicaoModel();
  final _api = Api();

  get getDataTime {
    return cadastroModel.datafundacao;
  }

  Future validateAdress() async {
    if (cadastroModel.latitude == null) {
      try {
        List<Location> locations = await locationFromAddress(
            '${cadastroModel.endereco} ${cadastroModel.estado} ${cadastroModel.cidade} ${cadastroModel.pais}');
        cadastroModel.latitude = locations.first.latitude.toString();
        cadastroModel.longitude = locations.first.longitude.toString();
        hasAddress = true;
      } catch (e) {
        hasAddress = false;
      }
    }
  }

  void finishCadastro(BuildContext context) async {
    isLoading = true;
    cadastroModel.imagem = _selectedImage;
    _api.cadastrar(cadastroModel).then((value) {
      isLoading = false;
      notifyListeners();
      if (value = true) {
        if (kDebugMode) {
          print('Deu Bom');
        }
      } else {
        if (kDebugMode) {
          print('Deu não');
        }
      }
    });
    notifyListeners();
  }

  bool checkImg() {
    if (_selectedImage == null) {
      return false;
    }
    return true;
  }

  bool validateFields() {
    if (cadastroModel.nome != '' &&
        cadastroModel.categoria != 'Selecione' &&
        cadastroModel.categoria != '' &&
        cadastroModel.pais != '' &&
        cadastroModel.estado != '' &&
        cadastroModel.cidade != '' &&
        cadastroModel.endereco != '' &&
        cadastroModel.cep != '' &&
        cadastroModel.email != '' &&
        cadastroModel.coordenador != '' &&
        cadastroModel.datafundacao != null &&
        selectedImage != null) {
      return true;
    } else {
      return false;
    }
  }

  String? get imagePaths => _imagePath;

  File? get selectedImage => _selectedImage;

  set selectedImage(File? value) {
    _selectedImage = value;
    notifyListeners();
  }

  Future selectImageCam() async {
    File? file = await _imagePickerController.pickImageFromCamera();
    if (file != null) {
      _imagePath = file.path;
    } else {
      return null;
    }

    _selectedImage = file;
    notifyListeners();
  }

  Future selectImage() async {
    File? file = await _imagePickerController.pickImageFromGalery();
    if (file != null) {
      _imagePath = file.path;
    } else {
      return null;
    }

    _selectedImage = file;
    notifyListeners();
  }

  Future clearImg() async {
    _selectedImage = null;
    notifyListeners();
  }

  String? getValorAtual() {
    return valorAtualDropbox;
  }

  void setValorAtual(String? value) {
    valorAtualDropbox = value;
  }

  void setNome(String value) {
    cadastroModel.nome = value;
  }

  void setCategoria(String? value) {
    cadastroModel.categoria = value;
  }

  void setPais(String value) {
    cadastroModel.pais = value;
  }

  void setEstado(String value) {
    cadastroModel.estado = value;
  }

  void setCidade(String value) {
    cadastroModel.cidade = value;
  }

  void setEndereco(String value) {
    cadastroModel.endereco = value;
  }

  void setCEP(String value) {
    cadastroModel.cep = value;
  }

  void setTelefone(String value) {
    cadastroModel.telefone = value;
  }

  void setEmail(String value) {
    cadastroModel.email = value;
  }

  void setSite(String value) {
    cadastroModel.site = value;
  }

  void setCoord(String value) {
    cadastroModel.coordenador = value;
  }

  void setDataFund(DateTime? value) {
    cadastroModel.datafundacao = value;
  }

  void setLat(String value) {
    cadastroModel.latitude = value;
  }

  void setLong(String value) {
    cadastroModel.longitude = value;
  }

  void setMaisInfomacoes(String value) {
    // ignore: prefer_void_to_null
    cadastroModel.info = value;
  }
}
