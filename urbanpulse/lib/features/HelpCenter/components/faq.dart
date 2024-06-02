import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';



class FAQ extends StatelessWidget {
  const FAQ({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
      
          children: <Widget>[
            GFAccordion(
              collapsedIcon: Icon(Icons.add),
              expandedIcon: Icon(Icons.minimize),
              title: "Що таке UrbanPulse?",
              content: "UrbanPulse – це додаток, який дозволяє користувачам легко знаходити найвідповідніші місця для своїх потреб в обраному місті. Всі необхідні дані зібрані в одному місці, щоб уникнути перемикання між різними сайтами.",
            ),
            GFAccordion(
              collapsedIcon: Icon(Icons.add),
              expandedIcon: Icon(Icons.minimize),
              title: "Як я можу зв'язатися зі службою підтримки UrbanPulse? ",
              content: "Ви можете зв'язатися з нашою службою підтримки через розділ 'Контакти' у додатку або надіславши електронного листа на testingflutapp@gmail.com.",
            ),
            GFAccordion(
              collapsedIcon: Icon(Icons.add),
              expandedIcon: Icon(Icons.minimize),
              title: "Чи можна використовувати UrbanPulse в різних містах?",
              content: "Так, UrbanPulse підтримує багато міст і постійно розширює свою базу даних, щоб охопити більше локацій по всьому світу.",
            ),
            
          ],
        ),
      ),
    ));
  }
}
