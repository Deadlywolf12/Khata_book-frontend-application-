String getGreeting( ) {
  final hour = DateTime.now().hour;

  String greet;

  if (hour >= 5 && hour < 12) {
    greet = "Good Morning";
  } else if (hour >= 12 && hour < 17) {
    greet = "Good Afternoon";
  } else if (hour >= 17 && hour < 21) {
    greet = "Good Evening";
  } else {
    greet = "Good Night";
  }

  return "$greet!";
}