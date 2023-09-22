class UserModel {
  final String? nombre;
  final String? apellido;
  final String? usuario;
  final String? estatus;
  final String? celular;
  final String? email;
  final int pkidempresa;
  final int? admin;
  final int? cuadreCaja;

  UserModel(this.nombre, this.apellido, this.usuario, this.estatus,
      this.celular, this.email, this.pkidempresa, this.admin, this.cuadreCaja);
}

class UserModelResponse {
  String mensaje;
  UserModel? data;

  UserModelResponse(this.mensaje, this.data);
}
