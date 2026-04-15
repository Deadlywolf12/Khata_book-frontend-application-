String getFlag(String code) {
  switch (code) {
    case 'USD': return '🇺🇸';
    case 'EUR': return '🇪🇺';
    case 'GBP': return '🇬🇧';
    case 'INR': return '🇮🇳';
    case 'JPY': return '🇯🇵';
    case 'AUD': return '🇦🇺';
    case 'PKR': return '🇵🇰';
    default: return '🏳️';
  }
}