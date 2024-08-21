const mqtt = require('mqtt')
const EventEmitter = require('events');
const mqttClient = mqtt.connect('mqtt://localhost:1883');

const tolls = ['TEI', 'Konstantinoupoleos', 'Germanou', 'OthonosAmalias'];

const messageEmitter = new EventEmitter();
// Subscribe to all toll topics
mqttClient.on('connect', () => {
    tolls.forEach(toll => {
        const topic = `tolls/${toll}`;
        mqttClient.subscribe(topic, (err) => {
            if (err) {
                console.error(`Failed to susbscribe to topic ${topic}:`, err);
            } else {
                console.log(`Subscribed to topic ${topic}`);
            }
        });
    });
});

// Handle incoming messages
mqttClient.on('message', async (topic, message) => {
    try {
        const tollName = topic.split('/')[1];
        const payload = JSON.parse(message.toString());
        const {deviceId, timestamp} = payload;

        // Emit an event when a message is received
        messageEmitter.emit('tollMessage', {tollName, deviceId, timestamp});
    }
    catch (error) {
        console.error('Error processing message:', error);
    }
});

module.exports = messageEmitter;