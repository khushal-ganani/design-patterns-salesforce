# Design Patterns 

Design patterns are **proven solutions to recurring problems** in software design, which are high-quality, reusable, loosely-coupled and maintainable object-oriented software systems. They capture design experience in a usable form, providing a **standard vocabulary for developers**. Essentially, a design pattern names, abstracts, and identifies the key aspects of a common design structure that make it useful for creating a reusable object-oriented design. The well-known "Gang of Four" (GoF) patterns consist of 23 such patterns, grouped into three categories: **Creational, Structural, and Behavioural**.

## Why Design Patterns?

Learning design patterns is essential for several reasons:

- **Improved Code Quality**: Using design patterns often results in **more maintainable, flexible, and extensible code**. They help promote **loose coupling** and encapsulate design decisions, making codebases easier to understand, modify, and extend. They embody best practices and principles of software design. For Example, most of the Salesforce Apex frameworks that organizations follow are built following these design patterns.
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
