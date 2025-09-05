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

### 🎯 How Do SOLID Principles Relate to Design Patterns?

> Think of **SOLID** principles as the **"rules" or "guiding principles"** of clean object-oriented design.\
> Think of **Design Patterns** as **"solutions to recurring design problems"**.

If you **understand SOLID**, you'll:
-   Know **why** a design pattern is structured a certain way,
-   Avoid misusing patterns (e.g., using inheritance wrongly),
-   Build your **own reusable designs** effectively.

### ✅ Why Are They Important?

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

### ✅ Summary

-   **SOLID** is a set of five key principles for building well-structured, maintainable, and testable object-oriented software.

-   These principles **guide your thinking** when choosing or building design patterns.

-   In Salesforce Apex, they help you build code that's easier to **test, change, and scale**.

-   Learning SOLID is like learning the **grammar of clean software design** --- design patterns are the **sentences** you write with it.

### S - Single Responsibility Principle

The Single Responsibility Principle states that: **“A class/module should have only one reason to change, meaning that it should have only one responsibility or purpose.”**

This principle encourages you to create classes that are more focused and perform a single well-defined task, rather than multiple tasks. Breaking up classes into smaller, more focused units makes code easier to understand, maintain, and test.

**🔍 Real-Life Salesforce Scenario**

**💼 Business Requirement:**

> When a **Case** is created in Salesforce:

1.  It should automatically assign the **Support Queue** as the owner.

2.  It should **send a notification email** to the assigned queue.

3.  It should create a custom object record (e.g., `CaseAudit__c`) to log the event.

4.  It should send a Slack message to support channel (in the future).

We will first **violate SRP** and then **refactor it** using SRP.

* * * * *

**❌ Bad Design (Violates SRP)**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/aeb4371cc7c23d90b9251a21553cfa9d611730b1/force-app/main/default/classes/SOLID/S%20-%20Single%20Responsibility%20Principle/CaseTriggerHandler_Bad.cls#L1-L36

**❌ Problems with the Above Code:**

| Problem | Why it's bad |
| --- | --- |
| 🚨 Too many responsibilities | Assigning owner, sending email, logging audit |
| ❌ Hard to maintain | Any change to one behaviour affects others |
| ❌ Hard to test | Can't test email or audit separately |
| ❌ Hard to extend | Adding Slack or SMS later will clutter it even more |

* * * * *

**✅ Refactored Design Using SRP**

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

https://github.com/khushal-ganani/design-patterns-salesforce/blob/fce6a0b76b9a4ac384a70d9fe0e8f9d38b8f61fd/force-app/main/default/classes/SOLID/S%20-%20Single%20Responsibility%20Principle/CaseTriggerHandler_Good.cls#L1-L14

* * * * *

**✅ Benefits of Following SRP**

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

### L - Liskov Substitution Principle

**Overview**
> Objects of a superclass should be replaceable with objects of its subclasses without breaking the application functionality.

The Liskov Substitution Principle (LSP) is the "L" in the SOLID principles of object-oriented design. This principle ensures that inheritance relationships are designed correctly and that subclasses can seamlessly replace their parent classes without causing unexpected behaviour.

In practical terms, LSP means that if you have a method that expects a `Vehicle` object, you should be able to pass it a `Car` object, `Truck` object, or any other subclass of `Vehicle` without the method failing or behaving unexpectedly. The subclass should honour the "contract" established by the parent class.

This principle is crucial for creating robust and maintainable inheritance hierarchies, ensuring that polymorphism works correctly in your Salesforce Apex applications.

**📘 Real Life Salesforce Scenario**

Your company processes various types of **Payment Methods** in Salesforce, and each payment type has different processing rules and validation requirements.

**The payment types include:**
- **Credit Card:** Requires card validation, authorization, and charges processing fees
- **Bank Transfer:** Requires account verification and has longer processing times
- **Digital Wallet:** Requires token validation and instant processing
- **Gift Card:** Requires balance checking and redemption tracking

You need to create a flexible system that allows any payment processor to handle different payment types without requiring knowledge of their specific implementation details, ensuring that all payment methods can be used interchangeably.

**❌ Bad Example (Anti-Pattern)**

