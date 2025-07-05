# Design Patterns 

Design patterns are **proven solutions to recurring problems** in software design, which are high-quality, reusable, loosely-coupled and maintainable object-oriented software systems. They capture design experience in a usable form, providing a **standard vocabulary for developers**. Essentially, a design pattern names, abstracts, and identifies the key aspects of a common design structure that make it useful for creating a reusable object-oriented design. The well-known "Gang of Four" (GoF) patterns consist of 23 such patterns, grouped into three categories: **Creational, Structural, and Behavioural**.

## Why Design Patterns?

Learning design patterns is essential for several reasons:

- **Improved Code Quality**: Using design patterns often results in **more maintainable, flexible, and extensible code**. They help promote **loose coupling** and encapsulate design decisions, making codebases easier to understand, modify, and extend. They embody best practices and principles of software design. For Example, most of the Salesforce Apex frameworks that organisations follow are built following these design patterns.
- **Enhanced Understanding and Development**: Knowing design patterns makes it easier to **understand existing object-oriented systems**. They can help you become a better designer, enabling novices to act more like experts. They are also useful for transitioning from analysis models to implementation models and can provide targets for refactoring, making designs more robust to change.
- **Reusable Solutions**: They offer **tested solutions to common design issues**, preventing developers from having to "reinvent the wheel". By applying these patterns, you can reuse successful designs and architectures.
- **Standardized Terminology**: They **provide a common language for developers**, which enhances collaboration and understanding among team members. This allows you to talk about designs at a higher level of abstraction.
- **Cross-Domain Applicability**: Many patterns are **language and domain-agnostic**, making them valuable tools in diverse development environments. These principles can be applied to any OOP language, and also Salesforce Apex or LWC development.

In summary, design patterns are valuable because they provide reusable solutions, a common language, and guide developers toward creating flexible, maintainable, loosely-coupled and high-quality software systems.

## Object-Oriented Programming Principles (OOPS!)

Object-Oriented Programming (OOP) principles are fundamental concepts that underpin the design of object-oriented software systems. Before diving into design patterns, it is crucial to understand some of these core principles. Understanding these OOP principles is critical because design patterns are built upon these fundamental techniques. Learning OOP principles first helps you understand why these problems exist and how patterns use principles like encapsulation, inheritance, and polymorphism to solve them

Here are the OOPS concepts that you need to know before starting on Design Patterns :
- Encapsulation
- Abstraction
- Inheritance
- Polymorphism
- Coupling
- Composition

---

  ### Encapsulation

- Encapsulation is a fundamental principle of object-oriented programming. It involves bundling the data ("fields" or "properties") and the behaviours (or methods) that operate on that data into a single unit, called a class.
- The primary goal of encapsulation is to hide the internal implementation details of a class by only exposing the necessary functionalities to the outside world. This means the object's internal state is hidden and can only be changed via operations. The procedures (methods/operations) are the only way to access and modify an object's representation.
- A common way to achieve encapsulation is by marking the data members as private. This prevents direct access to the data from outside the class. Instead, controlled access is provided through public "Getter" methods to retrieve the data and methods to manipulate it, ensuring that operations are performed safely and according to defined rules and logic.

Here is a bad example that does not follow Encapsulation :

https://github.com/khushal-ganani/design-patterns-salesforce/blob/376565cb5204612d0dbe01d5d14a2ddc7b74083a/force-app/main/default/classes/OOPS/Encapsulation/AccountScoreService_Bad.cls#L1-L27

Users of this class have direct access to the internal fields/properties and methods/logic of the `AccountScoreService_Bad` class. For example, users can directly assign the `Map<Id, Decimal> opportunityScore` and `Map<Id, Decimal> activityScore` since they are `public`. Also, The Users of this class are required to call the public methods to calculate the score:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/376565cb5204612d0dbe01d5d14a2ddc7b74083a/scripts/apex/OOPS/Encapsulation/EncapsulationBadExample.apex#L1-L12

A better way to define the class that follows the Encapsulation principle and hides the fields and internal logic:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/376565cb5204612d0dbe01d5d14a2ddc7b74083a/force-app/main/default/classes/OOPS/Encapsulation/AccountScoreService_Good.cls#L1-L51

We can call this class as follows :

