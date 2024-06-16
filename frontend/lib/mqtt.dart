import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';

Future<MqttBrowserClient?> mqttBrokerSetUp() async {
  try {
    var client = MqttBrowserClient('ws://localhost:9001','');
    client.websocketProtocols = ['mqtt'];
    client.port = 9001;
    client.keepAlivePeriod = 20;
    client.logging(on:false);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.onAutoReconnect = onAutoReconnect;
    client.onAutoReconnected = onAutoReconnected;

    final connMessage = MqttConnectMessage()
      .withClientIdentifier('frontend_client')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
    
    client.connectionMessage = connMessage;

      await client.connect();
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      print("Connected Succesfully");
    }
    else{
      print("Failed to Connect");
    }
    client.subscribe("backend/frontend",MqttQos.atLeastOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages){
      final topic = messages[0].topic;
      final message = messages[0].payload as MqttPublishMessage;
      final decoded = MqttPublishPayload.bytesToStringAsString(message.payload.message);
      print("!!!!Received message $decoded from topic: $topic");
    });
    
    return client;
  }
  catch (e){
    print("Exception $e");
    return null;
  }

}

class MqttDataProvider extends ChangeNotifier {
  String _decodedMsg = '';
  String get decodedMsg => _decodedMsg;

  void setMsg(String message) {
    _decodedMsg = message;
    notifyListeners();
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

