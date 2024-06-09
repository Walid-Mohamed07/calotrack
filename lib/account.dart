import 'package:calo_track/more.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'bottom_bar.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ACCOUNT extends StatefulWidget {
  const ACCOUNT({super.key});
  

  @override
  State<ACCOUNT> createState() => _ACCOUNTState();
}

class _ACCOUNTState extends State<ACCOUNT> {
  List fieldName = [
    "User_Name",
    "Email",
    "Password",
    "Gender",
    "Age",
    "Weight",
    "Height",
  ];
  final TextEditingController User_Name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController Gender = TextEditingController();
  final TextEditingController Age = TextEditingController();
  final TextEditingController Weight = TextEditingController();
  final TextEditingController Height = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      // _UserProfileState createState() => _UserProfileState();
      User_Name.text = getUserData()["${fieldName[0].toLowerCase()}"];
      password.text = getUserData()["${fieldName[2].toLowerCase()}"];
      Gender.text = getUserData()["${fieldName[3].toLowerCase()}"];
      Age.text = getUserData()["${fieldName[4].toLowerCase()}"];
      Weight.text = getUserData()["${fieldName[5].toLowerCase()}"];
      Height.text = getUserData()["${fieldName[6].toLowerCase()}"];
    });
  }

  File? _imageFile;
  bool _isLoading = false;
  Map<String, String> userData = {
    "user_picture": getUserData()["user_picture"],
  };

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    setState(() {
      _isLoading = true;
    });

    final uri = Uri.parse(
        'https://caltrack.atwebpages.com/CRUD/user/updateUserPicture.php'); // Replace with your API endpoint
    final request = http.MultipartRequest('POST', uri)
      ..fields['email'] = getUserData()["${fieldName[1].toLowerCase()}"]
      ..files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);

      if (jsonResponse['success']) {
        setState(() {
          userData["user_picture"] = jsonResponse['imageURL'];
        });
      } else {
        _showError(jsonResponse['message']);
      }
    } else {
      _showError('Failed to upload image.');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future updateData(BuildContext cont) async {
    String url = "https://caltrack.atwebpages.com/CRUD/user/updateUser.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": getUserData()["${fieldName[1].toLowerCase()}"],
      "username": User_Name.text,
      "password": password.text,
      "gender": Gender.text,
      "age": Age.text,
      "weight": Weight.text,
      "height": Height.text,
    });
    String data = json.decode(response.body);
    if (data == "success") {
      Navigator.of(context).pushNamedAndRemoveUntil("more", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BOTTOMBAR(),
      appBar: AppBar(
        toolbarHeight: 90,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          iconSize: 50,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
          color: Colors.blue,
        ),
        titleSpacing: 80,
        title: const Text(
          "My Account",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.0,
              child: ClipOval(
                child: Image.network(
                  userData["user_picture"] ?? "",
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              TextButton(
                onPressed: _pickImage,
                child: const Text("Update Picture"),
              ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "${fieldName[0]}",
                  style: const TextStyle(
                    fontFamily: "inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 300,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    border: Border.all(
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: TextFormField(
                          key: Key("${fieldName[0]}"),
                          keyboardType: TextInputType.text,
                          controller: User_Name,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "${fieldName[1]}",
                  style: const TextStyle(
                    fontFamily: "inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 300,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    border: Border.all(
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "${getUserData()["${fieldName[1].toLowerCase()}"]}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "${fieldName[2]}",
                  style: const TextStyle(
                    fontFamily: "inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 300,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    border: Border.all(
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: TextFormField(
                          key: Key("${fieldName[2]}"),
                          keyboardType: TextInputType.text,
                          controller: password,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "${fieldName[3]}",
                  style: const TextStyle(
                    fontFamily: "inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 300,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    border: Border.all(
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: TextFormField(
                          key: Key("${fieldName[3]}"),
                          keyboardType: TextInputType.text,
                          controller: Gender,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "${fieldName[4]}",
                  style: const TextStyle(
                    fontFamily: "inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 300,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    border: Border.all(
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: TextFormField(
                          key: Key("${fieldName[4]}"),
                          keyboardType: TextInputType.text,
                          controller: Age,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "${fieldName[5]}",
                  style: const TextStyle(
                    fontFamily: "inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 300,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    border: Border.all(
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: TextFormField(
                          key: Key("${fieldName[5]}"),
                          keyboardType: TextInputType.text,
                          controller: Weight,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "${fieldName[6]}",
                  style: const TextStyle(
                    fontFamily: "inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 300,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    border: Border.all(
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: TextFormField(
                          key: Key("${fieldName[6]}"),
                          keyboardType: TextInputType.text,
                          controller: Height,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(
                      255,
                      3,
                      79,
                      251,
                    ),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                onPressed: () {
                  updateData(context);
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: const Text(
                      "Update Data",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
