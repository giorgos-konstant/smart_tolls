const express = require('express');
const app = express();

// Instance of MongoDB
const mongoose = require('mongoose');

// Express static files
app.use(express.static('public'));

// Middleware for JSON parsing
app.use(express.json());

// MOngoose connection to MongoDB
mongoose.connect('mongodb://localhost:27017/iot', {
    useUnifiedTopology: true,
    useNewUrlParser: true
});

// -------------- DATABSE SCHEMAS --------------
// User Schema
const userSchema = new mongoose. Schema({
    username: String,
    password: String,
    email: String,
    balance: Number,
    timestamp: {type: Date, default: Date.now},
    device: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Device'
    }
});

// Charging Policy Schema
const chargingPolicySchema = new mongoose.Schema({
    zone: Number,
    startDay: Date,
    endDay: Date,
    startTime: String,
    endTime: String,
    charge: Number
});

// Transaction Schema
const transactionSchehma = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    device: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Device'
    },
    charge: Number,
    zone: Number,
    toll: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Toll'
    },
    timestamp: {type: Date, default: Date.now}
});

// Device Schema
const deviceSchema = new mongoose.Schema({
    licensePlate: String, 
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    }
});

// Toll Schema
const tollSchema = new mongoose.Schema({
    zone: Number, 
    region: String,
    policy: {
        type: mongoose.Schema.Types. ObjectId,
        ref: 'ChargingPolicy'
    }
});

// Pass Schema
const passSchema = new mongoose.Schema({
    toll: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Toll'
    },
    device : {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Device'
    }
});

// Create Models
const UserModel = mongoose.model('User', userSchema);
const ChargingPolicyModel = mongoose.model('ChargingPolicy', chargingPolicySchema);
const TransactionModel = mongoose.model('Device', deviceSchema);
const TollModel = mongoose.model('Toll', tollSchema);
const PassModel = mongoose.model('Pass', passSchema);




// ---------------- ENDPOINTS ----------------

app.get('/', (req, res) => {
    res.send('Hello World');
});

// Log In Endpoint
app.post('/api/login', async (req,res) => {
    try {
        const {username, password} = req.body;
        const user = await UserModel.findOne({username, password}).populate('device');

        res.json({
            is_Authenticated: !!user,
            userData: {
                user
            }
        });
    } catch (err){
        console.error(err);
        res.status(500).json({error: 'Internal Server Error'});
    }
});

// Charging Policy Endpoint
app.get('/api/charging-policy', async (req, res) => {
    try{
        const chargingPolicy = await ChargingPolicyModel.find();
        res.json({
            chargingPolicyData: chargingPolicy,
        });
    } catch (err){
        console.error(err);
        res.status(500).json({error: 'Internal Server Error'});
    }
});

// History Endpoint
app.get('/api/history', async (req, res) => {
    try {
        const transactions = await TransactionModel.find();
        res.json({
            transactionData: transactions,
        });
    } catch(err){
        console.error(err);
        res.status(500).json({error: 'Internal Server Error'});
    }
});

// Add Money
app.post('/api/add-money', async (req, res) => {
    try {
        const {user_id, new_amnt} = req.body;
        const user = await UserModel.findById(user_id);
        if (user) {
            user.balance += new_amnt;
            await user.save();

            res.json({
                amnt_renewed: true
            });
        }
        else {
            res.json({
                newAmount: new_amnt, 
                isAmountRenewed: false
            });
        }
    } catch (err){
        console.error(err);
        res.status(500).json({ error: 'Internal Server Error'});
    }
});

// Sign up Endpoint
app.post('/api/signup', async (req, res) => {
    try {
        const {username, password, email} = req.body;
        const newUser = await UserModel.create({username, password, email});

        res.json({
            userData: newUser
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal Server Error'});
    }
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log('Server is running on port ${PORT}');
});
