class Cliente {
    int cdCliente;
    String nmCliente;

    Cliente(this.cdCliente, this.nmCliente);

    Cliente.fromJson(Map<String, dynamic> json) {
        this.cdCliente = json['cdCliente'];
        this.nmCliente = json['nmCliente'];
    }

    Cliente.fromMap(Map<String, dynamic> map) {
        this.cdCliente = map['cd_cliente'];
        this.nmCliente = map['nm_cliente'];
    }
}