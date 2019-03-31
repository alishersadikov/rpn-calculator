## RPN Calculator
### Functionality
A command-line reverse Polish notation (RPN) calculator.

* The calculator uses standard input and standard output;
* It implements the following operators: + - * / % ** !;
* The calculator handles errors and recovers gracefully;
* The calculator exits when it receives a `q` command.

### Algorithm description

The RpnCalculator class encapsulates the code and logic needed for the evaluation of postfix expressions. It was intended to be orthogonal and decoupled from the runner script to make it easy to integrate with the other solutions. The algorithm it relies on is as simple as:
1. Initializing the stack as an array to store operands;
2. Scanning the given postfix expression and:
  * If the element is recognized as number/operand, pushing it into the stack;
  * If the element is an operator, extracting the last two elements, running the operation on them and pushing the result back into the stack.
3. When the expression ends, the last (and only) item in the stack is the final solution.

### Development background/workflow

The challenge was completed using TDD. Guard was used to watch the changes in the files to speed up the process.

Initially, the RpnCalculator was built in a more functional way and was a module. This decision was based on the following considerations:
* The goal seemed to be the transformation of data;
* Instantiating objects and maintaining the state did not seem like an important thing.

However, towards the end, some refactoring was done after the main requirements had been met and a working test suite had been built. It started making sense to turn it into a class, because:
* The initial expression passed in and the stack became important properties, which justified tracking their state and using that state within the instance;
* Object oriented approach allowed for smaller methods with less responsibilities instead of awkwardly passing the data around.

### Error handling

It made sense to build the following types of standard errors:
* InvalidExpressionError is raised if the expression is nil or if it is too short;
* InvalidArityError is raised if there is invalid mix of operands/operator;
* ParseError is raised if an element in the expression is neither recognized as operand/number, nor as a valid/implemented operator.

### How to run

#### On terminal (assuming Ruby and Bundler are installed):
* Clone from `https://github.com/alishersadikov/rpn-calculator`
* `cd rpn-calculator`
* `bundle install`
* To run tests:
 `ruby rpn_calculator_test.rb`
* To launch the REPL:
 `ruby rpn_calculator_runner.rb`

#### On a hosted web service:
* Go to `https://repl.it/@alishersadikov/RPN-Calculator`
* Click `Run` in the middle at the top (make sure main.rb is selected)
* The REPL launches on the right hand side

### Example Input/Output
Enter numbers and operators one at a time and enter `c` to run the calculation:
```
>> 5
 => 5
>> 8
 => 8
>> +
 => +
>> c
 => 13.0
```
```
>> 5
 => 5
>> 9
 => 9
>> 1
 => 1
>> -
 => -
>> /
 => /
>> c
 => 0.625
```

Or enter the whole expression at once and enter `c` to run the calculation:
```
>> 5 8 +
 => 5 8 +
>> c
 => 13.0
```
```
>> 5 9 1 - /
 => 5 9 1 - /
>> c
 => 0.625
```

Enter `q` to exit.

### Limitations
* Complexity. The RpnCalculator#evaluate method runs a loop for the expression and some operations on those elements. It is more efficient than having another nested loop. It is probably closest to O(nlogn) complexity.
