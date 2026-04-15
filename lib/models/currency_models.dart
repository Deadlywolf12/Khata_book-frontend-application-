class Currency {
  final String code;
  final String title;
  final String subtitle;
  final String? symbol;

  Currency({
    required this.code,
    required this.title,
    required this.subtitle,
    this.symbol,
  });
}

class CurrencyModel {
  static final List<Currency> currencies = [
    Currency(
      code: 'USD',
      title: 'USD',
      subtitle: 'US Dollar',
      symbol: '\$',
    ),
    Currency(
      code: 'EUR',
      title: 'EUR',
      subtitle: 'Euro',
      symbol: '€',
    ),
    Currency(
      code: 'GBP',
      title: 'GBP',
      subtitle: 'British Pound',
      symbol: '£',
    ),
    Currency(
      code: 'INR',
      title: 'INR',
      subtitle: 'Indian Rupee',
      symbol: '₹',
    ),
    Currency(
      code: 'JPY',
      title: 'JPY',
      subtitle: 'Japanese Yen',
      symbol: '¥',
    ),
    Currency(
      code: 'AUD',
      title: 'AUD',
      subtitle: 'Australian Dollar',
      symbol: 'A\$',
    ),
    Currency(
      code: 'PKR',
      title: 'PKR',
      subtitle: 'Pakistani Rupee',
      symbol: '₨',
    ),
  ];

  static List<Currency> getAllCurrencies() => currencies;
}