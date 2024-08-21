const express = require('express');
const path = require('path');
const cors = require('cors');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const app = express();
const port = 5000;

// Middleware to handle static files
app.use(express.static(path.join(__dirname, 'web')));

// Middleware to parse JSON requests
app.use(express.json())
app.use(bodyParser.urlencoded({extended: true}));

// Enable CORS (Cross-Origin Resource Sharing)
app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  next();
});

// Connect to local database
mongoose.connect('mongodb://127.0.0.1:27017/iot_db');
const db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));
db.once('open', () => {
  console.log('Connected to MongoDB');
});

// --------------- DATABASE SCHEMAS -------------
// User Schema
// Device Schema
// Charging Policy Schema
// Toll Schema
// Transaction Schema

// User Schema
const userSchema = new mongoose.Schema({
  username: String, 
  password: String,
  email: String, 
  licensePlate: String,
  balance: {type: Number, default:10},
  device: {
    type: mongoose.Schema.Types.ObjectId,
    ref:'Device',
  },
  transactions: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Transaction'}]
});

// Device Schema
const deviceSchema = new mongoose.Schema({
  deviceId: String,
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
  },
});

// Charging Policy Schema
const chargingPolicySchema = new mongoose.Schema({
  zone: String,
  regions: [
    {
      name: String,
      prices: {
        '08-12': Number,
        '12-17': Number,
        '17-20': Number,
        '20-22': Number,
      },
    },
  ],
});

// Toll Schema
const tollSchema = new mongoose.Schema({
  zone: String,
  region: String,
  policy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'ChargingPolicy',
  },
});

// Transaction Schema
const transactionSchema = new mongoose.Schema({
    userId: {type: mongoose.Schema.Types.ObjectId, ref: 'User'},
    zone: String,
    tollName : String,
    timeStamp : Date,
    chargeAmount: Number,
});

// Crreate Database Models
const DeviceModel = mongoose.model('Device', deviceSchema);
const UserModel = mongoose.model('User', userSchema);
const ChargingPolicyModel = mongoose.model('ChargingPolicy', chargingPolicySchema)
const TollModel = mongoose.model('Toll', tollSchema);
const TransactionModel = mongoose.model('Transaction', transactionSchema);

// SAMPLE : Charging Policy Values
const sampleChargingPolicies = [
  {
    zone: 'Zone A',
    regions: [
      {name: 'Akti Dymaion', prices: {'08-12':1, '12-17':2, '17-20':3, '20-22': 4}},
      {name: 'Perivola', prices: {'08-12':5, '12-17':6, '17-20':7, '20-22': 8}},
      {name: 'Tei', prices: {'08-12':9, '12-17':10, '17-20':11, '20-22': 12}},
      {name: 'Rio', prices: {'08-12':13, '12-17':14, '17-20':15, '20-22': 16}},
    ],
  },
  {
    zone: 'Zone B',
    regions: [
      {name: 'Konpoleos', prices: {'08-12':0.1, '12-17':0.2, '17-20':0.3, '20-22': 0.4}},
      {name: 'AgAndreou', prices: {'08-12':0.5, '12-17':0.6, '17-20':0.7, '20-22': 0.8}},
      {name: 'Germanou', prices: {'08-12':0.9, '12-17':1, '17-20':1.1, '20-22': 1.2}},
      {name: 'OthAma', prices: {'08-12':1.3, '12-17':1.4, '17-20':1.5, '20-22': 1.6}},
    ],
  },
];

// Function to add SAMPLE data for transactions into database
const insertTransactions = async () => {
   try {
    // Delete existing transactions
    await TransactionModel.deleteMany();

    // Fetch exisitng users
    const user1 = await UserModel.findById('66c3a5439e5a33c3922e2333');
    const user2 = await UserModel.findById('66c3aa319e5a33c3922e23d3');

    // if (user1 || user2) {
    //   throw new Error('User not found');
    // }

    if (!(user1 || user2)) {
      throw new Error('User not found');
    }

    // Sample transactions for user (user)
    const user1Transactions = [
      {
        userId: '66c3a5439e5a33c3922e2333',        // userId       
        zone : 'Zone A',
        tollName : 'Akti Dymaion',
        timeStamp : new Date(),
        chargeAmount : 10,
      },
      {
        userId: '66c3a5439e5a33c3922e2333',
        zone : 'Zone B',
        tollName : 'Konpoleos',
        timeStamp : new Date(),
        chargeAmount : 20,
      },
    ];

    // Sample transactions for user (newuser123)
    const user2Transactions = [
      {
        userId: '66c3aa319e5a33c3922e23d3',
        zone : 'Zone A',
        tollName : 'Perivola',
        timeStamp: new Date(),
        chargeAmount : 5,
      },
      {
        userId: '66c3aa319e5a33c3922e23d3',
        zone : 'Zone B',
        tollName : 'Rio',
        timeStamp : new Date(),
        chargeAmount : 30,
      },
    ];

    // Insert transactions for user
    const insertedUser1 = await TransactionModel.insertMany(user1Transactions);
    // Insert transactions for newuser123
    const insertedUser2 = await TransactionModel.insertMany(user2Transactions);

    // Update users with the new transactions
    user1.transactions.push(...insertedUser1.map(transaction => transaction._id))
    user2.transactions.push(...insertedUser2.map(transaction => transaction._id))
    // Save updated users
    await user1.save();
    await user2.save();

    console.log('Transactions inserted and users updated successfully');
   } catch (error) {
    console.error('Error inserting transactions:', error);
   }
};

