const mongoose = require('mongoose');
const axios = require('axios'); // Import axios

// Retrieve needed models
const { TollModel, TransactionModel } = require('../backend/backend.js');

// Establish connection to MongoDB
mongoose.connect('mongodb://localhost:27018/'/*, {
    useNewUrlParser: true,
    useUnifiedTopology: true
}*/)
.then(() => {
    console.log('Connected to Orion MongoDB');
})
.catch(err => {
    console.error('Error connecting to MongoDB:', err);
});

// Retrieve all tolls
async function fetchTolls() {
    try {
        const tolls = await TollModel.find().exec();
        console.log("FOUND TOLLS",tolls);
        return tolls;
    } catch(error) {
        console.error('Error fetching tolls:', error);
        throw error;
    }
}


// Retrieve all users with devices
async function fetchUsers() {
    try {
        return await UserModel.find().populate('device').populate('transactions').exec();  
    } catch (error) {
        console.log('Error fetching users: ', error);
        throw error;
    }
}

// // Convert Toll to FIWARE Entity
// function tollToFiwareEntity(toll) {
//     return {
//         id: `urn:ngsi-ld:Toll:${toll._id}`,
//         type: "Toll",
//         region: {
//             type: "Property",
//             value: toll.region
//         },
//         zone: {
//             type: "Property",
//             value: toll.zone
//         }
//     };
// }

// // Convert User to FIWARE Entity
// function userToFiwareEntity(user) {
//     return {
//         id: `urn:ngsi-ld:Toll:${user._id}`,
//         type: "User",
//         username: {
//             type: "Property", 
//             value: user.username
//         },
//         email: {
//             type: "Property",
//             value: user.email
//         },
//         licensePlate: {
//             type: "Property",
//             value: user.licensePlate
//         },
//         balance: {
//             type: "Property",
//             value: user.balance
//         }, 
//         role: {
//             type: "Property",
//             value: user.role
//         },
//         deviceId: {
//             type: "Property",
//             value: user.device ? user.device.deviceId: null
//         },
//         transactions: {
//             type: "Relationship",
//             object: user.transactions.map(txId => `urn:ngsi-ld:tRANSACTION:${txId}`)
//         }
//     };
// }

// // Convert Transaction to FIWARE Entity
// function transactionToFiwareEntity(transaction) {
//     return {
//     id: `urn:ngsi-ld:Transaction:${transactionDocument._id}`,
//     type: "Transaction",
//     amount: {
//         type: "Property",
//         value: transactionDocument.amount
//     },
//     timestamp: {
//         type: "Property",
//         value: transactionDocument.timestamp },
//     user: {
//         type: "Relationship",
//         object: `urn:ngsi-ld:User:${transaction.user._id}`
//     },
//     toll: {
//         type: "Relationship",
//         object: `urn:ngsi-ld:Toll:${transaction.toll._id}`
//         }
//     };
// }       


// // Send to Orion Context Broker
// async function sendToFiware(entity) {
//     try {
//         // Check if entity already exists
//         const checkResponse = await axios.get(`http://localhost:1026/v2/entities/${entity.id}`, {
//             headers: {
//                 'fiware-Service': 'openiot',
//                 'Fiware-ServicePath': '/'
//             }
//         });

//         if (checkResponse.stauts === 200) {
//             const updateResponse = await axios.patch(`http://localhost:1026/v2/entities/${entity.id}/attrs`, entity, {
//                 headers: {
//                     'Content-Type': 'application/json',
//                     'Fiware-Service': 'openiot',
//                     'Fiware-ServicePath': '/'
//                 }
//             });
//             console.log('Entity updated successfully:', udpateResponse.data);
//         }
//     } catch (error) {
//         // If the entity does not exist, create it
//         if (error.response && error.reponse.status === 404) {
//             try {
//                 const createResponse = await axios.post('http://localhost:1026/v2/entities', entity, {
//                     headers: {
//                         'Content-Type': 'application/json',
//                         'Fiware-Service': 'openiot',
//                         'Fiware-ServicePath': '/'
//                     }
//                 });
//                 console.log('Entity created sucessfully:', createResponse.data);
//             } catch (createError) {
//                 console.error('Error creating entity:', createError.response ? createError.response.data: error.message);
//             }
//         } else {
//             console.error('Error checking entity existence:', error.response ? error.response.data : error.message);
//         }
//     }
// }

// Process and send data to FIWARE
// async function sendData() {
//     try {
//         const tolls = await fetchTolls();
//         for (const toll of tolls) {
//             const tollEntity = tollToFiwareEntity(toll);
//             await sendToFiware(tollEntity);
//         }

//         const users = await fetchUsers();
//         for (const user of users) {
//             const userEntity = userToFiwareEntity(user);
//             await sendToFiware(userEntity);
//         }
//     } catch (error) {
//         console.error('Error processing and sending data:', error);
//     }
// }


// Subscription to Transaction entity
const subscription = {
    description: "Notify changes of transactions related to users",
    subject: {
        entites: [
            { idPattern: "urn:ngsi-ld:Transaction:.*", type: "Transaction"}
        ],
        condition: {
            attrs: ["amount", "timestamp", "user", "toll"]
        }
    },
    notification: {
        http: {
            url: "http://localhost:5000/notifications"  // endpoint to handle notifications
        },
        attrs: ["amount", "timestamp", "user", "toll"]
    },
    expires: "2040-01-01T14:00:00.00Z",
    throttling: 5
};

axios.post('http://localhost:1026/v2/subscriptions', subscription, {
    headers: {
        'Content-Type': 'application/json',
        'Fiware-Service': 'openiot',
        'Fiware-ServicePath': '/'
    }
}).then(response => {
    console.log('Susbcription created successfully:', response.data);
}).catch(error => {
    console.error("Error creating subscription: ", error.reponse ? error.reponse.data : error.message);
});


// Fetch transactions for specific toll
// async function fetchTransactionsForToll(tollName) {         
//     try {
//         const transactions = await TransactionModel.find({ tollName }).exec();
//         return transactions;
//     } catch (error) {
//         console.error('Error fetching transactions:', error);
//         throw error;
//     }
// }

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

function delay(ms) {
    return new Promise(resolve => setTimeout(resolve,ms));
}
