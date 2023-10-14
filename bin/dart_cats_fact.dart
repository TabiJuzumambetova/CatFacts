import 'dart:io';
import 'package:dio/dio.dart';
import 'package:translator/translator.dart';

void main() {
  getFacts();
}

Future<void> getFacts() async {
  final translator = GoogleTranslator();
  int cont=0;
  List<String> liked = [];

  do {
    try {
      final response = await Dio().get("https://catfact.ninja/fact");
      String catsFact = response.data["fact"];
      print("Добро пожаловать , предоставляем рандомные факты о кошках^^");
      print("Введите на какой язык хотите перевести:");
      String lang = stdin.readLineSync() ?? "";
      
      Translation translatedfact = await translator.translate(catsFact, to: lang);
      print(translatedfact.text);

      print("1-Далее , 2-Понравился , 3-Показать список понравившихся фактов, 4-Для очистки списка понравившихся фактов , 5-Для заверщения программы ");
      cont = int.tryParse(stdin.readLineSync() ?? "") ?? 0;

      if (cont == 1) {
        
      } else if (cont == 2) {
        liked.add(translatedfact.text);
        print("Добавили в список ❤️");
      } else if (cont == 3) {
        if (liked.isNotEmpty) {
          print("Список понравившихся фактов:");
          for (var i = 1; i < liked.length; i++) {
            print("$i: ${liked[i]} ❤️");
          }
        }else{
          print("Сптсок пуст");
        }
      } else if(cont==4){
        liked.clear();
        print("Список успешно очищен!");

      }
      else if(cont==5){

      }
      else {
        print("Ошибка");
      }
    } catch (error) {
      print("Ошибка: $error");
    }
  } while (cont != 5);
}
