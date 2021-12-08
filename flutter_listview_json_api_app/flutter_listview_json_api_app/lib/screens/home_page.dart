import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listview_json_api_app/constants/text.dart'; // titleStyle & SubtitleStyle
import 'package:flutter_listview_json_api_app/model/personel_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //apiden çekilecek verilerin url adresini burada tutuyoruz
  final url = Uri.parse('https://reqres.in/api/users');
  late int sayac;
  var personelResult;

  @override
  void initState() {
    super.initState();
    callPersons(); // homepage sayfası içerisinde durum yönetimi yapabilmek için initState içerisine callPersons methodunu tanımladık
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personel Listesi'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: sayac != null
                ? ListView.builder(
                    itemCount: sayac,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          personelResult.data[index].firstName +
                              ' ' +
                              personelResult.data[index].lastName,
                          style: titleStyle,
                        ),
                        subtitle: Text(
                          personelResult.data[index].email,
                          style: subTitleStyle,
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(personelResult.data[index].avatar),
                        ),
                      );
                    })
                : Center(child: CircularProgressIndicator())),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.orange,
        onPressed: () {
          callPersons();
        },
      ),
    );
  }

  Future callPersons() async {
    try {
      final response = await http.get(
          url); // beklenen yanit response ile urlden gelen verileri döndürücek
      if (response.statusCode == 200) {
        var result = personelFromJson(
            response.body); // dönen veriler result ile ekranda listelenecek
        if (mounted) {
          setState(() {
            sayac = result.data.length;
            personelResult = result;
          });
          return result;
        } else {
          print(response
              .statusCode); // eger sunucuya ulaşılamıyorsa hangi status code hatası aldığını görüp müdahale edilecek
        }
      }
    } catch (exception) {
      print(exception.toString());
    }
  }
}
