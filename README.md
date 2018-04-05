:heavy_exclamation_mark: This language description isn't completed yet, other language specifications will be added soon. If you have an idea for a new feature, feel free to send a PR. For now the code syntax highlighting language is Swift, because it's syntax is very similar. Also I want to thank Faiçal Tchirou, who wrote the very good tutorial [Let’s Build a Programming Language](https://hackernoon.com/lets-build-a-programming-language-2612349105c6), which mainly inspired me.

# Fly
## New programming language inspired mainly by Swift, but also other languages like Python. It'll be written in Swift.

### Contents:

1. [Data Types](#data-types)
2. [Comments](#comments)
3. [Semicolons](#semicolons)
4. [Constants and Variables](#constants-and-variables)
5. [Tuples](#tuples)
6. [Optionals](#optionals)
7. [Conditional Statements](#conditional-statements)
	* [if-elif-else](#if-elif-else)
	* [switch](#switch)
8. [Loops](#loops)
	* [for-in](#for-in)
	* [while](#while)
9. [Functions](#functions)
	* [Defining and Calling](#defining-and-calling)
	* [Functions with return values](#functions-with-return-values)
	* [Function parameters](#function-parameters)
	* [Function body](#function-body)
	* [Functions without return values](#functions-without-return-values)
10. [Classes](#classes)
	* [Defining and Instantiating](#defining-and-instantiating)
	* [Properties](#properties)
	* [Initializers](#initializers)
	* [Computed Properties](#computed-properties)
	* [Methods](#methods)
	* [Private Properties and Methods](#private-properties-and-methods)
	* [Inheritance](#inheritance)
	* [Inheritance from Object Class](#inheritance-from-object-class)
	* [Defining Operators](#defining-operators)
	* [Operator overloading](#operator-overloading)
11. [Everything is an Object](#everything-is-an-object)

---
### Data types

Fly supports values of many familiar types like:
 
1. numeric types
	* `Int` (integer number, e.g. `52`)
	* `Float` (single-precision floating point number, e.g. `2.8`)
	* `Double` (double-precision floating point number, e.g. `0.5`)
	* `Range`(interval over another numeric type, e.g. `1...5`)
2. string and character types
	* `String` (series of Unicode characters, e.g. `"Hello World"`)
	* `Char` (single Unicode character, e.g. `` `A` `` (with backticks))
3. collection types
	* `Array` (ordered list of values of the same type, e.g. `[1, 5, 5, 8]`, values can be assecced via subscription syntax)
	* `Dictionary` (unordered collection of values of the same type, each associated with a unique key of the same type, e.g. `["x": 12, "y": 15]`, values can be assecced via subscription syntax)
4. `Bool` (boolean value, has two possible values: `true` and `false`)
5. `Void` (returned by a function, which returns no value)

Every type in Fly inherits from a supertype `Object`.

Fly also supports Optional types which are described [later](#optionals).

---
### Comments

Comments in Fly are very similar to comments in C. Single-line comments begin with two forward-slashes (`//`):

```swift
// This is a comment.
```
Multiline comments start with a forward-slash followed by an asterisk (`/*`) and end with an asterisk followed by a forward-slash (`*/`):

```swift
/* This is also a comment
but is written over multiple lines. */
```

---
### Semicolons

Unlike many other languages, Fly doesn’t require you to write a semicolon after each statement in your code, although you can do so if you wish. However, semicolons are required if you want to write multiple separate statements on a single line:

```swift
let cat = "🐱"; print(cat)
//Prints "🐱"
```

---
### Constants and Variables

You declare constants with the `let` keyword and variables with the `var` keyword. The value of a constant can’t be changed once it’s set. 
>**Note:** If a stored value in your code won’t change, always declare it as a constant with the `let` keyword. Use variables only for storing values that need to be able to change:

```swift
var variable = 2
//Type infered to be an Int
let constant = "Hello"
//Type infered to be a String

variable = 3
//variable is now 3
constant = "Hello World!"
//This is a compile-time error, because constant cannot be changed
```
Fly is a type-safe language so you can't set another type to a already declared variable:

```swift
var number = 3
//Type infered to be an Int
number = "Not a number"		
//This is a compile-time error, because you can't set a variable of type Int to a String
```
You can provide a *type annotation* when you declare a constant or variable, to be clear about the type of values the constant or variable can store. Write a type annotation by placing an '@' after the constant or variable name, followed by the name of the type to use. This is rarely needed, for example when you want to declare a variable of type `Float` instead of `Double`:

```swift
let double = 5.0
//Type infered to be a Double
let float@Float = 5.0
//float is of type Float
```
You can declare multiple constants or multiple variables on a single line, separated by commas:

```swift
var x = 0, y = 0, z = 0
//x, y and z are all of type Int and have each the value 0
```
If all values of this constants or variables are the same, you can omit all declarations except the last, so the example above can be written as:

```swift
var x, y, z = 0
//x, y and z are all of type Int and have each the value 0
```
The same works also with *type annotations*:

```swift
var x, y, z@Float = 5.0
//x, y and z are all of type Float and have each the value 5.0
```
You can print the current value of a constant or variable with the `print(_:separator:terminator:)` function:

```swift
let string = "Hello World!"
print(string)
//Prints "Hello World!"
```
Fly uses *string concatenation* to join many strings to one. You can also concatenate other objects than strings, like integers, into a string (how this works is described in more detail [here](#inheritance-from-object-class)):

```swift
let string = "World"
print("Hello " + string + "!")
//Prints "Hello World!"

let numberOfSandwiches = 2
print("I eat " + numberOfSandwiches + " sandwiches at breakfast.")
//Prints "I eat 2 sandwiches at breakfast."
```

---
### Tuples

Tuples group multiple values into a single compound value. The values within a tuple can be of any type and don’t have to be of the same type as each other. You can create tuples from any permutation of types, and they can contain as many different types as you like. There’s nothing stopping you from having a tuple of type `(Int, Int, Int)`, or `(String, Bool)`, or indeed any other permutation you require. You can set the type of the tuple exactly like with normal variables, if you have in the tuple many values of the same type (e.g. `(Double, Double, Double)`), you can set the number of values with an asterisk followed by th number (e.g. `*3`):

```swift
let http404Error = (404, "Not Found")
//Type infered to be (Int, String)
let xyzCoordinate@(Float*3) = (15.0, 20.0, 10.0)
//xyzCoordinate is of type (Float, Float, Float), instead of (Double, Double, Double)
let customTuple@(String*2, Int*2) = ("Hello", "World", 2, 3)
//customTuple is of type (String, String, Int, Int), which would also have been infered
```

You can decompose a tuple’s contents into separate constants or variables, which you then access as usual:

```swift
let xyzCoordinate = (15.0, 20.0, 10.0)
//xyzCoordinate is of type (Double, Double, Double)
let (x, y, z) = xyzCoordinate
//x, y, z are now each of type Double
print("x: " + x)
//Prints "x: 15.0"
print("y: " + y)
//Prints "y: 20.0"
print("z: " + z)
//Prints "z: 10.0"
```
Alternatively, access the individual element values in a tuple using index numbers starting at zero:

```swift
let http404Error = (404, "Not Found")
//Type infered to be (Int, String)
print("The status code is " + http404Error.0)
//Prints "The status code is 404"
print("The status message is " + http404Error.1)
//Prints "The status message is Not Found"
```
Also you can name the individual elements in a tuple when the tuple is defined:

```swift
let http200Status = (statusCode: 200, description: "OK")
//Type infered to be (Int, String)
print("The status code is " + http200Status.statusCode)
//Prints "The status code is 200"
print("The status message is " + http200Status.description)
//Prints "The status message is OK"
```

---
### Optionals

You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all.

Here’s an example of how optionals can be used to cope with the absence of a value. Fly’s `Int` type has an initializer which tries to convert a `String` value into an `Int` value. However, not every string can be converted into an integer. The string `"123"` can be converted into the numeric value `123`, but the string `"hello, world"` doesn’t have an obvious numeric value to convert to.

The example below uses the initializer to try to convert a String into an Int (see [Initializers](#initializers) for a description of initializers and initializer syntax):

```swift
let possibleNumber = "123"
let convertedNumber = new Int(possibleNumber)
//Type inferred to be "Int?", or "optional Int"
```
Because the initializer might fail, it returns an optional Int, rather than an Int. An optional Int is written as Int?, not Int. The question mark indicates that the value it contains is optional, meaning that it might contain some Int value, or it might contain no value at all. (It can’t contain anything else, such as a Bool value or a String value. It’s either an Int, or it’s nothing at all.)

You set an optional variable to a valueless state by assigning it the special value nil:

```swift
var serverResponseCode@Int? = 404
//serverResponseCode contains an actual Int value of 404
serverResponseCode = nil
//serverResponseCode now contains no value, but is still of type Int?
```

If you define an optional variable without providing a default value, the variable is automatically set to nil for you:

```swift
var surveyAnswer@String?
// surveyAnswer is automatically set to nil
```

If you are sure, that an optional variable contains a value, you can *force-unwrap* it and get the value:

```swift
var optionalInteger@Int? = 25

print(optionalInteger)
//Prints "Optional(25)", because the value is wrapped in the optional container

print(optionalInteger!)
//Prints "25"

optionalInteger = nil
print(optionalInteger!)
//Runtime-Error, because you cannot force-unwrap an Optional, which is nil
```
You can read more options of unwrapping an Optional in the [if-elif-else](#if-elif-else) section.

---
### Conditional Statements
* #### if-elif-else

	In Fly conditions are expressed using an `if-elif-else` expression:
	
	```swift
	let firstBool = false
	let secondBool = false
	if firstBool {
		print("first Bool was true")
	} elif secondBool {
		print("second Bool was true")
	} else {
		print("both were false")
	}
	//Prints "both were false"
	```
	If there is only one expression in an `if`, `elif` or `else` block, you can omit the curly braces and write the expression after a colon, so the example above can be written as:
	
	```swift
	let firstBool = false
	let secondBool = false
	if firstBool: print("first Bool was true")
	elif secondBool: print("second Bool was true")
	else: print("both were false")
	//Prints "both were false"
	```
	
	Of course you can add more `elif` expressions and also omit completely the `elif` and/or `else` blocks. Also you can add other boolean expressions than variables to the condition of an `if` or `elif` expression:
	
	```swift
	let number = 2
	if number >= 1 && number <= 5: print("number is between 1 and 5")
	//Prints "number is positive"
	```
	
	Another usecase of the `if-else` expression is the work with Optionals, as a safe *force-unwrap*:
	
	```swift
	var optionalInteger@Int? = 25
	if optionalInteger != nil: print(optionalInteger!)
	else: print("optionalInteger was nil")
	//Prints "25"
	```
	
	or as the so-called *optional binding*. You use *optional binding* to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable:
	
	```swift
	var optionalInteger@Int? = 25
	if let unwrappedInteger = optionalInteger: print(unwrappedInteger)
	else: print("optionalInteger was nil")
	//Prints "25"
	```
	
	This code can be read as:
	
	"If `optionalInteger` contains a value, set a new constant called `unwrappedInteger` to the value contained in the optional and set the condition of the `if` block to `true`."
	
	If the conversion is successful, the `unwrappedInteger` constant becomes available for use within the first branch of the `if` statement. It has already been initialized with the value contained within the optional, and so there’s no need to use the `!` suffix to access its value.
	
	You can use both constants and variables with optional binding. If you wanted to manipulate the value of `unwrappedInteger` within the first branch of the if statement, you could write `if var unwrappedInteger` instead, and the value contained within the optional would be made available as a variable rather than a constant.
	
	You can include as many optional bindings and Boolean conditions in a single `if` statement as you need to, separated by commas. If any of the values in the optional bindings are `nil` or any Boolean condition evaluates to `false`, the whole `if` statement’s condition is considered to be false. The following `if` statements are equivalent:
	
	```swift
	if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
	    print(firstNumber + " < " + secondNumber + " < 100")
	}
	// Prints "4 < 42 < 100"
	 
	if let firstNumber = Int("4") {
	    if let secondNumber = Int("42") {
	        if firstNumber < secondNumber && secondNumber < 100 {
	            print(firstNumber + " < " + secondNumber + " < 100")
	        }
	    }
	}
	// Prints "4 < 42 < 100"
	```

	---
* #### switch
	
	A `switch` statement considers a value and compares it against several possible matching patterns. It then executes an appropriate block of code, based on the first pattern that matches successfully. A `switch` statement provides an alternative to the `if` statement for responding to multiple potential states.

	In its simplest form, a `switch` statement compares a value against one or more values of the same type.
	
	```swift
	let character = `z`
	//Type infered to be an Char
	switch character {
	case `a`:
		print("It's the first letter of the alphabet")
	case `b`:
    	print("It's the second letter of the alphabet")
	case `z`:
		print("It's the last letter of the alphabet")
	default:
    	print("It's something else")
	}
	```
	Like the body of an `if` statement, each `case` is a separate branch of code execution. The `switch` statement determines which branch should be selected. This procedure is known as switching on the value that is being considered.

	Every `switch` statement must be *exhaustive*. That is, every possible value of the type being considered must be matched by one of the `switch` cases. If it’s not appropriate to provide a case for every possible value, you can define a default case to cover any values that are not addressed explicitly. This default case is indicated by the `default` keyword, and must always appear last.

	Values in `switch` cases can be checked for their inclusion in a `Range`. This example uses number intervals to provide a natural-language count for numbers of any size:
	
	```swift
	let approximateCount = 62
	let countedThings = "moons orbiting Saturn"
	let naturalCount@String
	switch approximateCount {
	case 0:
    	naturalCount = "no"
	case 1..<5:
    	naturalCount = "a few"
	case 5..<12:
    	naturalCount = "several"
	case 12..<100:
    	naturalCount = "dozens of"
	case 100..<1000:
    	naturalCount = "hundreds of"
	default:
    	naturalCount = "many"
	}
	print("There are " + naturalCount + countedThings + ".")
	// Prints "There are dozens of moons orbiting Saturn."
	```
	In the above example, `approximateCount` is evaluated in a `switch` statement. Each `case` compares that value to a number or interval. Because the value of `approximateCount` falls between 12 and 100, `naturalCount` is assigned the value `"dozens of"`, and execution is transferred out of the `switch` statement.

---
### Loops
* #### for-in

	You use the `for-in` loop to iterate over a collection, such as items in an array or characters in a string.

	This example uses a `for-in` loop to iterate over the items in an array:

	```swift
	let names = ["Anna", "Alex", "Brian", "Jack"]
	//Array of type [String]
	for name in names {
    	print("Hello, " + name + "!")
	}
	//Prints "Hello, Anna!"
	//Prints "Hello, Alex!"
	//Prints "Hello, Brian!"
	//Prints "Hello, Jack!"
	```
	
	Of course you can also in a `for-in` loop omit the curly braces, if there is only one expression in the body:
	
	```swift
	let names = ["Anna", "Alex", "Brian", "Jack"]
	//Array of type [String]
	for name in names: print("Hello, " + name + "!")
	//Prints "Hello, Anna!"
	//Prints "Hello, Alex!"
	//Prints "Hello, Brian!"
	//Prints "Hello, Jack!"
	```
	You can also iterate over a dictionary to access its key-value pairs. Each item in the dictionary is returned as a `(key, value)` tuple when the dictionary is iterated, and you can decompose the `(key, value)` tuple’s members as explicitly named constants for use within the body of the `for-in` loop. In the code example below, the dictionary’s keys are decomposed into a constant called `animalName`, and the dictionary’s values are decomposed into a constant called `legCount`.

	```swift
	let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
	//Dictionary of type [String: Int]
	for (animalName, legCount) in numberOfLegs: print(animalName + "s have " + legCount + " legs")
	//Prints "ants have 6 legs"
	//Prints "spiders have 8 legs"
	//Prints "cats have 4 legs"
	```
	The contents of a `Dictionary` are inherently unordered, and iterating over them does not guarantee the order in which they will be retrieved. In particular, the order you insert items into a `Dictionary` doesn’t define the order they are iterated.
	
	You can also use `for-in` loops with numeric ranges. This example prints the first few entries in a five-times table:
	
	```swift
	for index in 1...5: print(index + " times 5 is " + (index * 5))
	//Prints "1 times 5 is 5"
	//Prints "2 times 5 is 10"
	//Prints "3 times 5 is 15"
	//Prints "4 times 5 is 20"
	//Prints "5 times 5 is 25"
	```

	---
* #### while
	
	A `while` loop performs a set of statements until a condition becomes `false`:
	
	```swift
	var index = 1
	while index <= 5 {
		print(index + " times 5 is " + (index * 5))
		index += 1
	}
	//Prints "1 times 5 is 5"
	//Prints "2 times 5 is 10"
	//Prints "3 times 5 is 15"
	//Prints "4 times 5 is 20"
	//Prints "5 times 5 is 25"
	```
	
	As with the `if-elif-else` expression and the `for-in` loop you can omit the curly braces, if there is only one expression in the body.
	
---
### Functions

* #### Defining and Calling

	Functions are defined using the `func` keyword. Function parameters in Fly are separated by commas and enclosed in parenthesis (e.g. `(a@Int, b@Int)`). Each parameter is defined by its name, followed by a '@', followed by its type (e.g. `a@Int`). The return type is defined by adding a '@' followed by the type of the value returned by the function after the parameter list. You can call the function with its name, followed by the parameter parenthesis in which every parameter is set.
	
	```swift
	func sum(a@Int, b@Int)@Int {
	    return a + b
	}
	
	let sumOfTwoNumbers = sum(a = 5, b = 7)
	print(sumOfTwoNumbers)
	//Prints "12"
	```

	---
* #### Functions with return values
	
	Normally a function returns a value with the keyword `return`, followed by a space, followed by the value, but if only the last expression of the body returns a value, it can be omitted. So the example above can be written as:
	
	```swift
	func sum(a@Int, b@Int)@Int {
	    a + b
	    //Returned, because it's the last expression
	}
	
	let sumOfTwoNumbers = sum(a = 5, b = 7)
	print(sumOfTwoNumbers)
	//Prints "12"
	```
	Of course a function can return every value including tuples:
	
	```swift
	func getSquareAndCubeOfNumber(_ number@Int)@(Int, Int) { //could also have been written @(Int*2)
		let square = number * number
		let cube = number * number * number
		(square, cube)
	    //Returned, because it's the last expression
	}
	
	let number = 3
	let (square, cube) = getSquareAndCubeOfNumber(number)
	print("The square of " + number + " is " + square)
	//Prints "The square of 3 is 9"
	print("The cube of " + number + " is " + cube)
	//Prints "The cube of 3 is 27"
	```

	---
* #### Function parameters

	You can omit an parameter name if you add an underscore (`_`), followed by a space in the parameter list before the parameter name:
	
	```swift
	func sum(_ a@Int, b@Int)@Int {
	    a + b
	    //Returned, because it's the last expression
	}
	
	let sumOfTwoNumbers = sum(5, b = 7)
	print(sumOfTwoNumbers)
	//Prints "12"
	```
	or even:
	
	```swift
	func sum(_ a@Int, _ b@Int)@Int {
	    a + b
	    //Returned, because it's the last expression
	}
	
	let sumOfTwoNumbers = sum(5, 7)
	print(sumOfTwoNumbers)
	//Prints "12"
	```
	You can define a default value for any parameter in a function by assigning a value to the parameter after that parameter’s type. If a default value is defined, you can omit that parameter when calling the function:
	
	```swift
	func greet(_ name@String = "George")@String {
		"Hello " + name + "!"
	    //Returned, because it's the last expression
	}
	
	let greeting1 = greet()
	print(greeting1)
	//Prints "Hello George!"
	
	let greeting2 = greet("Hans")
	print(greeting2)
	//Prints "Hello Hans!"
	```

	---
* #### Function body
	
	Of course you can also omit the curly braces, when there is only one expression in the body. The example above can be written like:
	
	```swift
	func greet(_ name@String = "George")@String: "Hello " + name + "!"
	
	let greeting1 = greet()
	print(greeting1)
	//Prints "Hello George!"
	
	let greeting2 = greet("Hans")
	print(greeting2)
	//Prints "Hello Hans!"
	```

	---
* #### Functions without return values
	
	If the function does not return a value, the return type has to be `Void`:
	
	```swift
	func greet(_ name@String)@Void: print("Hello " + name + "!")
	
	greet("Hans")
	//Prints "Hello Hans!
	```
	
	However, as a syntactic sugar, if a function does not declare any return type, Fly will automatically assume that the return type is `Void`. So the previous example could be written as follows:
	
	```swift
	func greet(_ name@String): print("Hello " + name + "!")
	
	greet("Hans")
	//Prints "Hello Hans!
	```

---
### Classes

* #### Defining and Instantiating

	Classes are defined using the `class` keyword:
	
	```swift
	class Person {
	}
	```
	This defines a very simple class `Person`. Instances of the class `Person` can now be easily created using the initializer syntax:
	
	```swift
	class Person {
	}
	
	let p = new Person()
	//p is now of type Person
	```

	---
* #### Properties
	
	A class can have one or more properties declared with the keyword `var` like variables, which can be accessed using the *dot syntax*:
	
	```swift
	class Person {
		var firstname = "Frank"
		var lastname = "Müller"
		var age = 45
	}
	
	let p = new Person()
	print(p.firstname + " " + p.lastname + ", " + p.age + " years old")
	//Prints "Frank Müller, 45 years old"
	```

	---
* #### Initializers
	
	Inside of a class you can access the properties via the keyword `self`, which is equivalent to the instance of the class. Normally you want to set the properties at the initializing of an instance of a class. This can be done with a custom initializer. It's written with the keyword `init` followed by a parameter list in parenthesis. You don't specify a return type and also don't return a value, but it implicitly returns an instance of the class. It has to set all of the properties of the class. Your class can implement many initializers, but they all must have different parameters:
	
	```swift
	class Person {
		var firstname, lastname@String
		//firstname and lastname are both of type String
		var age@Int
		
		init(firstname@String, lastname@String, age@Int) {
			self.firstname = firstname
			self.lastname = lastname
			self.age = age
		}
	}
	
	let p = new Person(firstname = "Donald", lastname = "Duck", age = 40)
	//is equal to
	//let p = Person.init(firstname = "Donald", lastname = "Duck", age = 40)
	
	print(p.firstname + " " + p.lastname + ", " + p.age + " years old")
	//Prints "Donald Duck, 40 years old"
	```
	An initializer can be failable, that means, he returns an Optional instance of the class. Write the keyword `failable` before the `init`, to say, that it's a failable initializer. Then you can inside of the initializer body return nil, if the class can't be initialized:
	
	```swift
	class Animal {
		var species@String
		
		failable init(species@String) {
			if species.isEmpty: return nil
			//isEmpty is a Boolean property of the String class, true if the String contains at minimum
			//one character, otherwise false
			
        	self.species = species
    	}
	}
	
	let someCreature = new Animal(species = "Giraffe")
	//someCreature is of type Animal?, not Animal
 
	if let giraffe = someCreature: print("An animal was initialized with a species of " + giraffe.species)
	//Prints "An animal was initialized with a species of Giraffe"
	
	let anonymousCreature = new Animal(species: "")
	//anonymousCreature is of type Animal?, not Animal
 
	if anonymousCreature == nil: print("The anonymous creature could not be initialized")
	//Prints "The anonymous creature could not be initialized"
	```
	>**Note**: Checking for an empty string value (such as `""` rather than `"Giraffe"`) is not the same as checking for nil to indicate the absence of an optional String value. In the example above, an empty string (`""`) is a valid, nonoptional String. However, it is not appropriate for an animal to have an empty string as the value of its species property. To model this restriction, the failable initializer triggers an initialization failure if an empty string is found.

	---
* #### Computed Properties
	
	A class in Fly can also have *computed properties*, which do not actually store a value. Instead, they provide a getter and a setter to retrieve and set other properties and values indirectly. You write the getter and setter inside of curly braces with the keyword `get` and `set` followed again by curly braces, which can be omitted, if the getter or setter contains only one expression. Inside the setter block you can access the new value with `newValue`:
	
	```swift
	class Point {
		var x, y@Double
		    
		init(x@Double, y@Double) {
			self.x = x
			self.y = y
		}
	}
	
	class Size {
		var width, height@Double
		    
		init(width@Double, height@Double) {
			self.width = width
			self.height = height
		}
	}
	
	class Rect {
		var origin@Point
		var size@Size
		var center@Point {
			get {
				let centerX = self.origin.x + (self.size.width / 2)
				let centerY = self.origin.y + (self.size.height / 2)
				new Point(x = centerX, y = centerY)
				//returned, because it's the last expression of the get block
			}
			set {
				self.origin.x = newValue.x - (self.size.width / 2)
				self.origin.y = newValue.y - (self.size.height / 2)
			}
		}
		    
		init(origin@Point, size@Size) {
			self.origin = origin
			self.size = size
		}
	}
	
	var square = new Rect(origin = new Point(x = 0.0, y = 0.0), size = new Size(width = 10.0, height = 10.0))
	print("square.center is at (" + square.center.x) + ", " + square.center.y + ")")
	// Prints "square.center is at (5.0, 5.0)"
	
	square.center = new Point(x = 15.0, y = 15.0)
	print("square.origin is at (" + square.origin.x) + ", " + square.origin.y + ")")
	// Prints "square.origin is now at (10.0, 10.0)"
	```
	Also a *computed property* can only have a getter. That means it is read-only similar to a constant. Because there is no setter, you can also omit the `get` keyword and the curly braces of the getter:
	
	```swift
	class Cuboid {
		var width, height, depth@Double
		    
		var volume@Double {
			self.width * self.height * self.depth
			//returned, because it's the last expression
		}
		    
		init(width@Double, height@Double, depth@Double) {
			self.width = width
			self.height = height
			self.depth = depth
		}
	}
	
	let fourByFiveByTwo = new Cuboid(width = 4.0, height = 5.0, depth = 2.0)
	print("the volume of fourByFiveByTwo is " + fourByFiveByTwo.volume)
	// Prints "the volume of fourByFiveByTwo is 40.0"
	```
	Again you can omit the curly braces of a read-only computed property, if it contains only one expression. The `volume` property of the example above can be written as:
	
	```swift
	var volume@Double: self.width * self.height * self.depth
	```

	---
* #### Methods
	
	A class can also have associated methods. They are written exactly like functions. Of course they can also have parameters and return types. They are also accessed with the *dot syntax*:
	
	```swift
	class Person {
		var firstname@String
		//If you set no value here, it must be set in an initializer
		var lastname@String
		var age@Int
		var emailAdress@String?
		//Of course the properties can also be optional
		//optional properties don't have to be set in the initializer
		//but of course they can be set
		
		init(firstname@String, lastname@String, age@Int) {
			self.firstname = firstname
			self.lastname = lastname
			self.age = age
			//now emailAdress is nil
		}
		
		init(firstname@String, lastname@String, age@Int, emailAdress@String) {
			self.firstname = firstname
			self.lastname = lastname
			self.age = age
			self.emailAdress = emailAdress
			// now emailAdress is definitely not nil
		}
		
		func printPersonDescription() {
			if let emailAdress = self.emailAdress: print(self.firstname + " " + self.lastname + ", " + self.age + " years old, e-mail-adress: " + emailAdress)
			else: print(self.firstname + " " + self.lastname + ", " + self.age + " years old")
		}
	}
	
	let p = new Person(firstname = "Donald", lastname = "Duck", age = 40)
	p.printPersonDescription()
	//Prints "Donald Duck, 40 years old"
	
	let p2 = new Person(firstname = "Donald", lastname = "Duck", age = 40, emailAdress = "donald.duck@gmail.com")
	p2.printPersonDescription()
	//Prints "Donald Duck, 40 years old, e-mail-adress: donald.duck@gmail.com"
	```

	---
* #### Private Properties and Methods
	
	The properties and methods of a class are public by default. They can be set to private with the `private` keyword:
	
	```swift
	class SimpleClass {
		var number@Int
		private var privateNumber@Int
		
		init(_ number@Int, _ privateNumber@Int) {
			self.number = number
			self.privateNumber = privateNumber
		}
		
		func getPrivateNumber()@Int {
			self.printHello()
			self.privateNumber
			//is returned without return keyword, because it is the last expression of the method
		}
		
		private func printHello(): print("Hello")
	}
	
	let object = new SimpleClass(5, 10)
	print(object.number)
	//Prints "5"
	
	print(object.privateNumber)
	//Compile-time error, because privateNumber is private and cannot be accessed outside of the class
	
	let privateNumber = object.getPrivateNumber()
	//Prints "Hello"
	print(privateNumber)
	//Prints "10"
	
	object.printHello()
	//Compile-time error, because printHello() is private
	```

	---
* #### Inheritance
	
	A class can inherit from another class. It's written like when you set the type of a variable with a '@', followed by the parent class name. When you inherit a class, the inherited class (subclass) inherits all properties and methods of the superclass. Also you can access the initializers and methods of the superclass via the `super` keyword. Of course a subclass can have additional properties and methods and can override the superclasses methods with the keyword `override`:
	
	```swift
	class ParentClass {
		var number@Int
		
		init(number@Int): self.number = number
		
		func printProperties(): print("number: " + self.number)
	}
	
	class ChildClass@ParentClass {
		var description@String
		
		init(description@String, number@Int) {
			self.description = description
			super.init(number = number)
		}
		
		override func printProperties() {
			print("description: " + self.description)
			super.printProperties()
		}
	}
	
	let parentClassObject = new ParentClass(number = 5)
	parentClassObject.printProperties()
	//Prints "number: 5"
	
	let childClassObject = new ChildClass(description = "Child Class", number = 10)
	childClassObject.printProperties()
	//Prints "description: Child Class"
	//Prints "number: 10"
	```
	
	---
* #### Inheritance from Object Class
	
	Because every class in Fly inherits from the `Object` class, you can override the methods of the `Object` class as well. For example you can override the `toString()` method of the `Object` class (by the way, only the fact, that every class in Fly has the method `toString()`, makes *string concatenation* with different variable types possible):
	
	```swift
	class Person {
		var firstname@String
		var lastname@String
		
		init(firstname@String, lastname@String) {
			self.firstname = firstname
			self.lastname = lastname
		}
		
		override func toString()@String: self.firstname + " " + self.lastname
	}
	
	let p = new Person(firstname: "Mark", lastname: "Schröder")
	print(p.toString())
	//Prints "Mark Schröder"
	```

	---
* #### Defining Operators
	
	Fly allows you to define the behavior of the *binary operators* `+`, `-`, `*`, `/`, `%`, the *compound assignment operators* `+=`, `-=`, `*=`, `/=`, `%=` and the *unary prefix operators* `—` and `!` for your own classes.
	
	**A binary operator** is defined by adding a function with the `binary` keyword which name is the symbol of the operator to define with one parameter of the type of the right side of the operation and the return type of the operation. For example, define a `+` operator for a class `Point` (representing a coordinate):
	
	```swift
	class Point {
		var x, y@Double
		
		init(x@Double, y@Double) {
			self.x = x
			self.y = y
		}
		
		binary func +(other@Point)@Point: new Point(x = self.x + other.x, y = self.y + other.y)
	}
	
	let point = new Point(x = 3.0, y = 1.0)
	let anotherPoint = new Point(x = 2.0, y = 4.0)
	
	let addedPoint = point + anotherPoint
	print("x: " + addedPoint.x + ", y: " + addedPoint.y)
	//Prints "x: 5.0, y: 5.0"
	```
	In the example above two variables `point` and `anotherPoint`, both of type `Point` were added to another variable called `addedPoint`, also of type `Point`. Fly automatically converts the expression `point + anotherPoint` to the function call `point.+(other = anotherPoint)`.
	
	**A compound assignment operator** is defined by adding a function with the `compound` keyword which name is the symbol of the operator to define with one parameter of the type of the right side of the operation. A *compound assignment operation* doesn't return a value. We can add to the example above:
	
	```swift
	class Point {
		var x, y@Double
		
		init(x@Double, y@Double) {
			self.x = x
			self.y = y
		}
		
		binary func +(other@Point)@Point: new Point(x = self.x + other.x, y = self.y + other.y)
		
		compound func +=(other@Point) {
			self.x += other.x
			self.y += other.y
		}
	}
	
	let point = new Point(x = 3.0, y = 1.0)
	let anotherPoint = new Point(x = 2.0, y = 4.0)
	
	point += anotherPoint
	print("x: " + point.x + ", y: " + point.y)
	//Prints "x: 5.0, y: 5.0"
	```
	Again, the statement `point += anotherPoint` is converted to the function call `point.+=(other = anotherPoint)`
	
	**A unary prefix operator** is defined by adding a function with the `unary` keyword which name is the symbol of the operator to define with no parameter and the return type of the operation. We can add to the example above:
	
	```swift
	class Point {
		var x, y@Double
		
		init(x@Double, y@Double) {
			self.x = x
			self.y = y
		}
		
		binary func +(other@Point)@Point: new Point(x = self.x + other.x, y = self.y + other.y)
		
		compound func +=(other@Point) {
			self.x += other.x
			self.y += other.y
		}
		
		unary func -()@Point: new Point(x = -(self.x), y = -(self.y))
	}
	
	let point = new Point(x = 3.0, y = 1.0)
	
	let anotherPoint = -point
	print("x: " + anotherPoint.x + ", y: " + anotherPoint.y)
	//Prints "x: -3.0, y: -1.0"
	```
	In this case, too, the expression `-point` converts to the function call `point.-()`

	---
* #### Operator overloading
	
	Operator overloading is also supported in Fly, meaning that it is possible to define multiple `+` operators, for example, as long as the parameters list of each operator function is different. So operator overloading doesn't work for *unary prefix operators*, because they have no parameters.
	
	For instance, you can define three `+` operators for a class `Rational` (representing rational numbers like 3/4), because you want to add two `Rational`s, but also want to add a `Rational` and a `Int` or a `Double`. Operator overloading allows you to do just that.
	
	```swift
	class Rational {
		var num, den@Int
		
		init(num@Int, den@Int) {
			self.num = num
			self.den = den
		}
		
		override func toString()@String: self.num + "/" + self.den
		//Is called when printing the class or using it in string concatenation, so it doesn't have to be called extra
		
		binary func +(other@Rational)@Rational {
			//Code to add two Rationals
		}
		
		binary func +(integer@Int)@Rational {
			//Code to add a Rational and a Integer 
		}
		
		binary func +(double@Double)@Rational {
			//Code to add a Rational and a Double
		}
	}
	
	let threeQuarters = new Rational(num = 3, den = 4)
	let oneHalf = new Rational(num = 1, den = 2)
	let fourtyTwo = 42
	let threePointTwoFive = 3.25
	
	print(threeQuarters + " + " + oneHalf + " = " + (threeQuarters + oneHalf))
	//does the same as
	//print(threeQuarters.toString() + " + " + oneHalf.toString() + " = " + (threeQuarters + oneHalf).toString())
	//Prints "3/4 + 1/2 = 5/4"
	
	print(oneHalf + " + " + fourtyTwo + " = " + (oneHalf + fourtyTwo))
	//Prints "1/2 + 42 = 85/2"
	
	print(threeQuarters + " + " + threePointTwoFive + " = " + (threeQuarters + threePointTwoFive))
	//Prints "3/4 + 3.25 = 4/1"
	```
	
---
### Everything is an Object

To say it again: everything in Fly is an object. Even primitives like `Int`s or `Double`s are actually objects. And an arithmetic expression like `32 + 21` is, in fact, the function call `32.+(21)`. This is a neat feature that enables us, among others things, to define operators for our own types in Fly and to use string concatenation with all classes including custom classes.









