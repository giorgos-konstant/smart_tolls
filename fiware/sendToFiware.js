const mongoose = require('mongoose');
const axios = require('axios'); // Import axios

// Establish connection to MongoDB
mongoose.connect('mongodb://localhost:27018/'/*, {
    useNewUrlParser: true,
    useUnifiedTopology: true
}*/)
.then(() => {
    console.log('Connected to MongoDB');
})
.catch(err => {
    console.error('Error connecting to MongoDB:', err);
});

// Retrieve needed models
const { TollModel, TransactionModel } = require('../backend/backend.js');

// Retrieve all tolls
async function fetchTolls() {
    try {
        const tolls = await TollModel.find().exec();
        console.log(tolls);
        return tolls;
    } catch(error) {
        console.error('Error fetching tolls:', error);
        throw error;
    }
}

// Fetch transactions for specific toll
async function fetchTransactionsForToll(tollName) {         
    try {
        const transactions = await TransactionModel.find({ tollName }).exec();
        return transactions;
    } catch (error) {
        console.error('Error fetching transactions:', error);
        throw error;
    }
}

// Convert to FIWARE Entity
function convertToFiwareEntity(toll) {
    // Convert toll to FIWARE entity
    const tollEntity = {
        id: `urn:ngsi-ld:Toll:${toll._id}`,
        type: "Toll",
        region: {
            type: "Property",
            value: toll.region
        },
        zone: {
            type: "Property",
            value: toll.zone
        }
    };
    return tollEntity;
}
    // Convert transactions to FIWARE entities
//     const transactionEntities = (transactions || []).map(tx => ({
//         id: `urn:ngsi-ld:Transaction:${tx._id}`,
//         type: "Transaction",
//         tollName: {
//             type: "Property",
//             value: tx.tollName
//         },
//         chargeAmount: {
//             type: "Property",
//             value: tx.chargeAmount
//         },
//         timeStamp: {
//             type: "Property",
//             value: tx.timeStamp.toISOString()
//         },
//         // userId: {
//         //     type: "Relationship",
//         //     object: `urn:ngsi-ld:User:${tx.userId}`
//         // }
//     }));
    
//     return [tollEntity, ...transactionEntities];
// }

// Send to Orion Context Broker
async function sendToFiware(entity) {
    try {
        // Send to localhost Orion Broker
        const response = await axios.post('http://localhost:1026/v2/entities', entity, {
            headers: {
                'Content-Type': 'application/json',
                // 'Fiware-Service': 'openiot',
                // 'Fiware-ServicePath': '/'
            }
        });
        console.log('Entity created successfully:', response.data);
    } catch (error) {
        console.error('Error creating entity:', error.response ? error.response.data : error.message);
    }
}

// Process and send data to FIWARE
async function sendData() {
    try {
        const tolls = await fetchTolls();
        for (const toll of tolls) {
            //const transactions = await fetchTransactionsForToll(toll.region); 
            const entity = convertToFiwareEntity(toll);
            await sendToFiware(entity);
            }
        }
    catch (error) {
        console.error('Error processing and sending data:', error);
    }
}

// Initiate data transfer process
sendData();
