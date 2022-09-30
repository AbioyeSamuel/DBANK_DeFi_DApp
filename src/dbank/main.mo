import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue : Float = 300;
  currentValue := 300;
  Debug.print(debug_show(currentValue));


  let testKnowledge = "We are great";

  // Time rendering in motoko
  stable var startTime = Time.now();
  startTime := Time.now();
  Debug.print(debug_show(startTime));

// let vs var - let is used to hold data that is not changing. NB: (":=") will not work to change the value of the lete in the future, so use let when value stored does not require to be updated or changed later on.
// E.g let id = 345623;
// id := 2345467;   Know that this code will not work. Rather use var when you intend to update or change the value of the data type.

  // Debug.print(debug_show(testKnowledge));
  // Debug.print(debug_show(currentValue));


// Private function to public with "public" keyword 
  public func topUp (amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  // topUp();

  public func withdraw(amount: Float){
    let tempValue : Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("currentValue is less than amount");
    }
  };

// Query (ultra fast read only) calls instead of update as done above. Much faster compared to the update call.
  public query func checkBalance(): async Float {
    return currentValue;
  };

  // withdraw();

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };
}