A common violation of LSP occurs when subclasses change the expected behavior of the parent class methods, throw unexpected exceptions, or have different preconditions/postconditions than the parent class.

**Code Example - Bad Implementation**

**📃 The contract (`abstract` class)**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/force-app/main/default/classes/SOLID/L%20-%20Liskov%20Substitution%20Principle/Bad%20Example/PaymentProcessor_Bad.cls#L1-L5

**1️⃣ The Credit Card Processor Strategy**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/force-app/main/default/classes/SOLID/L%20-%20Liskov%20Substitution%20Principle/Bad%20Example/CreditCardProcessor_Bad.cls#L1-L17

**2️⃣ The Gift Card Processor Strategy**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/force-app/main/default/classes/SOLID/L%20-%20Liskov%20Substitution%20Principle/Bad%20Example/GiftCardProcessor_Bad.cls#L1-L22

**3️⃣ The Bank Transfer Processor Strategy**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/force-app/main/default/classes/SOLID/L%20-%20Liskov%20Substitution%20Principle/Bad%20Example/BankTransferProcessor_Bad.cls#L1-L17

**❌ Usage - Bad Example**

**The Service Class**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/force-app/main/default/classes/SOLID/L%20-%20Liskov%20Substitution%20Principle/Bad%20Example/PaymentService_Bad.cls#L1-L21

**Usage of the Service Class (Anonymous Window)**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/scripts/apex/SOLID/L%20-%20Liskov%20Substitution%20Principle/LSPBadExample.apex#L1-L8

**Problems with This Approach**

| Problem | Description | Impact |
|---------|-------------|---------|
| **Unexpected Exceptions** | Subclasses throw exceptions that parent class contract doesn't specify | Client code breaks when switching between implementations |
| **Inconsistent Return Values** | Different subclasses return different types of values (negative fees, always false) | Business logic produces incorrect results |
| **Changed Preconditions** | Subclasses have stricter requirements than parent class | Code that works with parent class fails with subclasses |
| **Broken Contracts** | Methods don't fulfill the promises made by the parent class interface | Polymorphism becomes unreliable and dangerous |
| **Unpredictable Behavior** | Each subclass behaves differently in unexpected ways | System becomes fragile and hard to maintain |

**✅ Good Example (Proper Implementation following LSP)**

The correct implementation ensures that all subclasses can be used interchangeably with the parent class, maintaining consistent behaviour and honouring the established contract.

**Code Example - Good Implementation**

**📃 Abstract Payment Processor Base Class**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/force-app/main/default/classes/SOLID/L%20-%20Liskov%20Substitution%20Principle/Good%20Example/PaymentProcessor_Good.cls#L1-L24

**1️⃣ Credit Card Processor Implementation**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/force-app/main/default/classes/SOLID/L%20-%20Liskov%20Substitution%20Principle/Good%20Example/CreditCardProcessor_Good.cls#L1-L38

**2️⃣ Gift Card Processor Implementation**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/force-app/main/default/classes/SOLID/L%20-%20Liskov%20Substitution%20Principle/Good%20Example/GiftCardProcessor_Good.cls#L1-L39

**3️⃣ Bank Transfer Processor Implementation**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/force-app/main/default/classes/SOLID/L%20-%20Liskov%20Substitution%20Principle/Good%20Example/BankTransferProcessor_Good.cls#L1-L37

**✅ Usage - Good Example**

**The Service Class**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/force-app/main/default/classes/SOLID/L%20-%20Liskov%20Substitution%20Principle/Good%20Example/PaymentService_Good.cls#L1-L40

**Usage of the Service Class (Anonymous Window)**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/6de2d9c35af5b85be144412e7faf49af4554ea21/scripts/apex/SOLID/L%20-%20Liskov%20Substitution%20Principle/LSPGoodExample.apex#L1-L9

**Benefits of This Approach**

| Benefit | Description | Business Value |
|---------|-------------|----------------|
| **Interchangeability** | Any payment processor can be used without changing client code | Easy to add new payment methods without system changes |
| **Consistent Behavior** | All processors follow the same contract and behavioral expectations | Predictable system behavior and fewer bugs |
| **Simplified Testing** | Mock implementations can easily replace real processors | Better test coverage and easier unit testing |
| **Future-Proof Design** | New payment types can be added without modifying existing code | Reduced development time for new features |

