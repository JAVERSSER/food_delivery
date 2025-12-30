📦 Order Status FlowThe order progresses through 5 stages:
1. ⏳ Pending Payment (0 seconds) - Initial status when order is created
2. ✅ Order Confirmed (0 seconds) - Right after payment
3. 👨‍🍳 Preparing Your Food (10 seconds after confirmed)
4. 🚗 On The Way (20 seconds after confirmed)
5. 📦 Delivered (30 seconds after confirmed)

⏰ Timing Configuration

Currently in "order_tracking_page.dart", the status updates every 10 seconds.
Here's the code:

```

dartvoid _startStatusSimulation() {
  // Updates every 10 seconds
  _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
    if (_currentStep < 4) {
      setState(() {
        _currentStep++;
        // Status changes here
      });
    }
  });
}

```

How to run project in flutter?

1. Open terminal >> go to your directery or go to your folder >>then write this command -- flutter run --

2. If you want to run simulator andriod you must select simulator first. 
Step3 and Step4 will be explain you more and detail.

3. Using this command for run
    ```
    flutter clean    
    flutter pub get
    flutter run

    ```

4. Img example. ![alt text](image-1.png)
After you see and then you practice select you must run this command as below :
Using this command for run
    ```
    flutter clean    
    flutter pub get
    flutter run

    ```
+ Remember when you run on simulator you must run above command again because it is not auto refresh when you add the new line of code. So you need run again.
    ```
    flutter clean    
    flutter pub get
    flutter run

    ```

How to use git hup?

- git init ( using for initialize a new Git repository in your project folder.)
- git add .
- git commit -m "Init"
- git push

+ example add link with git hup
- git remote add origin https://github.com/JAVERSSER/food_delivery.git
We using this command because we not yet add link to git hup.
So this one is how to add link with git hup after that we can using command above
for add source code to git git hup.

+ How to clone project another one?
- git clone + link another one source code.


------------------------------------------------------
Thank you so much for reading. Appriciate you so much.
------------------------------------------------------