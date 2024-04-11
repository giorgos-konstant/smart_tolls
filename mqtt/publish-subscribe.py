# TO-DO : Check for subscriber topic print

from paho.mqtt import client as mqtt_client
import time
import threading

broker = "150.140.186.118"
port = 1883
mqtt_client.connected_flag = False
topic = "python/mqtt"

# connect to MQTT
def connect_mqtt():
    # connect handler
    def on_connect(client, userdata, flags, rc):
        if (rc == 0):
            mqtt_client.connected_flag = True
            print("Connected to MQTT Broker - Returned code =", rc)
        else: 
            print("Failed to connect, return code: %d\n", rc)
    # mqtt_client.CallbackAPIVersion.VERSION1,
    client = mqtt_client.Client("client1")
    client.on_connect = on_connect
    client.connect(broker, port)
    return client

def publish(client):
    msg_count = 1
    while True:
        time.sleep(1)
        msg= f"messages: {msg_count}"
        result = client.publish(topic, msg)
        status = result[0]
        if status == 0:
            print(f"Send `{msg}` to topic `{topic}` ")
        else :
            print(f"Failed to send message to topic {topic}")
        msg_count += 1
        if msg_count > 5:
            print("Message Max Count Exceeded")
            break

def subscribe(client):
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

def main():
    print("Inside main loop")
    client = connect_mqtt()

    # Create thread for subscriber
    #sub_thread = threading.Thread(target=subscribe, args=(client,))
    #sub_thread.start()

    subscribe(client)
    time.sleep(10)
    client.publish(topic, "toll_id + timestamp")
    time.sleep(10)
    client.disconnect()
    # client.loop_start()
    # print("In wait loop")
    # time.sleep(4)
    # client.loop_stop()

if __name__ == "__main__":
    main()
