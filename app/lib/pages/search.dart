import 'package:flutter/material.dart';

class SearchPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                autofocus: false,
                enableSuggestions: true,
                enableInteractiveSelection: true,
                initialValue: '',
                decoration: InputDecoration(
                  hintText: "Ayo cari lapangan 🔥 🔥 🔥 🔥",
                  labelText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
