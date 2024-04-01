import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Details2 extends StatefulWidget {
  const Details2({super.key});

  @override
  State<Details2> createState() => _DetailsState();
}

class _DetailsState extends State<Details2> {
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
      body: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Container(
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
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/fields/redd.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              const Text("Red Futsal",
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
                  "Jam Operasional : 08.00 - 22.00",
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
              SizedBox(height: 5),
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
                "Jl. Raya Kendangsari No.28, Kendangsari, Kec. Tenggilis Mejoyo, Surabaya, Jawa Timur 60929",
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
      ),
    );
  }
}
