class dataTenant {
  final String itemNamaPT;
  final String itemGerai;
  final String itemLokasi;
  final String itemJenis;
  final String itemLuas;
  final String itemKeterangan;
  final String itemKode;
  final String itemGambar;
  final String itemKondisi;
  final String itemLastUpdated;

  dataTenant(
      {required this.itemNamaPT,
      required this.itemGerai,
      required this.itemLokasi,
      required this.itemJenis,
      required this.itemLuas,
      required this.itemKeterangan,
      required this.itemKode,
      required this.itemGambar,
      required this.itemKondisi,
      required this.itemLastUpdated});

  Map<String, dynamic> toJson() {
    return {
      "NamaPT": itemNamaPT,
      "Gerai": itemGerai,
      "Lokasi": itemLokasi,
      "Jenis": itemJenis,
      "Luas": itemLuas,
      "Keterangan": itemKeterangan,
      "Kode": itemKode,
      "Gambar": itemGambar,
      "Kondisi": itemKondisi,
      "LastUpdated": itemLastUpdated,
    };
  }

  factory dataTenant.fromJson(Map<String, dynamic> json) {
    return dataTenant(
      itemNamaPT: json['NamaPT'],
      itemGerai: json['Gerai'],
      itemLokasi: json['Lokasi'],
      itemJenis: json['Jenis'],
      itemLuas: json['Luas'],
      itemKeterangan: json['Keterangan'],
      itemKode: json['Kode'],
      itemGambar: json['Gambar'],
      itemKondisi: json['Kondisi'],
      itemLastUpdated: json['LastUpdated'],
    );
  }
}
