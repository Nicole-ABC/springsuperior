import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/pages/member_details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spring_superior/services/member_services.dart';

class MemberListItem extends StatefulWidget {
  final Member member;

  MemberListItem({
    this.member,
  });

  @override
  _MemberListItemState createState() => _MemberListItemState();
}

class _MemberListItemState extends State<MemberListItem> {
  MemberServices memberServices = MemberServices();
  bool active;
  bool isAlmostExpired = false;

  getIsAlmostExpired() async {
    isAlmostExpired = await memberServices.checkAlmostExpired(widget.member);
    setState(() {});
  }

  @override
  void initState() {
    memberServices.checkDate();
    getActive();
    super.initState();
    getIsAlmostExpired();
  }

  getActive() {
    if (widget.member.active == 'true') {
      active = true;
    } else {
      active = false;
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      decoration: BoxDecoration(
          border: Border.all(
              color: active
                  ? isAlmostExpired
                      ? Colors.red[500]
                      : Theme.of(context).accentColor
                  : Colors.grey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(15.0)),
      margin: EdgeInsets.all(8.0),
      height: 100.0,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 12.0,
                width: 12.0,
                decoration: BoxDecoration(
                    color: active
                        ? isAlmostExpired
                            ? Colors.red[500]
                            : Theme.of(context).accentColor
                        : Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15.0))),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${widget.member.surname} ${widget.member.firstName}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                  borderRadius: BorderRadius.circular(18.0),
                  onTap: () {
                    setState(() {
                      _makePhoneCall('tel:${widget.member.phoneNumber}');
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                    decoration: BoxDecoration(
                      color:  active
                          ? isAlmostExpired
                          ? Colors.red[500]
                          : Theme.of(context).accentColor
                          : Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.15)
                    ),
                    child: Icon(Icons.call, color: Colors.white),
                  )),
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                  borderRadius: BorderRadius.circular(18.0),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MemberDetails(member: widget.member),
                        ));
                    setState(() {
                      getIsAlmostExpired();
                    });
                  },
                  child: Container(
                    child: Icon(Icons.more_vert),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
