class Coin {
  int id;
  String name;
  String symbol;
  String slug;
  int numMarketPairs;
  DateTime dateAdded;
  List<String> tags;
  dynamic circulatingSupply;
  dynamic totalSupply;
  int cmcRank;
  DateTime lastUpdated;
  Quote quote;

  Coin.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        symbol = json['symbol'],
        slug = json['slug'],
        numMarketPairs = json['num_market_pairs'],
        dateAdded = DateTime.parse(json['date_added']),
        tags = List<String>.from(json['tags']),
        circulatingSupply = json['circulating_supply'],
        totalSupply = json['total_supply'],
        cmcRank = json['cmc_rank'],
        lastUpdated = DateTime.parse(json['last_updated']),
        quote = Quote.fromJson(json['quote']);
}

class Quote {
  Usd usd;

  Quote.fromJson(Map<String, dynamic> json) : usd = Usd.fromJson(json['USD']);
}

class Usd {
  dynamic price;
  dynamic volume24H;
  dynamic volumeChange24H;
  dynamic percentChange1H;
  dynamic percentChange24H;
  dynamic percentChange7D;
  dynamic percentChange30D;
  dynamic percentChange60D;
  dynamic percentChange90D;
  dynamic marketCap;
  dynamic marketCapDominance;
  dynamic fullyDilutedMarketCap;
  DateTime lastUpdated;

  Usd.fromJson(Map<String, dynamic> json)
      : price = json['price'],
        volume24H = json['volume_24h'],
        volumeChange24H = json['volume_change_24h'],
        percentChange1H = json['percent_change_1h'],
        percentChange24H = json['percent_change_24h'],
        percentChange7D = json['percent_change_7d'],
        percentChange30D = json['percent_change_30d'],
        percentChange60D = json['percent_change_60d'],
        percentChange90D = json['percent_change_90d'],
        marketCap = json['market_cap'],
        marketCapDominance = json['market_cap_dominance'],
        fullyDilutedMarketCap = json['fully_diluted_market_cap'],
        lastUpdated = DateTime.parse(json['last_updated']);
}
