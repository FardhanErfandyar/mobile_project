import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Details3 extends StatefulWidget {
  const Details3({super.key});

  @override
  State<Details3> createState() => _DetailsState();
}

class _DetailsState extends State<Details3> {
  List<Map<String, dynamic>> facilities = [
    {
      'name': 'Jual Minuman',
      'icon': FontAwesomeIcons.glassWhiskey,
    },
    {'name': 'Parkir Mobil', 'icon': FontAwesomeIcons.car},
    {'name': 'Parkir Motor', 'icon': FontAwesomeIcons.motorcycle},
    {'name': ' Ruang Ganti', 'icon': FontAwesomeIcons.exchangeAlt},
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.black)),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                    image: AssetImage("assets/fields/hokky.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            const Text("Hokky Futsal",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                )),
            SizedBox(height: 10.0),
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(50),
              child: const Text(
                "Jam Operasional : 07.00 - 23.59",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(50),
              child: const Text(
                "Harga: Rp100.000,00 - Rp150.000,00",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(50),
              child: Text(
                "Fasilitas : ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 0.1,
                mainAxisSpacing: 0.1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 2,
                children: facilities.map((facility) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: ListTile(
                      leading: Icon(facility['icon']),
                      title: Text(facility['name']),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 5),
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(50),
              child: const Text(
                "Detail Alamat :",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              "Jl. Nginden II No.109, Nginden Jangkungan, Kec. Sukolilo, Surabaya, Jawa Timur 60118",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
