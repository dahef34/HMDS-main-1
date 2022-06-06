class User{
  String userID;
  String firstName;
  String lastName;
  String gender;
  String age;
  String dob;
  String nric;
  String contact;
  String health;
  String email;
  String issue;
  String address;

User({required this.userID, required this.firstName, required this.lastName, required this.gender, required this.age,
  required this.dob, required this.nric, required this.contact, required this.health, required this.email,
  required this.issue, required this.address});

static List<User> getUser(){
  return<User>[
    User(userID:"P00001", firstName: "Arno", lastName: "Genorimo", gender: "Mr",
    age: "39", dob: "13-05-1983", nric: "830513-04-1234", contact: "0123456789",
    health: "N/A", email: "ArnoG@gmail.com", issue: "Coronary Heart Disease",
        address:"13, Brima Street, New Hills, 71054, Malaysia" ),
  ];
}
}