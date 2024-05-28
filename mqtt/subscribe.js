// Connect backend to broker
// Send data from broker to backend

const mqtt = require('mqtt');
const http = require('http');

// MQTT broker settings
const brokerAddress = "150.140.186.118"

const topic = 'iot/toll';             // !!

// Connect to the MQTT broker
const client = mqtt.connect('mqtt://' + brokerAddress);

client.on('connect', function() {
    client.subscribe(topic, function (err){
        if (err) {
            console.error('Error subscribing:', err);
        } else {
            console.log('Subscribed successfully to topic: ', topic);
        }
    });
});


// Handle incoming messages
client.on('message', function (topic, message) {
    // Convert message to string and split it
    const [device_id, toll_id, timestamp] = message.toString().split('/');
    // JSON with transaction info
    console.log('Receive message: ', {device_id, toll_id, timestamp});

})

// SEND DATA TO BACKEND

const postData = JSON.stringify({ device_id, toll_id, timestamp});
const options = {
    hostname: 'localhost',
    port: 5000,
    path: '/toll-payment',
    method: 'POST',
    headers: {
        'Content-Type' : 'application/json',
        'Content-Length': Buffer.byteLength(postData)
    }
};

// Create HTTP request
const req = http.request(options, (res) => {
    // Callback function to handle the response from the server
    console.log(`statusCode: ${res.statusCode}`);
});

// Error Handling
req.on('error', (error) => {
    console.error(error);
});

// Write JSON data to request body
req.write(postData);
req.end();