**Key Benefits**

- ✅ **Seamless Substitutability**: Any subclass can replace the parent class without breaking functionality
- ✅ **Behavioral Consistency**: All implementations follow the same contract and expectations
- ✅ **Reduced Coupling**: Client code depends on abstractions, not concrete implementations
- ✅ **Enhanced Polymorphism**: True polymorphic behavior where objects can be used interchangeably
- ✅ **Easier Maintenance**: Changes to specific implementations don't affect client code

**✅ When to Use**

- When designing inheritance hierarchies with multiple implementations
- When you need polymorphic behavior where objects should be interchangeable
- When building plugin-style architectures in Salesforce
- When creating frameworks or reusable components that others will extend
- When implementing the Strategy pattern or similar behavioral patterns
- When you have multiple ways to accomplish the same business goal

**❌ When NOT to Use**

- When subclasses have fundamentally different purposes or behaviors
- When the relationship is "has-a" rather than "is-a" (use composition instead)
- When subclasses would need to violate the parent class contract
- For simple utility classes that don't need inheritance
- When performance is critical and polymorphism adds unnecessary overhead

**💡 Real-World Salesforce Scenarios**

1. **Notification Systems**: Different notification channels (Email, SMS, Push) that all implement a common `NotificationSender` interface, allowing the system to send notifications through any channel without knowing the specific implementation.

2. **Data Validation Frameworks**: Various validation rules (Required Field, Format, Range) that all extend a base `ValidationRule` class, enabling the validation engine to process any rule type uniformly.

3. **Integration Adapters**: Different external system connectors (REST API, SOAP, Database) that all implement a common `ExternalSystemAdapter` interface, allowing the integration layer to work with any system using the same code.

**📃 Summary**

The Liskov Substitution Principle ensures that inheritance relationships are designed correctly by requiring subclasses to be fully substitutable for their parent classes. In Salesforce development, this principle helps create robust, flexible systems where new implementations can be added without breaking existing functionality, leading to more maintainable and extensible code that truly leverages the power of object-oriented programming.

### I - Interface Segregation Principle (ISP)

**Overview**
> Clients should not be forced to depend on interfaces they do not use.

The Interface Segregation Principle is the "I" in SOLID principles and focuses on creating focused, role-specific interfaces rather than monolithic ones. This principle states that no class should be forced to implement methods it doesn't need or use. Instead of having one large interface that handles multiple responsibilities, we should break it down into smaller, more specific interfaces that serve particular needs.

**Key Benefits:**
- **Reduces coupling** between classes and unnecessary dependencies
- **Improves maintainability** by making interfaces focused and cohesive
- **Enhances flexibility** by allowing classes to implement only what they need

**📧 Real Life Salesforce Scenario**

Your Salesforce org needs to send **Notifications** to different types of users based on various events:

**User Types and Their Notification Needs:**
- **Customers:** Need email notifications only
- **Sales Reps:** Need email and SMS notifications
- **Managers:** Need email, SMS, and push notifications to mobile app

Currently, you have a single notification interface that all notification services must implement, but most services only need a subset of these notification methods.

**❌ Bad Example (Anti-Pattern)**

The violation occurs when we create a single "fat" interface that forces all implementing classes to implement notification methods they don't support.

**❌ Code Example - Bad Implementation**

**The Fat Interface**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/0f842c3d802801bd403d20b5647a4ab1c4334a72/force-app/main/default/classes/SOLID/I%20-%20Interface%20Segregation%20Principle/Bad%20Example/NotificationService_Bad.cls#L1-L6

**The Implementation**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/0f842c3d802801bd403d20b5647a4ab1c4334a72/force-app/main/default/classes/SOLID/I%20-%20Interface%20Segregation%20Principle/Bad%20Example/CustomerNotificationService_Bad.cls#L1-L18

**❌ Usage - Bad Example**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/0f842c3d802801bd403d20b5647a4ab1c4334a72/scripts/apex/SOLID/I%20-%20Interface%20Segregation%20Principle/ISPBadExample.apex#L1-L13

