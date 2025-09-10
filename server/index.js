import bodyParser from 'body-parser';
import express from 'express';
import cors from 'cors';
import Stripe from 'stripe';

const stripePublishableKey = 'pk_test_51RyrKjQ9jf01yJkVx33FLn5LI1K4Xlva7IDlE0k4tAaiv2n6G8PUmJ0OXSdFr1E91KuA3MBvlmIwWaxt51UZdvPc00ywDlde04';
const stripeSecretKey = 'sk_test_51RyrKjQ9jf01yJkVGAa6VGLW0peY80YIKsgOarM2KURTGfgQunArpyjsgpJs5mIhpuYiuW6eoYc9XND1GsY5YHcf00VQUGBYv8';
const stripeWebhookSecret = '';

const app = express();

app.use(cors());
app.use(express.json());
const stripe = new Stripe(stripeSecretKey);

app.post("/paymentIntent", async (req, res) => {
    try {
        const { amount } = req.body;

        // if (!amount) {
        //     return res.status(400).json({ error: "Amount is required" });
        // }
        const paymentIntent = await stripe.paymentIntents.create({
            amount: amount,
            currency: 'usd',
            payment_method_types: ['card'],
            // automatic_payment_methods: {
            //     enabled: true,
            // },

        });
        res.json({ clientSecret: paymentIntent.client_secret, });
    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }
});

app.listen(3000, () => console.log("✅ Server running on http://localhost:3000"));


