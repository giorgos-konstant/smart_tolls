# TO-DO : Check for subscriber topic print

from paho.mqtt import client as mqtt_client
import time
import random

broker = "localhost"
port = 1883
client_id = f'subscribe--{random.randint(0,1000)}'
topic = "python/mqtt"

# connect to MQTT
def connect_mqtt() -> mqtt_client:
    # connect handler
    def on_connect(client, userdata, flags, rc,properties):
        if (rc == 0):
            print("Connected to MQTT Broker - Returned code =", rc)
        else: 
            print("Failed to connect, return code: %d\n", rc)
    # mqtt_client.CallbackAPIVersion.VERSION1,
    client = mqtt_client.Client(mqtt_client.CallbackAPIVersion.VERSION2,
                                client_id)
    client.on_connect = on_connect
    client.connect(broker, port)
    return client


def subscribe(client : mqtt_client):
    def on_message(client, userdata, msg):
        print(f"Received {msg.payload.decode()} ` from `{msg.topic}` topic")

    client.subscribe(topic)
    client.on_message = on_message

# def run():
#     print("Inside run loop")
#     client = connect_mqtt() # connect on MQTT 
#     # connect and publish a message
#     client.publish(topic, "toll_id + timestamp")
#     # subscribe infinitely
#     subscribe(client)
#     client.disconnect()

def run():
    print("Inside run-subscribe loop")
    client = connect_mqtt()
    subscribe(client)
    client.loop_forever()

    # Create thread for subscriber
    #sub_thread = threading.Thread(target=subscribe, args=(client,))
    #sub_thread.start()
    # client.loop_start()
    # print("In wait loop")
    # time.sleep(4)
    # client.loop_stop()

if __name__ == "__main__":
    run()