**❌ Problems with This Approach**

| Problem | Description | Impact |
|---------|-------------|---------|
| **Forced Implementation** | Classes must implement methods they don't support | Leads to exceptions or empty implementations |
| **Interface Pollution** | Single interface contains unrelated notification methods | Difficult to understand what each service actually supports |
| **Runtime Errors** | Unused methods throw exceptions when called | Creates unreliable code that fails at runtime |
| **Tight Coupling** | All services depend on all notification types | Changes affect services that don't use those methods |

**✅ Good Example (Proper Implementation following ISP)**

The correct approach is to segregate the interface into smaller, focused interfaces based on specific notification types. Each service implements only the notification methods it actually supports.

**✅ Code Example - Good Implementation**

**1️⃣ Segregated Notification Interfaces**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/0f842c3d802801bd403d20b5647a4ab1c4334a72/force-app/main/default/classes/SOLID/I%20-%20Interface%20Segregation%20Principle/Good%20Example/EmailNotifier_Good.cls#L1-L3

https://github.com/khushal-ganani/design-patterns-salesforce/blob/0f842c3d802801bd403d20b5647a4ab1c4334a72/force-app/main/default/classes/SOLID/I%20-%20Interface%20Segregation%20Principle/Good%20Example/SMSNotifier_Good.cls#L1-L3

https://github.com/khushal-ganani/design-patterns-salesforce/blob/0f842c3d802801bd403d20b5647a4ab1c4334a72/force-app/main/default/classes/SOLID/I%20-%20Interface%20Segregation%20Principle/Good%20Example/PushNotifier_Good.cls#L1-L3

**2️⃣ Focused Implementation Classes**

**Notifications for Customers**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/0f842c3d802801bd403d20b5647a4ab1c4334a72/force-app/main/default/classes/SOLID/I%20-%20Interface%20Segregation%20Principle/Good%20Example/CustomerNotificationService_Good.cls#L1-L6

**Notifications for Sales Reps**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/0f842c3d802801bd403d20b5647a4ab1c4334a72/force-app/main/default/classes/SOLID/I%20-%20Interface%20Segregation%20Principle/Good%20Example/SalesRepNotificationService_Good.cls#L1-L11

**Notifications for Manager**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/0f842c3d802801bd403d20b5647a4ab1c4334a72/force-app/main/default/classes/SOLID/I%20-%20Interface%20Segregation%20Principle/Good%20Example/ManagerNotificationService_Good.cls#L1-L16

**✅ Usage - Good Example**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/0f842c3d802801bd403d20b5647a4ab1c4334a72/scripts/apex/SOLID/I%20-%20Interface%20Segregation%20Principle/ISPGoodExample.apex#L1-L18

**✅ Benefits of This Approach**

| Benefit | Description | Impact |
|---------|-------------|---------|
| **No Forced Methods** | Classes only implement methods they actually support | No exceptions or empty implementations |
| **Clear Contracts** | Each interface represents a specific capability | Easy to understand what each service can do |
| **Flexible Composition** | Services can implement multiple focused interfaces | Mix and match capabilities as needed |
| **Isolated Changes** | Changes to one notification type don't affect others | Better maintainability and stability |

**✅ Key Benefits**

- ✅ **Eliminates unnecessary methods** - Classes only implement what they actually support
- ✅ **Clear responsibilities** - Each interface has a single, focused purpose
- ✅ **Better composition** - Services can combine multiple capabilities as needed
- ✅ **No runtime exceptions** - All implemented methods are actually supported
- ✅ **Easier testing** - Can mock specific notification types independently
- ✅ **Improved maintainability** - Changes are isolated to relevant interfaces

**🎯 When to Use**

- When classes implement interface methods by throwing exceptions or leaving them empty
- When different clients need different subsets of functionality
- When you have a "fat" interface that serves multiple types of users
- When changes to interface methods affect classes that don't use those methods
- When designing systems with optional or conditional capabilities

**⚠️ When NOT to Use**

- When all implementing classes genuinely need all interface methods
- When interfaces are already small and focused
- When over-segregation creates unnecessary complexity
- In simple systems where a single interface is sufficient
- When the cost of multiple interfaces outweighs the benefits

