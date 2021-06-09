import 'package:flutter/material.dart';

class  MyImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(children: 
    [const Image(image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),height: 300.0,),
    Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
    ]
    ,);
  }
  
}