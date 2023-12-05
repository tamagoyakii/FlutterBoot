import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'HelloHttp',
      debugShowCheckedModeBanner: false,
      home: HelloHttp(),
    );
  }
}

class HelloHttp extends StatefulWidget {
  const HelloHttp({super.key});

  @override
  State<HelloHttp> createState() => _HelloHttpState();
}

class _HelloHttpState extends State<HelloHttp> {
  TextEditingController inputController = TextEditingController(text: 'sky');
  Future<People>? people;

  void getPeople() async {
    final response = await http.get(
      Uri.parse(
        'https://swapi.dev/api/people/?search=${inputController.text}',
      ),
    );
    if (response.statusCode == 200) {
      setState(() {
        people = Future.value(People.fromJson(jsonDecode(response.body)));
      });
    } else {
      throw Exception();
    }
  }

  Widget _buildListItem({required Human human}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.pink),
      ),
      child: Column(
        children: [
          Text(
            '${human.name}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text('${human.height} / ${human.mass}'),
          const SizedBox(height: 3),
          Text(
            'Hair Color : ${human.hairColor} | Skin Color : ${human.skinColor}',
          ),
        ],
      ),
    );
  }

  Widget _buildFiller({required String filler}) {
    return Expanded(child: Center(child: Text(filler)));
  }

  Widget _buildPeopleList() {
    return FutureBuilder<People>(
      future: people,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildFiller(filler: 'Loading...');
        }
        if (snapshot.hasError) {
          return _buildFiller(filler: 'Error: ${snapshot.error}');
        }
        if (snapshot.data!.results!.isEmpty) {
          return _buildFiller(
            filler:
                'No results found, please try again with a different search term!',
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          itemCount: snapshot.data!.results!.length,
          itemBuilder: (context, index) =>
              _buildListItem(human: snapshot.data!.results![index]),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
          child: Column(
            children: [
              TextField(
                controller: inputController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: ElevatedButton(
                    onPressed: getPeople,
                    child: const Text('Search!'),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _buildPeopleList(),
            ],
          ),
        ),
      ),
    );
  }
}

class People {
  int? count;
  String? next;
  int? previous;
  List<Human>? results;

  People({this.count, this.next, this.previous, this.results});

  People.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Human>[];
      json['results'].forEach((v) {
        results!.add(Human.fromJson(v));
      });
    }
  }
}

class Human {
  String? name;
  String? height;
  String? mass;
  String? hairColor;
  String? skinColor;
  String? eyeColor;
  String? birthYear;
  String? gender;
  String? homeworld;
  List<String>? films;
  List<String>? species;
  List<String>? vehicles;
  List<String>? starships;
  String? created;
  String? edited;
  String? url;

  Human({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,
  });

  Human.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    height = json['height'];
    mass = json['mass'];
    hairColor = json['hair_color'];
    skinColor = json['skin_color'];
    eyeColor = json['eye_color'];
    birthYear = json['birth_year'];
    gender = json['gender'];
    homeworld = json['homeworld'];
    films = json['films'].cast<String>();
    species = json['species'].cast<String>();
    vehicles = json['vehicles'].cast<String>();
    starships = json['starships'].cast<String>();
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }
}