// Insert transactions into database
insertTransactions();



// Function to add SAMPLE data into database
const insertSampleData = async() => {
  try {
    // Clear existing
    await ChargingPolicyModel.deleteMany();
    await ChargingPolicyModel.insertMany(sampleChargingPolicies);
    console.log('Sample data inserted successfully');
  } catch (error) {
    console.error('Error inserting sample data', error);
  } 
};


// Insert Charging Policy into Database
insertSampleData();

// Function to insert SAMPLE Tolls to database
const insertTolls = async() => {
  try {

    await TollModel.deleteMany();

    // SAMPLE : Tolls
    const zonesAndRegions = [
      { zone: 'Zone A', region: 'Akti Dymaion' },
      { zone: 'Zone A', region: 'Perivola' },
      { zone: 'Zone A', region: 'Tei' },
      { zone: 'Zone A', region: 'Rio' },
      { zone: 'Zone B', region: 'Konpoleos' },
      { zone: 'Zone B', region: 'AgAndreou' },
      { zone: 'Zone B', region: 'Germanou' },
      { zone: 'Zone B', region: 'OthAma' },
    ];

    for (const {zone, region} of zonesAndRegions) {
      const toll = new TollModel({zone, region});
      await toll.save();
    }
    console.log('Tolls inserted successfully');
  } catch (error) {
    console.error('Error inserting the tolls', error);
  }
};

// Insert Tolls into database
insertTolls();


// ----------- ROUTING ----------
// ROUTES:
// login
// signup
// dashboard
// charge-policy
// history
// add-money

// MAIN page load
app.get('/', (req, res) => {
  //res.sendFile(__dirname + '/index.html');
  // main intro page to be loaded...
});

// LOGIN page load
app.get('/login', (req, res) => {
  //res.sendFile(__dirname + '/public/login.html');
  // login page to be loaded
});


// ***************


// Handle login page received values
app.post('/login', async (req, res) => {
  const credentials = req.body.credentials;
  const [username, password] = credentials.split(',');

  try {
    const user = await UserModel.findOne({username, password});
    if (user) {
        // find transactions related to the user
        // const transactions = await TransactionModel.find({userId});
        // combine user info and transactions
        // const userData = {
        //     user,
        //     transactions
        // };
      const userComplete = await UserModel.findById(user._id).populate('device').populate('transactions');
      // JSON with logged in user data with device
      console.log(userComplete);
      // JSON with logged in user data with transactions
      res.json(userComplete);
      // send logged in user data to DASHBOARD
      //res.render('dashboard', {user: userWithDevice});
    } else {
      res.send('Invalid credentials. Please try again');
    }
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).send('Error during login. Please try again.');
  }
});

// SIGN-UP page load
app.get('/signup', async (req, res) => {
  //res.sendFile(__dirname + '/public/signup.html');
  // SIGN-UP page to be loaded
});


// Handle SIGN-UP page values
app.post('/signup', async (req, res) => {
  registerId = 0;
  const {username, password, valPassword, email, licensePlate, deviceId} = req.body;

  // Validate Password
  if (password != valPassword) {
    return res.send('Password and password check do not match');
  }
  try {
    const newUser = new UserModel({
      username: username,
      password: password,
      email: email,
      licensePlate: licensePlate,
      balance: 10,
      device: null,
    });
    registerId = registerId + 1;
    const savedUser = await newUser.save();

    const newDevice = new DeviceModel({
      deviceId: req.body.deviceId,
      user: savedUser._id,
    });
    await newDevice.save();
    savedUser.device = newDevice._id;
    await savedUser.save();
    const userWithDevice = await UserModel.findById(savedUser._id).populate('device');
    // JSON with signed-up user data
    console.log(userWithDevice);
    res.json(userWithDevice);
    // send signed-up user data to DASHBOARD
    //res.render('dashboard', {user: userWithDevice});
  } catch (error) {
    console.error('Error signing up:', error);
    res.status(500).send('Error signing up. Please try again');
  }
});

// Authentication middleware
const authenticateUser = async (req, res, next) => {
  console.log('Authenctication middleware called');
  const isAuthenticated = true;
  if (isAuthenticated) {
    const username = req.body.username;
    // Fetch from database
    const user = await UserModel.findOne({username});
    if (user) {
      req.user = user;
      console.log(user);
      next();
    } else {
      res.status(404).send('User not found');
    }
  } else {
    res.redirect('/login');
  }
  };

// DASHBOARD page load
app.get('/dashboard', authenticateUser, async (req, res)=> { 
  try {
    const userWithDevice = await UserModel.findById(req.user._id).populate('device');
    console.log('userWithDevice:', userWithDevice);
    // Show User Info on Dashboard
    res.render('dashboard', {user: userWithDevice});
  } catch (error) {
    console.error('Error fetching user data', error);
    res.status(500).send('Internal Server Error');
  } 
});