**🌟 Real-World Salesforce Scenarios**

1. **Record Processing**: Separate interfaces for validation, transformation, and persistence rather than one large record processor interface

2. **API Integrations**: Different interfaces for authentication, data retrieval, and data pushing instead of one monolithic API interface

3. **Reporting Services**: Segregated interfaces for data extraction, formatting, and delivery rather than forcing all report types to support all operations

**📝 Summary**

The Interface Segregation Principle ensures that classes only depend on the methods they actually use by creating focused, role-specific interfaces. In Salesforce development, this leads to cleaner, more maintainable code where each class implements only the capabilities it genuinely supports, eliminating forced implementations and runtime exceptions.

### D - Dependency Inversion Principle (DIP)

**Overview**
> The Dependency Inversion Principle states that high-level modules should not depend on low-level modules. Both should depend on abstractions. Additionally, abstractions should not depend on details; details should depend on abstractions.

The Dependency Inversion Principle is the "D" in SOLID principles and is fundamental to creating flexible, maintainable code. Instead of having your business logic classes directly instantiate and depend on concrete implementations, they should depend on interfaces or abstract classes.

**Key concepts include:**
- **High-level modules** (business logic) should not depend on **low-level modules** (implementation details)
- Both should depend on **abstractions** (interfaces/abstract classes)
- **Dependency Injection** is a technique to achieve DIP by injecting dependencies from the outside

**📧 Real Life Salesforce Scenario**

Your company uses Salesforce to process **Orders** and needs to send notifications when orders are created. The system should support multiple notification channels and be flexible enough to add new ones without changing existing code.

**Current requirements:**
- Send **email notifications** to customers via Email Service
- Send **SMS notifications** for high-priority orders via SMS Service  
- **Future**: Add Slack notifications, push notifications, etc.

You need to build an `OrderProcessor` that can handle notifications through different channels without being tightly coupled to specific notification implementations.

**❌ Bad Example (Anti-Pattern)**

In this approach, the `OrderProcessor` directly depends on concrete notification classes, violating the Dependency Inversion Principle. The high-level module (OrderProcessor) depends directly on low-level modules (EmailService, SMSService).

**🚫 Code Example - Bad Implementation**

**Email Service Class**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/e9df00427f9d2700fe4ecad5afc49fa3fb65cb4d/force-app/main/default/classes/SOLID/D%20-%20Dependency%20Inversion%20Principle/Bad%20Example/EmailService_Bad.cls#L1-L14

**SMS Service Class**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/e9df00427f9d2700fe4ecad5afc49fa3fb65cb4d/force-app/main/default/classes/SOLID/D%20-%20Dependency%20Inversion%20Principle/Bad%20Example/SMSService_Bad.cls#L1-L13

**Order Processor Class**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/e9df00427f9d2700fe4ecad5afc49fa3fb65cb4d/force-app/main/default/classes/SOLID/D%20-%20Dependency%20Inversion%20Principle/Bad%20Example/OrderProcessor_Bad.cls#L1-L24

**🔧 Usage - Bad Example**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/e9df00427f9d2700fe4ecad5afc49fa3fb65cb4d/scripts/apex/SOLID/D%20-%20Dependency%20Inversion%20Principle/DIPBadExample.apex#L1-L11

**⚠️ Problems with This Approach**

| Problem | Description | Impact |
|---------|-------------|---------|
| **Tight Coupling** | OrderProcessor directly creates and depends on concrete classes | Hard to modify or extend notification types |
| **Difficult Testing** | Cannot easily mock EmailService or SMSService for unit tests | Poor testability and test coverage |
| **Violates Open/Closed** | Must modify OrderProcessor to add new notification types | Breaks existing functionality when adding features |
| **Hard to Configure** | Cannot change notification services at runtime | Inflexible system configuration |
| **Code Duplication** | Similar notification logic repeated for each service type | Maintenance overhead and inconsistency |

**✅ Good Example (Proper Implementation following DIP)**

The correct implementation uses interfaces (abstractions) that both high-level and low-level modules depend on. The `OrderProcessor` depends on the `INotificationService` interface, not concrete implementations. Dependencies are injected from outside, following the Dependency Injection pattern.

