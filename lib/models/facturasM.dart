class Facturas {
  final int id;
  final String? numeroFactura;
  final String fecha;
  final String? nombre;
  final int pkidcliente;
  final String? tiempoentrega;
  final double? itebis;
  final String total;
  final String? emailcliente;
  final int? cotizacion;
  final int pkidempresa;
  final int? pkidsuplidorInformar;
  final double? itbisPorc;
  final int? pkidestatus;
  final int? recibo;
  final int? pkidcompaniaEnvio;
  final String? usuario;

  Facturas(
      this.id,
      this.numeroFactura,
      this.fecha,
      this.nombre,
      this.pkidcliente,
      this.tiempoentrega,
      this.itebis,
      this.total,
      this.emailcliente,
      this.cotizacion,
      this.pkidempresa,
      this.pkidsuplidorInformar,
      this.itbisPorc,
      this.pkidestatus,
      this.recibo,
      this.pkidcompaniaEnvio,
      this.usuario);
}
