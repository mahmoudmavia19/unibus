import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unibus/core/app_export.dart';

class HomeScreen  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: ListView.builder(
           itemCount: 4,
             itemBuilder:(context, index) => Card(
               child: ListTile(
                 title: Row(
                   children: [
                     Expanded(child: Text('Company $index',style: TextStyle(fontWeight: FontWeight.bold,color:theme.primaryColor),)),
                     IconButton(onPressed: (){}, icon: Icon(Icons.chat_bubble,color: theme.primaryColor,))
                   ],
                 ),
                 subtitle: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 10.0,),
                     Row(
                       children: [
                         Icon(Icons.email,color: theme.primaryColor,),
                         SizedBox(width: 10.0,),
                         Text('company${index+1}@gmail.com'),
                       ],
                     ),
                     SizedBox(height: 10.0,),
                     Row(
                       children: [
                         Icon(Icons.phone,color: theme.primaryColor,),
                         SizedBox(width: 10.0,),
                         Text('0567954642'),
                       ],
                     ),
                     Row(
                       children: [
                         Icon(Icons.mode_of_travel,color: theme.primaryColor,),
                         SizedBox(width: 10.0,),
                         Text('${index+1} Trip'),
                         Spacer(),
                         TextButton(onPressed: (){}, child: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Text('Booking Now',style: TextStyle(fontSize: 16.0),),
                             Icon(Icons.arrow_forward_ios)
                           ],
                         ),)
                       ],
                     ),
                     SizedBox(height: 10.0,), Text('${DateFormat.yMMMd().format(DateTime.now())}',style: TextStyle(color: Colors.black26,fontSize: 14.0),),
                   ],
                 ),
                ),
             ),
         ),
       ) ,
    );
  }
}
