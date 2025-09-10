 Here's a **complete `README.md`** you can use for your `stripe_payment_tutorial` project. It’s ready to copy and use:

---

# Stripe Payment Tutorial

A Flutter project demonstrating Stripe PaymentSheet integration with a Node.js backend.

---

## Prerequisites

* **Node.js** (v18+ recommended)
* **Flutter SDK**
* **Stripe account** (test mode)
* **Android/iOS emulator** or physical device

---

## Project Structure

```
stripe_payment_tutorial/
│
├─ server/             # Node.js backend
│   └─ index.js        # Creates Stripe PaymentIntent
│
├─ lib/                # Flutter app source
│   └─ main.dart
│   └─ api_calls.dart
│
└─ pubspec.yaml
```

---

## 1️⃣ Setup & Start Node.js Server

1. Navigate to the server folder:

```bash
cd server
```

2. Install dependencies:

```bash
npm install
```

3. Start the server:

**Option 1: Using Node**

```bash
node index.js
```

**Option 2: Using nodemon (auto-reload)**

```powershell
# If PowerShell prevents scripts, run first:
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
nodemon index.js
```

* The server will run on `http://localhost:3000`
* **Endpoint:** `POST /paymentIntent`
  **Body:** `{ "amount": 2000 }` (amount in smallest currency unit, e.g., cents)

---

### Node.js Server Example (cards only)

```js
const paymentIntent = await stripe.paymentIntents.create({
  amount: amount,                // in smallest currency unit
  currency: 'usd',               
  payment_method_types: ['card'],// strictly card
});
```

> **Important:** Keep your Stripe **Secret Key** on the server only. Never include it in Flutter app.

---

## 2️⃣ Run Flutter App

1. Navigate to the project root:

```bash
flutter pub get
flutter run
```

2. Make sure your emulator/device is running.

3. **Enter amount** in the app and click **Pay**.

> ⚠ Android Emulator: call Node server at `http://10.0.2.2:3000/paymentIntent`
> ⚠ iOS Simulator: call Node server at `http://localhost:3000/paymentIntent`

---

## 3️⃣ How It Works

1. Flutter app calls `ApiCalls.test(amount)`
2. Node.js server creates a Stripe **PaymentIntent** and returns `clientSecret`
3. Flutter initializes **PaymentSheet** with the clientSecret
4. User completes the payment
5. Payment result (success/failure) is returned in Flutter

---

## 4️⃣ Debugging

* **500 Error in Flutter**: Check Node console logs for Stripe errors
* Ensure **amount is an integer** (smallest currency unit)
* Make sure **server is running** before calling from Flutter

---

## 5️⃣ Notes

* **Cards only:** use `payment_method_types: ['card']` on the server
* **Flutter PaymentSheet** automatically detects available payment methods from server’s PaymentIntent
* Keep your **secret key secure**, never expose it in the client

---

## 6️⃣ Example Flutter API Call

```dart
Response response = await Dio().post(
  "http://10.0.2.2:3000/paymentIntent",
  data: {"amount": amount},
  options: Options(headers: {"Content-Type": "application/json"}),
);
final clientSecret = response.data["clientSecret"];
```

---

✅ Now you can run **Node server** first, then **Flutter app**, enter the amount, and test Stripe payments!

---


