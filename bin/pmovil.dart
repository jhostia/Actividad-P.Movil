import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pmovil/user.dart';

Future<List<User>> fetchUsers() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200){
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Error para cargar usuarios...');
  }
}

List<User> filtroPorNombreDeUsuario(List<User> users){
  return users.where((user) => user.username.length > 6).toList();
}

int usuariosConDominioBiz(List<User> users){
  return users.where((user) => user.email.endsWith('.biz')).length;
}

void main() async {
  try {
    List<User> users = await fetchUsers();

    List<User> filtroUsers = filtroPorNombreDeUsuario(users);
    int usuariosDominio = usuariosConDominioBiz(users);

    print('');
    print('Todos los correos electrónicos:');
    for (var user in users) {
      print(user.email);
    }
    print(''); 

    print('Usuarios con nombre de usuario mayor a 6 caracteres:');
    for (var user in filtroUsers) {
      print(' - ${user.username}');
    }
    print(''); 

    print('Usuarios con dominio .biz: $usuariosDominio');
    
  } catch (e) {
    print('Error: $e');
  }
}
