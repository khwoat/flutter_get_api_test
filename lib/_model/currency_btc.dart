class CurrencyBTC {
  CurrencyBTC({
    required this.time,
    required this.disclaimer,
    required this.chartName,
    required this.bpi,
  });
  late final Time time;
  late final String disclaimer;
  late final String chartName;
  late final Bpi bpi;
  
  CurrencyBTC.fromJson(Map<String, dynamic> json){
    time = Time.fromJson(json['time']);
    disclaimer = json['disclaimer'];
    chartName = json['chartName'];
    bpi = Bpi.fromJson(json['bpi']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['time'] = time.toJson();
    data['disclaimer'] = disclaimer;
    data['chartName'] = chartName;
    data['bpi'] = bpi.toJson();
    return data;
  }
}

class Time {
  Time({
    required this.updated,
    required this.updatedISO,
    required this.updateduk,
  });
  late final String updated;
  late final String updatedISO;
  late final String updateduk;
  
  Time.fromJson(Map<String, dynamic> json){
    updated = json['updated'];
    updatedISO = json['updatedISO'];
    updateduk = json['updateduk'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['updated'] = updated;
    data['updatedISO'] = updatedISO;
    data['updateduk'] = updateduk;
    return data;
  }
}

class Bpi {
  Bpi({
    required this.usd,
    required this.gbp,
    required this.eur,
  });
  late final USD usd;
  late final GBP gbp;
  late final EUR eur;
  
  Bpi.fromJson(Map<String, dynamic> json){
    usd = USD.fromJson(json['USD']);
    gbp = GBP.fromJson(json['GBP']);
    eur = EUR.fromJson(json['EUR']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['USD'] = usd.toJson();
    data['GBP'] = gbp.toJson();
    data['EUR'] = eur.toJson();
    return data;
  }
}

class USD {
  USD({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });
  late final String code;
  late final String symbol;
  late final String rate;
  late final String description;
  late final double rateFloat;
  
  USD.fromJson(Map<String, dynamic> json){
    code = json['code'];
    symbol = json['symbol'];
    rate = json['rate'];
    description = json['description'];
    rateFloat = json['rate_float'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['symbol'] = symbol;
    data['rate'] = rate;
    data['description'] = description;
    data['rate_float'] = rateFloat;
    return data;
  }
}

class GBP {
  GBP({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });
  late final String code;
  late final String symbol;
  late final String rate;
  late final String description;
  late final double rateFloat;
  
  GBP.fromJson(Map<String, dynamic> json){
    code = json['code'];
    symbol = json['symbol'];
    rate = json['rate'];
    description = json['description'];
    rateFloat = json['rate_float'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['symbol'] = symbol;
    data['rate'] = rate;
    data['description'] = description;
    data['rate_float'] = rateFloat;
    return data;
  }
}

class EUR {
  EUR({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });
  late final String code;
  late final String symbol;
  late final String rate;
  late final String description;
  late final double rateFloat;
  
  EUR.fromJson(Map<String, dynamic> json){
    code = json['code'];
    symbol = json['symbol'];
    rate = json['rate'];
    description = json['description'];
    rateFloat = json['rate_float'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['symbol'] = symbol;
    data['rate'] = rate;
    data['description'] = description;
    data['rate_float'] = rateFloat;
    return data;
  }
}