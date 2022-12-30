class Pet {
  final String id;
  final String name;
  final String age;
  final int price;
  final String image;
  bool isAdopted;

  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.image,
    required this.isAdopted,
  });


  static List<Pet> PetsList = [
    Pet(id: "1",name: "Momo",age: "1 year",price: 5000,image: "assets/images/dog4.png",isAdopted: false),
    Pet(id: "2",name: "Bella",age: "2 months",price: 7000,image: "assets/images/home_hero.jpg",isAdopted: false),
    Pet(id: "3",name: "whisky",age: "3 year",price: 8000,image: "assets/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg",isAdopted: false),
    Pet(id: "4",name: "Charlie",age: "9 months",price: 1500,image: "assets/images/images.jpeg",isAdopted: false),
    Pet(id: "5",name: "Luna",age: "1 year",price: 5000,image: "assets/images/images (1).jpeg",isAdopted: false),
    Pet(id: "6",name: "Max",age: "2 year",price: 4500,image: "assets/images/images (2).jpeg",isAdopted: false),
    Pet(id: "7",name: "Lucy",age: "7 months",price: 7500,image: "assets/images/images (3).jpeg",isAdopted: false),
    Pet(id: "8",name: "Bailey",age: "1 year",price: 5800,image: "assets/images/images (6).jpeg",isAdopted: false),
    Pet(id: "9",name: "Cooper",age: "3 months",price: 7300,image: "assets/images/images (7).jpeg",isAdopted: false),
    Pet(id: "10",name: "Tiger",age: "7 months",price: 9500,image: "assets/images/images (8).jpeg",isAdopted: false),
    Pet(id: "11",name: "Daisy",age: "3 months",price: 5000,image: "assets/images/images (9).jpeg",isAdopted: false),
  ];

  static List<Pet> getInitialList(int n) {
    List<Pet> initialList = [];
    for(int i=0; i<n; i++) {
      initialList.add(PetsList[i]);
    }
    return initialList;
  }


}