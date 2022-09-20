import 'dart:developer';

import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone_tutorial/resources/firestore_methods.dart';

class JitsiMeetMethods {
//  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      String name;
      if (username.isEmpty) {
        name = 'ahmed';
      } else {
        name = username;
      }
      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userEmail = 'email'
        ..audioMuted = isAudioMuted
        ..iosAppBarRGBAColor = "94, 181, 255, 0.5"
        ..videoMuted = isVideoMuted;

      _firestoreMethods.addToMeetingHistory(roomName);
      JitsiMeetingListener jitsiMeetingListener =
          JitsiMeetingListener(onError: ((error) => log(error)));
      await JitsiMeet.joinMeeting(options, listener: jitsiMeetingListener);
    } catch (error) {
      print("error: $error");
    }
  }
}
