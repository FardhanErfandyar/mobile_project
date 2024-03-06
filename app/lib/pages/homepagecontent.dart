import 'package:app/pages/details.dart';
import 'package:flutter/material.dart';
import 'package:app/models/category_model.dart';

class HomePageContent extends StatelessWidget {
  List<CategoryModel> categories = [];

  void _getcategories() {
    categories = CategoryModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getcategories();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Welcome!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 250,
          color: Colors.white,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemBuilder: (context, index) {
              return Container(
                height: 280,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: AssetImage(categories[index].image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: Text(
                        categories[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 40.0),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Rekomendasi Lapangan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Temukan lapangan terbaik tim mu!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Details()));
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Material(
                    borderRadius: BorderRadius.circular(1),
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/fields/Fivas.jpg',
                            height: 150,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                          const Text(
                            'Keputih',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const Text(
                            'Fiva Futsal',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const Text(
                            '10.00 - 22.00',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Material(
                borderRadius: BorderRadius.circular(1),
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/fields/redd.jpg',
                        height: 150,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                      const Text(
                        'Tenggilis Mejoyo',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Text(
                        'Red Futsal',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Text(
                        '09.00 - 17.00',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15),
              Material(
                borderRadius: BorderRadius.circular(1),
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/fields/hokky.jpg',
                        height: 150,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                      const Text(
                        'Sukolilo',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Text(
                        'Hokky Futsal',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Text(
                        '07.00 - 23.59',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