https://github.com/khushal-ganani/design-patterns-salesforce/blob/376565cb5204612d0dbe01d5d14a2ddc7b74083a/scripts/apex/OOPS/Encapsulation/EncapsulationGoodExample.apex#L1-L8

In the above example :
- The `AccountScoreService_Good` class encapsulated the scoring data (`Map<Id, Decimal> opportunityScore` and `Map<Id, Decimal> activityScore`) and methods working on this data (`calculateScore()`) into a single unit which are `private`, encapsulating them within the class preventing direct access from the outside of the class by the user of this class.
- The **"Getter"** methods (`getOpportunityScore(Id accountId)` and `getActivityScore(Id accountId)`) are used to provide controlled access to the data according to the logic defined.
- `private` methods like `calculateScore(), calculateOpportunityScore(), calculateActivityScore()` are used internally by the class to handle the business logic, which the user of the class doesn't need to worry about.

In summary, Encapsulation is used to separate the public interface and the internal implementation/business logic of the class, allowing users to focus on the higher-level functionality.

---

### Abstraction

- Abstraction is the process of hiding the complex internal implementation details of a class or methods and exposing only the necessary features.
- For example, when pressing a button on a TV remote, we don't have to worry about or interact directly with the internal circuit board – those details are abstracted away.

In Apex, we achieve abstraction using:
- Abstract classes
- Interfaces
- Sometimes, base classes with virtual methods

**✅ Scenario: Sending Notifications in Different Ways**

Imagine you're building a system where:
- A Contact may need to be notified by Email or SMS, based on user preference.

You want to create a flexible and extendable design where:
- The core logic knows only how to trigger notifications, not how each type works.
- You can add more notification types (like WhatsApp or Push) in the future without changing core logic.

Here is a bad example that does not follow Abstraction :

https://github.com/khushal-ganani/design-patterns-salesforce/blob/f6533b429f9e4f58583e0c0e1b589a84874ad3e9/force-app/main/default/classes/OOPS/Abstraction/ContactNotificationService_Bad.cls#L1-L20

**🚨 What's Wrong with This?**

| Problem | Why It's a Violation of Abstraction |
| -------- | -------- |
No interface or base class | There’s no abstraction layer. The service class directly controls how email or SMS is sent.
Tightly coupled logic |	The service class knows about every notification method and how to implement them.
Hard to extend |	Adding WhatsApp or Push notifications means adding more else if blocks and more code changes to the same class.
Hard to test |	You can't mock or isolate the notification behaviour; it's all baked into one method.
Violates Single Responsibility Principle (SRP) |	This class is doing too much — both determining **what and how to notify**.

Here is a better way to define this logic using Abstraction :

**Create an Interface (Abstraction)**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/f6533b429f9e4f58583e0c0e1b589a84874ad3e9/force-app/main/default/classes/OOPS/Abstraction/NotificationStrategy.cls#L1-L3

This interface provides a contract:
- Any class implementing this interface must define how to `sendNotification()`.

**Concrete Implementations (Hidden Complexity)**

Email Notification:
https://github.com/khushal-ganani/design-patterns-salesforce/blob/f6533b429f9e4f58583e0c0e1b589a84874ad3e9/force-app/main/default/classes/OOPS/Abstraction/EmailNotification.cls#L1-L9

SMS Notification (Dummy Example):
https://github.com/khushal-ganani/design-patterns-salesforce/blob/f6533b429f9e4f58583e0c0e1b589a84874ad3e9/force-app/main/default/classes/OOPS/Abstraction/SMSNotification.cls#L1-L6

**Notification Service (Abstracts the Logic)**
https://github.com/khushal-ganani/design-patterns-salesforce/blob/f6533b429f9e4f58583e0c0e1b589a84874ad3e9/force-app/main/default/classes/OOPS/Abstraction/ContactNotificationService_Good.cls#L1-L14

**How to Use It in Apex**

Let’s say you want to notify a contact by email:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/f6533b429f9e4f58583e0c0e1b589a84874ad3e9/scripts/apex/OOPS/Abstraction/AbstractionGoodExample.apex#L1-L5

**🧠 What Makes This Abstraction?**

