import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
//import 'package:jitsi_meet/room_name_constraint.dart';
//import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:bppt_meeting/FadeAnimation.dart';
//void main() => runApp(Meet());

class Meeting extends StatefulWidget {
  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  //final serverText = TextEditingController();
  final serverText = "https://meeting.bppt.go.id";
  final roomText = TextEditingController(text: "");
  final subjectText = TextEditingController(text: "Rapat");
  final nameText = TextEditingController(text: "");
  final emailText = TextEditingController(text: "fake@email.com");
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  List<String> mode = [
    'Audio Only',
    'Audio Muted',
    'Video Muted',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  " Meeting BPPT",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    controller: nameText,
                                    decoration: InputDecoration(
                                        errorText: _validate
                                            ? 'Value Can\'t Be Empty'
                                            : null,
                                        border: InputBorder.none,
                                        hintText: "Nama Anda",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: roomText,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Nama Ruangan",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      // SizedBox(
                      //   height: 70,
                      // ),
                      FadeAnimation(
                          1.5,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Audio Only",
                                      style: TextStyle(
                                        fontSize: 12,
                                        letterSpacing: 0.3,
                                        color: Colors.grey,
                                        // Color.fromRGBO(143, 148, 251, 1)
                                      ),
                                    ),
                                    Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor: Colors.grey),
                                      child: Checkbox(
                                        value: isAudioOnly,
                                        activeColor:
                                            Color.fromRGBO(143, 148, 251, 3),
                                        onChanged: _onAudioOnlyChanged,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Audio Muted",
                                      style: TextStyle(
                                        letterSpacing: 0.3,
                                        fontSize: 12,
                                        color: Colors.grey,
                                        //Color.fromRGBO(143, 148, 251, 4)
                                      ),
                                    ),
                                    Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor: Colors.grey),
                                      child: Checkbox(
                                        value: isAudioMuted,
                                        activeColor:
                                            Color.fromRGBO(143, 148, 251, 3),
                                        onChanged: _onAudioMutedChanged,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Video Muted",
                                      style: TextStyle(
                                        fontSize: 12,
                                        letterSpacing: 0.3,
                                        color: Colors.grey,
                                        //Color.fromRGBO(143, 148, 251, 1)
                                      ),
                                    ),
                                    Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor: Colors.grey),
                                      child: Checkbox(
                                        value: isVideoMuted,
                                        activeColor:
                                            Color.fromRGBO(143, 148, 251, 3),
                                        onChanged: _onVideoMutedChanged,
                                      ),
                                    ),
                                  ],
                                ),

                                // Container(
                                //     child: (Text(
                                //   "Video Off",
                                //   style: TextStyle(
                                //       color: Color.fromRGBO(143, 148, 251, 1)),
                                // )))
                              ])),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          2,
                          InkWell(
                              onTap: () {
                                _joinMeeting();
                              },
                              //onTap: () => print("container pressed"),
                              // onTap: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Meet()),
                              //   );
                              // },
                              child: (Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: Center(
                                  child: Text(
                                    "Mulai Rapat",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )))),
                      // CheckboxListTile(
                      //   title: Text(
                      //     "Video Muted",
                      //     style: (TextStyle(
                      //         fontSize: 14,
                      //         color: Color.fromRGBO(143, 148, 251, 1))),
                      //   ),
                      //   value: isVideoMuted,
                      //   onChanged: _onVideoMutedChanged,
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String serverUrl = serverText;
    //serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };

      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureFlags);

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  // static final Map<RoomNameConstraintType, RoomNameConstraint>
  //     customContraints = {
  //   RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
  //     return value.trim().length <= 50;
  //   }, "Maximum room name length should be 30."),
  //   RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
  //     return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
  //             .hasMatch(value) ==
  //         false;
  //   }, "Currencies characters aren't allowed in room names."),
  // };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
