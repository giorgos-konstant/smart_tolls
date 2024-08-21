const mqtt = require('mqtt')

// MQTT Client Setup
const mqttBroker = 'mqtt://localhost:1883';
const mqttTopic = 'user/updates';
const mqttClient = mqtt.connect(mqttBroker);

mqttClient.on('connect', () => {
    console.log('Connected to MQTT Broker');
});

const publishUpdate = (mqttData) => {
    return new Promise((resolve, reject) => {
        mqttClient.publish(mqttTopic, JSON.stringify(mqttData), {qos: 1}, (err) => {
            if (err){
                console.error('Failed to publish MQTT message:', err);
                reject(err);
            } else {
                console.log('MQTT message published successfully');
                resolve();
            }
        });
    });
};

module.exports = {
    publishUpdate
};