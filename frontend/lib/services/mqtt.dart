import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:smart_tolls/services/auth.dart';
import 'dart:convert';
import 'package:toastification/toastification.dart';
import 'package:smart_tolls/models/models.dart';

mqttBrokerSetUp(AuthProvider auth, String clientName) async {
  try {
    var client = MqttBrowserClient('ws://localhost', clientName);
    client.websocketProtocols = ['mqtt'];
    client.port = 9001;
    client.keepAlivePeriod = 60;
    client.logging(on: false);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    // client.autoReconnect = true;
    client.resubscribeOnAutoReconnect = false;
    client.onAutoReconnect = onAutoReconnect;
    client.onAutoReconnected = onAutoReconnected;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientName)
        .startClean()
        .withWillQos(MqttQos.exactlyOnce);

    client.connectionMessage = connMessage;

    await client.connect();
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      print("Connected Succesfully");
    } else {
      print("Failed to Connect");
    }

    client.subscribe("user/updates", MqttQos.exactlyOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      final topic = messages[0].topic;
      final message = messages[0].payload as MqttPublishMessage;
      final decoded =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      print("!!!!Received message $decoded from topic: $topic");
      if (decoded != 'failed') {
        final Map<String, dynamic> data = jsonDecode(decoded);
        double updatedBalance = data['balance'] as double;
        String userId = data['transaction']['id'] as String;
        String zone = data['transaction']['zone'] as String;
        String tollName = data['transaction']['tollName'] as String;
        String timeStamp = data['transaction']['timeStamp'] as String;
        double chargeAmount =
            data['transaction']['chargeAmount'].toDouble() as double;
        Transaction newTransaction = Transaction(
            userId: userId,
            zone: zone,
            tollName: tollName,
            timeStamp: timeStamp,
            chargeAmount: chargeAmount);
        auth.user!.transactions.add(newTransaction);
        User updatedUser = User(
            balance: updatedBalance,
            userId: auth.user!.userId,
            username: auth.user!.username,
            email: auth.user!.email,
            licensePlate: auth.user!.licensePlate,
            deviceId: auth.user!.deviceId,
            transactions: auth.user!.transactions);

        toastification.show(
            alignment: Alignment.topCenter,
            autoCloseDuration: Duration(seconds: 3),
            type: ToastificationType.success,
            style: ToastificationStyle.fillColored,
            primaryColor: Colors.green);

        auth.setUser(updatedUser);
      } else {
        toastification.show(
            alignment: Alignment.topCenter,
            autoCloseDuration: Duration(seconds: 3),
            type: ToastificationType.error,
            style: ToastificationStyle.fillColored,
            primaryColor: Colors.red);
      }
      client.unsubscribe('user/updates');
    });
  } catch (e) {
    print("Exception $e");
    throw Error;
  }
}

void onConnected() {
  print("connected.");
}

void onDisconnected() {
  print("disconnected");
}

void onSubscribed(String topic) {
  print('subscribed to topic: $topic');
}

void onSubscribeFail(String topic) {
  print("Failed to subscribe to topic: $topic");
}

void onAutoReconnect() {
  print("auto reconnect sequence starting...");
}

void onAutoReconnected() {
  print("auto reconnect sequence completed successfully");
}
