import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring_superior/services/member_services.dart';
import 'package:spring_superior/widgets/member_list_item.dart';

class Members extends StatefulWidget {
  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  MemberServices memberServices = MemberServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Members'),
      ),
      body: FutureBuilder(
        future: memberServices.getAllMembers(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print('Error');
            return Text('An error has occured');
          }
          else if(!snapshot.hasData){
            return Column(
              children: <Widget>[
                CircularProgressIndicator(),
                Text("Loading")
              ],
            );
          }
          else if(snapshot.data.length == 0){
            return Center(
              child: Text("No members available")
            );
          }
          print("List created");
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => MemberListItem(
              id: snapshot.data[index].id,
              firstName: snapshot.data[index].firstName,
              surname: snapshot.data[index].surname,
              date: snapshot.data[index].date,
              active: snapshot.data[index].active,
            ));
        },
      ),
    );
  }
}