// CHARGE-POLICY page load
app.get('/charge-policy', async (req, res) => {
  try {
    const chargingPolicies = await ChargingPolicyModel.find();
    console.log('Charging Policies:', chargingPolicies);
    chargingPolicies.forEach((policy) => {
      console.log('Charging Policy:', policy);
    });
    // JSON with all charging policies - for structure : => check SAMPLE Charging Policy
    console.log(chargingPolicies);
    res.json(chargingPolicies);
    // load charging policy to CHARGE-POLICY
    //res.render('charge-policy', {chargingPolicies});
  } catch (error) {
    console.error('Error fetching charging policies', error);
    res.status(500).send('Internal Server Error');
  }
});

// HISTORY page load
app.get('/history', async (req, res) => {
  // Prints on history all Toll instances of database
  // along with the prices that correspond to each of them
  // for each time period
  try {
      const tolls = await TollModel.find();

      const tollsWithPrices = [];
      for (const toll of tolls) {
          const chargingPolicy = await ChargingPolicyModel.findOne({
              zone: toll.zone,
              'regions.name': toll.region,
          });
          if (chargingPolicy && chargingPolicy.regions) {
              const region = chargingPolicy.regions.find((r) => r.name === toll.region);
              if (region && region.prices) {
                  const tollWithPrice = {
                      tollId: toll._id,
                      region: toll.region,
                      zone: toll.zone,
                      prices: region.prices,
                  };
                  tollsWithPrices.push(tollWithPrice);
              }
          }
      }
      console.log('tollsWithPrices:', tollsWithPrices);
      // load tolls with the right prices according to region on HISTORY
      res.render('history', { tolls, tollsWithPrices });
  } catch (error) {
      console.error('Error fetching tolls data', error);
      res.status(500).send('Internal Server Error');
  }
});


// ADD-MONEY for authenticated user
app.post('/add-money', async(req, res) => {
  const userId = req.body.userId;
  const amountToAdd = parseFloat(req.body.amount);
  try {
    //console.log(userId);
    const user = await UserModel.findById(userId).populate('device');
    //console.log(user);
    if (user) {
      user.balance += amountToAdd;
      //console.log("User balance:",user.balance);
      //console.log(user);
      const updatedBalance = user.balance;
      //console.log("Updated balance:",updatedBalance);
      // JSON of user data with updated balance
      //console.log('userWithDevice:', user);
      res.json({balance: updatedBalance});
      console.log("before save");
      console.log(user);
      await user.save();
      console.log("after save");
      console.log(user);
      // JSON of user data with updated balance
      console.log('userWithDevice:', user);
      res.json({balance: updatedBalance});
      // load updated user info on DASHBOARD
      // res.render('dashboard', {user: userWithDevice});
    } else {
      res.status(404).send('User not found');
    }
  } catch (error) {
    console.error('Error adding money:', error);
    res.status(500).send('Error adding money. PLease try again');
  }
});

// TOLL-PAYMENT
app.post('/toll-payment', async (req, res)=> {
    const {device_id, toll_id, timestamp} = req.body;
    try {
        const device = await DeviceModel.findOne({deviceId: device_id}).exec();
        if (!device) {
            return res.status(404).send({ message: 'Device not found' });
        }

        const user = await UserModel.findById(device.user).exec();
        if (!user) {
            return res.status(404).send({ message: 'User not found' });
        }

        const toll = await TollModel.findById(toll_id).exec();
        if(!toll) {
            return res.status(404).send({ message: 'Toll not found' });
        }

        const {zone, region, policy} = toll;
        const {hours} = extractTimezone(timestamp);
        const regionPolicy = policy.regions.find((r)=> r.name === region);
        const chargeAmount = calculateChargeAmount(regionPolicy, hours);

        const newTransaction = new TransactionModel({
            userId: user._id,
            zone,
            tollName: toll.name,
            timeStamp: timestamp,
            chargeAmount,
        });

        const savedTransaction = await newTransaction.save();
        user.transactions.push(savedTransaction._id);
        user.balance -= chargeAmount;
        await user.save();
        res.send({message:'Transaction processed', transaction: savedTransaction, balance: user.balance});
    } catch (error) {
        console.error(error);
        res.status(500).send({ message: 'Server error' });
      }
});

// Caclulate charge amount based on time and zone
function extractTimezone(timestamp) {
    const date = new Date(timestamp);
    return {hours: date.getHours()};
}

function calculateChargeAmount(regionPolicy, hours) {
    if (hours >= 8 && hours < 12) return regionPolicy.prices['08-12'];
    if (hours >= 12 && hours < 17) return regionPolicy.prices['08-12'];
    if (hours >= 17 && hours < 20) return regionPolicy.prices['08-12'];
    if (hours >= 20 && hours < 22) return regionPolicy.prices['08-12'];
    return 0;
}

// Backend Server listening on localhost 127.0.0.1 port 5000
app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
  });
