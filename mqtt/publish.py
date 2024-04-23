from paho.mqtt import client as mqtt_client
import time
import random

broker = "localhost"
port = 1883
topic = "python/mqtt"
mqtt_client.connected_flag = False
client_id = f'publish-{random.randint(0, 1000)}'

def connect_mqtt():
    def on_connect(client,userdata,flags,rc,properties):
        if rc == 0:
            mqtt_client.connected_flag = True
            print("Connected to MQTT Broker - Returned code = \n", rc)
        else:
            print(f"Failed to connect, return code: {rc}\n")
         
    client = mqtt_client.Client(callback_api_version=mqtt_client.CallbackAPIVersion.VERSION2,
                                client_id=client_id)
    client.on_connect = on_connect
    client.connect(broker,port)
    return client

def publish(client):
    msg_count = 1
    try:
        while True:
            time.sleep(1)
            msg = f"messages: {msg_count}"
            result = client.publish(topic,msg)
            status = result[0]
            if status == 0:
                print(f"Send {msg} to topic {topic}")
            else:
                print(f"Failed to send message to topic {topic}")
            msg_count += 1
            if msg_count > 5:
                print("Message Max Count Exceeded")
                break
    finally:
        client.disconnect()
        client.loop_stop()

def run():
    print("Inside run-publish loop")
    client = connect_mqtt()
    client.loop_start()
    publish(client)
    


if __name__ == "__main__":
    run()