| Element |	Role in Abstraction |
| ------- | ------------------- |
| `NotificationStrategy` interface |	Abstracts what a notification is, so that the classes using this interface don't have to know the concrete implementation for this interface |
| `EmailNotification`, `SMSNotification` | Hides how the notification is sent into concrete implementation classes which implement the `NotificationStrategy` interface |
| `ContactNotificationService_Good` |	Uses the abstracted interface, not concrete logic. This way, `ContactNotificationService_Good` doesn't have to know about the exact logic for sending, let us say, Email or SMS notifications. It just has to know how to send a notification, which is by just calling the `sendNotification()` method on the `NotificationStrategy` interface |

**🔥 Advantages of Using Abstraction:**

- ✅ **Loose coupling**: Core logic doesn't depend on specific implementations, hence changing the concrete `EmailNotification`, `SMSNotification` classes won't break the `ContactNotificationService_Good` service class.
- ✅ **Easy extension** Add new types (e.g., `WhatsAppNotification`) without breaking existing code.
- ✅ **Testable and maintainable**: Each piece has a clear responsibility and can be tested individually.

---

### Inheritance

- **Inheritance** is the mechanism in object-oriented programming where one class (called a **child** or **subclass**) can **inherit the properties and methods** of another class (called a **parent** or **superclass**).
- Subclasses inherit properties and behaviours from its superclasses and can also add new features or override existing ones.
- Inheritance is described as a **"is-a"** relationship. For example, **A Car "is-a" Vehicle** and a **Bike "is-a" Vehicle**. So Vehicle can be a Super-class while Care and Bike can be child sub-classes.

**✅ Salesforce Apex Example: Custom Validation Rules via Inheritance**

**🧠 Scenario:**

You need to build a validation framework for different objects, like:
- **Contact**: Must have a Name and Email.
- **Opportunity**: Must have a Name, Amount and Close Date.

Instead of writing logic separately or duplicating code, you want a reusable, extensible structure that uses inheritance.

**🎯 Goal:**

- Create a base class `RecordValidator`
- Each object gets its own validator by inheriting the base class
- All validators implement their own custom logic

**Step 1: Base Class**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/62a74e1178606bd9fa8ad0a54d54561d7b8c0bff/force-app/main/default/classes/OOPS/Inheritance/RecordValidator.cls#L1-L21

**Step 2: Create Child Classes**

Contact Validator:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/62a74e1178606bd9fa8ad0a54d54561d7b8c0bff/force-app/main/default/classes/OOPS/Inheritance/ContactValidator.cls#L1-L12

Opportunity Validator:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/62a74e1178606bd9fa8ad0a54d54561d7b8c0bff/force-app/main/default/classes/OOPS/Inheritance/OpportunityValidator.cls#L1-L15

**Sample Execution (Anonymous Apex):**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/62a74e1178606bd9fa8ad0a54d54561d7b8c0bff/scripts/apex/OOPS/Inheritance/InheritanceGoodExample.apex#L1-L4

**✅ Benefits of Using Inheritance Here**

- Defines a common method `validate()` in the base `RecordValidator` class, which is overridden by the sub-classes to define the individual validation logic for each object.
- `ContactValidator`, `OpportunityValidator` child classes	customise validation for each object, extending the functionality of the `RecordValidator` class.
- Reusable and easily extendible for other objects like Lead, Case, etc.
- Each class has a clean separation of the logic to have only a single responsibility.
- Each validator is easy to unit test independently

---

### Polymorphism

- **Polymorphism** is a core concept in Object-Oriented Programming (OOP), which is the ability of an object to take many forms.
- It allows **different classes to be treated as instances of a common parent class or interface**, and the **appropriate method implementation is called at runtime**.

**In Apex, polymorphism is used when:**

- You define a **parent abstract class (or interface)**
- You write **methods that use the parent type**
- At runtime, **child class methods are executed** depending on the actual object type

**✅ Real-World Salesforce Use Case: Notification Sender**

**🧩 Requirement:**
You need to send different types of notifications to users:
- Email notification
- Chatter post notification

You want a clean, scalable way to handle all these using a single reference — that's where polymorphism shines.

First, let us see a bad example which is not following the Polymorphism principle:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/14edffc0849962a95544da9ffdfceeefd15c5208/force-app/main/default/classes/OOPS/Polymorphism/NotificationService_Bad.cls#L1-L19

