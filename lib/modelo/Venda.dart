import 'Cliente.dart';

class Venda {
    int cdVenda;
    Cliente cdCliente;
    double vlVenda;

    Venda(this.cdVenda, this.cdCliente, this.vlVenda);

    Venda.fromJson(Map<String, dynamic> json) {
        this.cdVenda = json['cdVenda'];
        this.cdCliente = Cliente.fromJson(json['cdCliente']['Cliente']);
        this.vlVenda = json['vlVenda'];
    }
}