**🎯 Code Example - Good Implementation**

**1️⃣ Notification Service Interface**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/e9df00427f9d2700fe4ecad5afc49fa3fb65cb4d/force-app/main/default/classes/SOLID/D%20-%20Dependency%20Inversion%20Principle/Good%20Example/INotificationService.cls#L1-L4

**2️⃣ Email Service Implementation**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/e9df00427f9d2700fe4ecad5afc49fa3fb65cb4d/force-app/main/default/classes/SOLID/D%20-%20Dependency%20Inversion%20Principle/Good%20Example/EmailService_Good.cls#L1-L18

**3️⃣ SMS Service Implementation**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/e9df00427f9d2700fe4ecad5afc49fa3fb65cb4d/force-app/main/default/classes/SOLID/D%20-%20Dependency%20Inversion%20Principle/Good%20Example/SMSService_Good.cls#L1-L18

**4️⃣ Order Processor (High-Level Module)**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/e9df00427f9d2700fe4ecad5afc49fa3fb65cb4d/force-app/main/default/classes/SOLID/D%20-%20Dependency%20Inversion%20Principle/Good%20Example/OrderProcessor_Good.cls#L1-L17

**🚀 Usage - Good Example**

https://github.com/khushal-ganani/design-patterns-salesforce/blob/e9df00427f9d2700fe4ecad5afc49fa3fb65cb4d/scripts/apex/SOLID/D%20-%20Dependency%20Inversion%20Principle/DIPGoodExample.apex#L1-L15

**🎉 Benefits of This Approach**

| Benefit | Description | Value |
|---------|-------------|--------|
| **Loose Coupling** | OrderProcessor depends on interface, not concrete classes | Easy to swap implementations |
| **Easy Testing** | Can inject mock services for unit testing | Better test coverage and reliability |
| **Extensibility** | Add new notification types without changing existing code | Follows Open/Closed Principle |
| **Flexibility** | Can configure different services at runtime | Adaptable to changing requirements |
| **Maintainability** | Changes to notification logic don't affect OrderProcessor | Reduced maintenance overhead |

**✨ Key Benefits**

- ✅ **Follows SOLID Principles**: Especially DIP and Open/Closed Principle
- ✅ **Improved Testability**: Easy to mock dependencies for unit testing
- ✅ **Better Flexibility**: Can easily add new notification channels (Slack, Teams, etc.)
- ✅ **Reduced Coupling**: High-level modules independent of low-level implementation details
- ✅ **Runtime Configuration**: Can change notification services without code changes
- ✅ **Code Reusability**: Notification services can be reused across different processors

**🎯 When to Use**

- When building service layers that depend on external systems (APIs, databases, email services)
- When you need to support multiple implementations of the same functionality
- When creating testable code that requires dependency mocking
- When building configurable systems that need to swap implementations
- When working with integrations that may change frequently
- For any business logic that depends on infrastructure concerns

**🚨 When NOT to Use**

- For simple, one-time scripts or utilities with no testing requirements
- When you're absolutely certain the implementation will never change
- For very small projects where the overhead doesn't justify the benefits
- When working with Salesforce standard objects that have fixed APIs
- For simple data transformations that don't involve external dependencies

**🏢 Real-World Salesforce Scenarios**

1. **Payment Processing**: OrderProcessor depending on IPaymentGateway (Stripe, PayPal, Square) implementations
2. **Data Synchronisation**: SyncService depending on IDataRepository (Salesforce, External DB, File System) implementations  
3. **Document Generation**: ReportGenerator depending on IDocumentService (PDF, Word, Excel) implementations
4. **Lead Assignment**: LeadDistributor depending on IAssignmentStrategy (Round-Robin, Territory-Based, Skills-Based) implementations

**💡 Summary**

The Dependency Inversion Principle, combined with Dependency Injection, creates flexible and maintainable Salesforce applications. By depending on abstractions rather than concrete implementations, your business logic becomes independent of infrastructure concerns, making your code more testable, extensible, and robust. This is especially valuable in Salesforce environments where integrations and business requirements frequently evolve.