The above class can be used as follows:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/14edffc0849962a95544da9ffdfceeefd15c5208/scripts/apex/OOPS/Polymorphism/PolymorphismBadExample.apex#L1-L5

**🚨 Why This Is Bad**
| Problem |	Description |
| ------- | ----------- |
| ❌ No Polymorphism	| Each type is handled with `if-else` instead of letting objects decide behaviour, which violates the Open/Closed Principle (a SOLID Principle) and Polymorphism. | 
| ❌ Not Open/Closed	| If you want to add "Slack Notification", you'll need to edit the core `notifyUser` method — risky and error-prone since we are making changes on the same class/code. | 
| ❌ Tight Coupling	| `NotificationService_Bad` depends on all specific implementations in a single class in `if-else` conditions instead of delegating to different objects with implementation. | 
| ❌ Hard to Test	| No separation of concerns. You can't easily mock or isolate each type of notification. | 
| ❌ Poor Reusability	| Can't pass the logic around as objects — violates OOP design. |

Now let's see a good example which follows the Polymorphism Principle:

**✅ Step 1: Define an Interface**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/14edffc0849962a95544da9ffdfceeefd15c5208/force-app/main/default/classes/OOPS/Polymorphism/NotificationSender.cls#L1-L3

**✅ Step 2: Implement Different Notification Classes**

**📧 Email Notification:**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/14edffc0849962a95544da9ffdfceeefd15c5208/force-app/main/default/classes/OOPS/Polymorphism/EmailNotificationSender.cls#L1-L6

**💬 Chatter Notification:**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/14edffc0849962a95544da9ffdfceeefd15c5208/force-app/main/default/classes/OOPS/Polymorphism/ChatterNotificationSender.cls#L1-L6

**✅ Step 3: Use Polymorphism**

**You can write a single method that works with the interface:**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/14edffc0849962a95544da9ffdfceeefd15c5208/force-app/main/default/classes/OOPS/Polymorphism/NotificationService_Good.cls#L1-L11

The above class can be used as follows:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/14edffc0849962a95544da9ffdfceeefd15c5208/scripts/apex/OOPS/Polymorphism/PolymorphismExampleGood.apex#L1-L6

**⚙️ What's Happening Here?**

Although `notifyUser` uses the interface type (`NotificationSender`), Apex automatically calls the correct `sendNotification()` method based on the actual concrete class object passed (`EmailNotificationSender ChatterNotificationSender`).

**🔍 Summary of OOP Concepts Applied**

| OOP Principle	| How It’s Used |
| ------------- | ------------- |
| Polymorphism	| One method call (`sendNotification`) behaves differently for each object type passed (`EmailNotificationSender ChatterNotificationSender`) |
| Interface	| Declares a common contract (`NotificationSender`), and concrete classes adhering to this contract have to define the `sendNotification` method |
| Encapsulation	| Each (`EmailNotificationSender ChatterNotificationSender`) class hides how it sends the message |
| Abstraction	| The Caller doesn't need to know how the notification is implemented, it just has to call the `sendNotification` on the `NotificationSender` interface |
| Inheritance (optional) | Not used here, but could be if using abstract classes |

---

### Coupling

- Coupling refers to the **degree of direct knowledge or dependency one class or module has about another**. It tells us **how tightly connected different pieces of code are**.
- High coupling means that classes are tightly interconnected, making it difficult to modify or maintain them independently. Low coupling, on the other hand, indicates loose connections between classes, allowing for greater flexibility and ease of modification.

**Why Is Coupling Important?**

- Low (loose) coupling makes your code more flexible, reusable, and testable.
- High (tight) coupling leads to rigid, harder-to-maintain, and error-prone code.

**High Coupling**

- Suppose when a **class creates an object of another class or directly calls a static method from another class**, it makes the two classes **tightly coupled** and any changes to one class may require modifications to the other class.

**Low Coupling**

- To reduce coupling, we can introduce an **abstraction (e.g., an interface)** between the two classes. This allows the class to interact with the other class through the abstraction, making it easier to replace or modify the implementation of the abstract class or interface without affecting the other class.
- This decouples the classes from the specific implementation of the other class, making the codebase more **maintainable, flexible and can be modified independently without breaking the codebase**.

