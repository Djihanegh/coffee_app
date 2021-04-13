final double price = 20.0;
final coffees = List.generate(
    _names.length,
    (index) => Coffee(
        image: "assets/coffee_concept/${index + 1}.jpg",
        price: index + price,
        name: _names[index]));

class Coffee {
  Coffee({required this.name, required this.image, required this.price});

  final String name;
  final String image;
  final double price;
}

final _names = [
  'Caramel cold drink',
  'Bukhari coffee',
  'Iced Coffee',
  'Cappuchino',
  'Black tea',
  'Machiano',
  'Caramel cold drink',
  'Bukhari coffee',
  'Iced Coffee',
  'Cappuchino',
  'Black tea',
  'Machiano'

];
