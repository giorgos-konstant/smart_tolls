from paho.mqtt import client as mqtt_client
import time
import random
from datetime import datetime
import json

broker = "localhost"
port = 1883
tolls = ['Tei','Konpoleos','Germanou','OthAma']
topics = [f'tolls/{toll}' for toll in tolls]
print(topics)
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

def publish(client,fail):
    
    i=0
    try:
        while i<2:
            time.sleep(random.randint(1,3))
            # topic = random.choice(topics)
            topic = 'tolls/Tei'
            now = datetime.now()
            random_hour = random.randint(1,23)
            now = now.replace(hour=random_hour)
            json_msg = {
                "deviceId" : "45",
                "timestamp" : now.isoformat()
            }
            if fail:
                msg = "failed"
            else:
                msg = json.dumps(json_msg)
            result = client.publish(topic,msg)
            status = result[0]
            if status == 0:
                print(f"Send {msg} to topic {topic}")
            else:
                print(f"Failed to send message to topic {topic}")
            i+=1
    finally:
        client.disconnect()
        client.loop_stop()

def run():
    print("Inside run-publish loop")
    client = connect_mqtt()
    client.loop_start()
    publish(client,False)
    


if __name__ == "__main__":
    run()