**Example:**
- The above example mentioned in the [Polymorphism](https://github.com/khushal-ganani/design-patterns-salesforce/blob/main/README.md#polymorphism) section can also be considered as a great example of loose and tight coupling, where the logic related to different notification types is tightly coupled with the same `NotificationService_Bad` class, which handles the sending notification logic.
- But the `NotificationService_Good` class, which has the logic to send notifications, is loosely coupled with the logic related to each different type of notification using an abstraction by using the `NotificationSender` interface.

### Composition

- Composition is an OOP design principle where a **class contains instances of other classes to reuse their behaviour and functionality** instead of **inheriting** from them.
- In composition, objects are assembled to form larger structures, with **each component object maintaining its own state and behaviour**.
- Composition is often described in terms of a **"has-a" relationship**.
- For example, let us consider a `Car` class (object) which has various components such as `Engine`, `Wheels`, which are separate classes responsible for their own functionality. The `Car` object is composed of these components and delegates the tasks to them for their functionality.

**✅ Real-Life Salesforce Scenario for Composition**

**🧩 Use Case: Account Creation with Multiple Post-Processing Steps**

You're asked to build an Account creation service in Apex that performs several tasks after an Account is inserted:
1. Sends a welcome email to the primary contact.
2. Logs the action in a custom object (AccountLog__c).

**🎯 Goal: Compose Behaviour Using Small, Independent Classes**

**🔶 Step 1: Define an Interface for Post-Creation Actions**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/1368e5c12875e77b8148cbaad246c960bace1a28/force-app/main/default/classes/OOPS/Composition/GoodExample_Composition/AccountCreationAction.cls#L1-L3

**🔷 Step 2: Implement Different Post-Action Behaviours**

**🔹 Send Welcome Email**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/1368e5c12875e77b8148cbaad246c960bace1a28/force-app/main/default/classes/OOPS/Composition/GoodExample_Composition/SendWelcomeEmailAction.cls#L1-L8

**🔹 Log to AccountLog__c**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/1368e5c12875e77b8148cbaad246c960bace1a28/force-app/main/default/classes/OOPS/Composition/GoodExample_Composition/CreateAccountLogAction.cls#L1-L16

**🔷 Step 3: Compose the Service with These Behaviours**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/1368e5c12875e77b8148cbaad246c960bace1a28/force-app/main/default/classes/OOPS/Composition/GoodExample_Composition/AccountCreationService.cls#L1-L16

Here is how we can use the above solution:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/1368e5c12875e77b8148cbaad246c960bace1a28/scripts/apex/OOPS/Composition/CompositionGoodExample.apex#L1-L9

**✅ Why This Is a Great Example of Composition**

| Benefit | Explanation |
| --- | --- |
| 🔁 **Reusable** | Each action class (email, log, assign) is reusable elsewhere. |
| ➕ **Extensible** | Want to add another action? Just create a new class and add to the list --- no changes to existing logic. |
| 🧪 **Testable** | You can unit test each action in isolation or mock them if needed. |
| 🔧 **Decoupled** | The `AccountCreationService` knows nothing about what actions exist --- it just loops and calls `insertAccounts()` which decouples the `AccountCreationService` from each type of implementation of `AccountCreationAction`. |
| 📦 **Flexible** | You can dynamically change the list of actions based on config, environment, or user role. |

#### Composition Vs Inheritance

**💥 What if We Used Inheritance Here Instead? (Not Ideal Here)**

- Imagine if `SendWelcomeEmailAction` and `CreateAccountLogAction` inherited from `AccountCreationAction`, you’d end up duplicating logic or violating SRP. That’s where composition wins — you keep formatting separate from generating logic.
- Also, let's say you want to call only a certain combination of `AccountCreationAction`, then you would have to again create sub-classes for those combinations, which would have allot of code duplication and aslo violating SRP too.

Let's try to develop the above example with Inheritance:

**🔶 Step 1: Define an Interface for Post-Creation Actions**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/1368e5c12875e77b8148cbaad246c960bace1a28/force-app/main/default/classes/OOPS/Composition/BadExample_Inheritance/AccountCreationAction_Inheritance.cls#L1-L5

**🔷 Step 2: Implement Different Post-Action Behaviours**

**🔹 Send Welcome Email**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/1368e5c12875e77b8148cbaad246c960bace1a28/force-app/main/default/classes/OOPS/Composition/BadExample_Inheritance/SendWelcomeEmailAction_Inheritance.cls#L1-L8

**🔹 Log to AccountLog__c**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/1368e5c12875e77b8148cbaad246c960bace1a28/force-app/main/default/classes/OOPS/Composition/BadExample_Inheritance/CreateAccountLogAction_Inheritance.cls#L1-L15

**🔹 Both Welcome Email and Log to AccountLog__c (Not Ideal)**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/4002fe9ec3aa53b77d051697a76b6c95a530497d/force-app/main/default/classes/OOPS/Composition/BadExample_Inheritance/AllAcountCReationActions_Inheritance.cls#L1-L19

The above example can be used as follows :

https://github.com/khushal-ganani/design-patterns-salesforce/blob/4002fe9ec3aa53b77d051697a76b6c95a530497d/scripts/apex/OOPS/Composition/BadExampleWithInheritance.apex#L1-L4

**⚠️ The Problem with this**

You want to apply all two behaviors, but Apex does not support multiple inheritance. You cannot extend more than one class at a time.

This means you're forced to create a class like this:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/4002fe9ec3aa53b77d051697a76b6c95a530497d/force-app/main/default/classes/OOPS/Composition/BadExample_Inheritance/AllAcountCReationActions_Inheritance.cls#L1-L19

**❌ Why This Inheritance-Based Design Is Not Ideal**

| 🚫 Problem | 💡 Explanation |
| --- | --- |
| ❌ **No multiple inheritance** | You can't mix `SendWelcomeEmailAction_Inheritance` and `CreateAccountLogAction_Inheritance`, and if you want to do so, you have to create a new sub-class similar to `AllAcountCReationActions_Inheritance`. |
| ❌ **Poor Separation of Concerns** | Let's say if we consider the `AllAcountCReationActions_Inheritance` class, all logic is now in a single class, having poor separation of concerns. |
| ❌ **Low Reusability** | Want just logging OR Welcome Email, OR Both? You'll have to duplicate code for each use case. |
| ❌ **Hard to Extend** | Want to add a new behavior? You have to modify or duplicate classes. |
| ❌ **Tightly Coupled** | Hard to test one behaviour in isolation since for a combination of actions, all the logic is defined in a single class. |

#### Fragile Base Class Issue in OOP Software

**Fragile Base Class Problem** — is a common design issue caused by Inheritance and can be avoided using Composition. It's a software design issue in Object-Oriented Programming (OOP), which occurs when a **change is made in the base or parent class**, can **cause issues and break the functionality of the derived child classes**. This occurs due to a **tight coupling between the base and derived classes** in Inheritance hierarchies.

**🛡️ How to Avoid the Fragile Base Class Problem**

- **✅ Prefer Composition Over Inheritance** : Composition promotes loose coupling between classes, thus making the codebase more maintainable and scalable.
- **✅ Keep Base Classes Simple** : Don’t call virtual or abstract methods in constructors or base logic defined in the base class unexpectedly. Also, avoid deep Inheritance hierarchies.
- **✅ Use Interfaces for Behavior Extension** : This allows behavior injection without inheritance coupling.

---

## SOLID Principles

**SOLID is an acronym for five design principles** intended to make software systems more **understandable, flexible, and maintainable**. These principles are fundamental in Object-Oriented Programming (OOP) and lay the foundation for good software design.

| Letter | Principle Name | Description |
| --- | --- | --- |
| **S** | Single Responsibility Principle (SRP) | A class should have **only one reason to change** |
| **O** | Open/Closed Principle (OCP) | Software entities should be **open for extension, but closed for modification** |
| **L** | Liskov Substitution Principle (LSP) | Objects of subclasses should be **substitutable** with objects of their base classes without altering correctness |
| **I** | Interface Segregation Principle (ISP) | Clients should not be forced to depend on **methods/interfaces they do not use** |
| **D** | Dependency Inversion Principle (DIP) | Depend on **abstractions**, not on concrete implementations |

🎯 How Do SOLID Principles Relate to Design Patterns?
-------------------------------------------------------

> Think of **SOLID** principles as the **"rules" or "guiding principles"** of clean object-oriented design.\
> Think of **Design Patterns** as **"solutions to recurring design problems"**.

If you **understand SOLID**, you'll:
-   Know **why** a design pattern is structured a certain way,
-   Avoid misusing patterns (e.g., using inheritance wrongly),
-   Build your **own reusable designs** effectively.

✅ Why Are They Important?
-------------------------

Without these principles, code can become:

-   Tightly coupled

-   Hard to test

-   Difficult to change

-   Prone to bugs

By following SOLID, your code becomes:

-   **Easier to understand**

-   **Easier to extend with new features**

-   **Easier to maintain and debug**

-   **Easier to test (unit/integration)**

-   **A good foundation for applying design patterns**

✅ Summary
---------

-   **SOLID** is a set of five key principles for building well-structured, maintainable, and testable object-oriented software.

-   These principles **guide your thinking** when choosing or building design patterns.

-   In Salesforce Apex, they help you build code that's easier to **test, change, and scale**.

-   Learning SOLID is like learning the **grammar of clean software design** --- design patterns are the **sentences** you write with it.

### S - Single Responsibility Principle

The Single Responsibility Principle states that: **“A class/module should have only one reason to change, meaning that it should have only one responsibility or purpose.”**

This principle encourages you to create classes that are more focused and perform a single well-defined task, rather than multiple tasks. Breaking up classes into smaller, more focused units makes code easier to understand, maintain, and test.

🔍 Real-Life Salesforce Scenario
--------------------------------

**💼 Business Requirement:**

> When a **Case** is created in Salesforce:

1.  It should automatically assign the **Support Queue** as the owner.

2.  It should **send a notification email** to the assigned queue.

3.  It should create a custom object record (e.g., `CaseAudit__c`) to log the event.

4.  It should send a Slack message to support channel (in the future).

We will first **violate SRP** and then **refactor it** using SRP.

* * * * *

**❌ Bad Design (Violates SRP)**
---------------------------

https://github.com/khushal-ganani/design-patterns-salesforce/blob/aeb4371cc7c23d90b9251a21553cfa9d611730b1/force-app/main/default/classes/SOLID/S%20-%20Single%20Responsibility%20Principle/CaseTriggerHandler_Bad.cls#L1-L36

### ❌ Problems with the Above Code:

| Problem | Why it's bad |
| --- | --- |
| 🚨 Too many responsibilities | Assigning owner, sending email, logging audit |
| ❌ Hard to maintain | Any change to one behaviour affects others |
| ❌ Hard to test | Can't test email or audit separately |
| ❌ Hard to extend | Adding Slack or SMS later will clutter it even more |

* * * * *

✅ Refactored Design Using SRP
-----------------------------

We break the logic into separate classes --- each doing **one job**. This follows SRP.

* * * * *

**1️⃣ CaseOwnerAssigner -- Assigns to queue**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/aeb4371cc7c23d90b9251a21553cfa9d611730b1/force-app/main/default/classes/SOLID/S%20-%20Single%20Responsibility%20Principle/CaseOwnerAssigner.cls#L1-L8

* * * * *

**2️⃣ CaseNotifier -- Sends email notifications**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/aeb4371cc7c23d90b9251a21553cfa9d611730b1/force-app/main/default/classes/SOLID/S%20-%20Single%20Responsibility%20Principle/CaseNotifier.cls#L1-L14

* * * * *

**3️⃣ CaseAuditLogger -- Creates audit record**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/aeb4371cc7c23d90b9251a21553cfa9d611730b1/force-app/main/default/classes/SOLID/S%20-%20Single%20Responsibility%20Principle/CaseAuditLogger.cls#L1-L14

* * * * *

**4️⃣ CaseTiggerHandler -- Now acts as an orchestrator**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/aeb4371cc7c23d90b9251a21553cfa9d611730b1/force-app/main/default/classes/SOLID/S%20-%20Single%20Responsibility%20Principle/CaseTriggerHandler_Good.cls#L1-L14

* * * * *

✅ Benefits of Following SRP
---------------------------

| Benefit | Explanation |
| --- | --- |
| 🔁 Reusable code | You can reuse `CaseNotifier` in other places |
| 🧪 Easier testing | Test each class in isolation |
| 🔄 Easy to change | Changing queue name only affects `CaseOwnerAssigner` |
| ➕ Easier to add features | Want to send Slack message? Just add a new class like `SlackNotifier` |
| 📦 Clean architecture | Each class does **one job**, making the system modular |

### O - Open/Closed Principle

> **"Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification."**

This means:
-   You **should be able to add new behaviour** without changing existing, tested, working code.
-   You **achieve this with abstraction** (interfaces, virtual classes) and **polymorphism** (override methods, strategies, etc.).

**📘 Real-Life Salesforce Scenario**

> Your company uses Salesforce to manage **Orders** and each Order can come from different **Sales Channels** (e.g., `Online`, `Partner`, `Internal`, `Marketplace`, etc.).

**Each sales channel has a different commission calculation rule:**
-   **Online:** 12% commission
-   **Partner:** 10% + bonus if over ₹100,000
-   **Internal:** No commission
-   **Marketplace:** 8% + flat platform fee deduction

You need to calculate and populate the `Commission__c` field for each `Order__c` record based on its `Channel__c`.

New channels might be added frequently in the future.

**❌ Bad Design -- Violates OCP**

Here's a version that does everything in one class:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/4c042dabac79ff3f4e8123ab485d867583d708bd/force-app/main/default/classes/SOLID/O%20-%20Open-Closed%20Principle/OrderCommissionCalculator_Bad.cls#L1-L42

**❌ Problems:**
-   Every time a new channel is introduced or logic changes, you **must modify** this class.
-   Very hard to test each channel independently.
-   You risk **breaking working logic** while adding new logic.
-   Violates **Open/Closed Principle**.

**✅ Good Design -- Follows OCP (Open for Extension, Closed for Modification)**

We'll refactor using **abstraction + polymorphism**.

**1️⃣ Define the Strategy Interface**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/4c042dabac79ff3f4e8123ab485d867583d708bd/force-app/main/default/classes/SOLID/O%20-%20Open-Closed%20Principle/ICommissionCalculator.cls#L1-L3

**2️⃣ Implement Channel-Specific Strategies**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/4c042dabac79ff3f4e8123ab485d867583d708bd/force-app/main/default/classes/SOLID/O%20-%20Open-Closed%20Principle/OnlineOrderCommissionCalculator.cls#L1-L11

https://github.com/khushal-ganani/design-patterns-salesforce/blob/4c042dabac79ff3f4e8123ab485d867583d708bd/force-app/main/default/classes/SOLID/O%20-%20Open-Closed%20Principle/PartnerOrderCommissionCalculator.cls#L1-L11

https://github.com/khushal-ganani/design-patterns-salesforce/blob/4c042dabac79ff3f4e8123ab485d867583d708bd/force-app/main/default/classes/SOLID/O%20-%20Open-Closed%20Principle/InternalOrderCommissionCalculator.cls#L1-L11

**3️⃣ Define the `OrderCommissionCalculator_Good`**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/4c042dabac79ff3f4e8123ab485d867583d708bd/force-app/main/default/classes/SOLID/O%20-%20Open-Closed%20Principle/OrderCommissionCalculator_Good.cls#L1-L18

**🚀 Future Expansion — The OCP Power**

Suppose your company introduces a new channel: `Marketplace`, where there is a different Commission calculation logic.

All you do is:

https://github.com/khushal-ganani/design-patterns-salesforce/blob/4c042dabac79ff3f4e8123ab485d867583d708bd/force-app/main/default/classes/SOLID/O%20-%20Open-Closed%20Principle/MarketplaceOrderCommissionCalculator.cls#L1-L11

And update the Map in the `OrderCommissionCalculator_Good` class: 

https://github.com/khushal-ganani/design-patterns-salesforce/blob/4c042dabac79ff3f4e8123ab485d867583d708bd/force-app/main/default/classes/SOLID/O%20-%20Open-Closed%20Principle/OrderCommissionCalculator_Good.cls#L1-L7

- ✅ No changes to existing logic and `OrderCommissionCalculator` class (just a minimum change of the `static Map<String, System.Type>`).
- ✅ No impact on existing tested logic.
- ✅ Open to extension, but closed to modification.

**🧠 Summary**

| 🔍 Principle | 💬 Explanation |
| --- | --- |
| **Open/Closed** | You can **extend** the system for new logic without **modifying existing code** |
| **How** | Using **interfaces** and **strategy pattern** |
| **Why** | Safer, more testable, scalable and maintainable |
