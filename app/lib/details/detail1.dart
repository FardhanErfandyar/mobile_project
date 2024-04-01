import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Details1 extends StatefulWidget {
  const Details1({Key? key}) : super(key: key);

  @override
  State<Details1> createState() => _Details1State();
}

class _Details1State extends State<Details1> {
  List<Map<String, dynamic>> facilities = [
    {
      'name': 'Jual Minuman',
      'icon': FontAwesomeIcons.glassWhiskey,
    },
    {'name': 'Parkir Mobil', 'icon': FontAwesomeIcons.car},
    {'name': 'Parkir Motor', 'icon': FontAwesomeIcons.motorcycle},
    {'name': ' Ruang Ganti', 'icon': FontAwesomeIcons.exchangeAlt},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/fields/Fivas.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              const Text("Fiva Futsal",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  )),
              SizedBox(height: 10.0),
              Material(
                child: Container(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "Jam Operasional : 08.00 - 22.00",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 7.0),
              Material(
                child: Container(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "Harga: Rp100.000,00 - Rp150.000,00",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 7.0),
                  Material(
                    child: Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
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
                    ),
                  ),
                  SizedBox(height: 1.0),
                  Material(
                    child: Container(
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
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 5),
                  Material(
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Detail Alamat :",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "JL Bumi Marina Emas Barat I/15, Keputih, Kec. Sukolilo, Surabaya, Jawa Timur 60111",
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
