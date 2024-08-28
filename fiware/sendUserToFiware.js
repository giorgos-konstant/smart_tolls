const axios = require('axios');

const userDocument = {
    username: "ioanna",
    password: "1234",
    email: "jognkp@gmail.com",
    licensePlate: "ABC123",
    balance: 10,
    device: "opgohkjphok",
    transactions: ["oijdtoi", "idteriodtj"]
};

// Convert to FIWARE entity
const userEntity = {
    id: `urn:ngsi-ld:User:${userDocument._id}`,
    type: "User",
    username: {
      type: "Property",
      value: userDocument.username
    },
    password: {
      type: "Property",
      value: userDocument.password
    },
    email: {
      type: "Property",
      value: userDocument.email
    },
    licensePlate: {
      type: "Property",
      value: userDocument.licensePlate
    },
    balance: {
      type: "Property",
      value: userDocument.balance
    },
    device: {
      type: "Relationship",
      object: `urn:ngsi-ld:Device:${userDocument.device}`
    },
    transactions: {
      type: "Relationship",
      object: userDocument.transactions.map(txId => `urn:ngsi-ld:Transaction:${txId}`)
    }
  };

  // Send the entity to the Orion Context Broker
  axios.post('http://localhost:1026/v2/entities', userEntity, {
    headers: {
        'Content-Type': 'application/json',
        'Fiware-Service': 'openiot',
        'Fiware-ServicePath': '/'
      }
  }).then(response => {
    console.log('User entity created successfully:', response.data);
  }).catch(error => {
    console.error('Error creating user entity: ', error.response ? error.response.data : error.message);
  });