[Lectures](../../README.md#school-lectures)

# Lecture 1 - UML Introduction

This lecture is about familiarizing with UML diagram types. Note that we will not study 
all existing UML diagram types but only those which are commonly used in projects.

## Unified Modeling Language (UML)

UML is used in non-trivial projects for...

- modeling
- documentation
- visualization
- specification
- discussion

UML is not...

- to describe the real world perfectly
- complete in a sense that it captures all facets of the problem
- a programming language
- not specialised for one particular domain
- a replacement for textual descriptions
- agile method or project management approach

#### Model vs Reality

![map](./../../bin/static/map.png)

![satellite](./../../bin/static/satellite.png)

This example should demonstrate that a model is only there to capture the essential parts of an entity in the real world.
If we try to model out every aspect then it is harder to focus on the _important_ parts of a model.

#### Tools to draw UML Diagrams

[Draw.io](http://www.draw.io) is a easy to use website which has many predefined symbols and icons
![Draw.io](https://i.ytimg.com/vi/lAtCySGDD48/maxresdefault.jpg)

If you prefer something declaratively then try [PlantUML](http://www.plantuml.com). All diagrams in this script
were created with PlantUML. You can find the sources for the diagrams in the [diagrams](./../../bin/diagrams) directory.

```puml
@startuml
left to right direction
actor "Food Critic" as fc
package Restaurant {
  usecase "Eat Food" as UC1
  usecase "Pay for Food" as UC2
  usecase "Drink" as UC3
}
fc --> UC1
fc --> UC2
fc --> UC3
@enduml
```

Declaration for the Use Case diagram below.

## Use Case Diagram

![use_case](../../bin/dist/use_case.png)

The purpose of the use case diagram is to model out:
- all relevant actors inside a use case
- the system context
- the actions (i.e. use cases) an actor can do

In the above example the system context is `Restaurant` in which the actor `Food critic` can
- `Eat Food`
- `Pay for Food`
- `Drink`

### Notation

![notation](https://sourcemaking.com/files/sm/images/uml/img_20.jpg)

### Include vs Extend Relationship

![diagram](https://forums.visual-paradigm.com/uploads/default/original/2X/b/b7c86c1c4b28af2f5a60616477fafe154bc04e33.png)

The difference between an 'include' vs 'exclude' use case relationship is: 'include' means that a use case is automatically part
of another use case, in the example above: when opening a book, reading is included as a use case.

'exclude' is something optional - in the above example one can open a book and _optionally_ turn a page.

## Class Diagram

![use_case](../../bin/dist/class.png)

Class diagrams are representing

- the hierarchical structure of a system  
- the attributes and methods of classes and interfaces
- the relationships between classes and interfaces

### Notation

![notation](https://www.tutorialspoint.com/uml/images/notation_class.jpg)

### Attributes and Methods

![relation](../../bin/dist/class_body.png)

Methods have a `()` in their name. Attributes have a name and a type information, e.g. `int age`.

UML Visibility Notation
```
- private member
+ public member
# protected member
```

In the above example the weight and age attributes of a User are private, whereas the name is public.
The methods getName() and setName() are public whereas getting the address is private.

### Relationships and Associations

![relation](../../bin/dist/relationship.png)

Interpretation of the Diagram:

A driver drives a car.

A car has 4 wheels.

A person owns a car.

![association](../../bin/dist/association.png)

Explanation: 0 - n students can be enrolled in a course.

### Aggregations and Compositions

![relation](../../bin/dist/aggregations.png)

A aggregation expresses a "has"-relationship. In the above the pond has none or n swans.

![relation](../../bin/dist/composition.png)

A composition expresses a "owns"-relationship. A library owns books.

### Inheritance

![relation](../../bin/dist/inheritance.png)

In order to model out generalizations, unfilled arrows are pointing from the implementation to the parent class which can in turn be 
a class, an abstract class or an interface.

In the above example we can see that ArrayList is fundamentally a Collection since it inherits from AbstractList which in turn
inherits from List which extends the Collection interface.

## Sequence Diagram

![use_case](../../bin/dist/sequence.png)

## State Diagram

![use_case](../../bin/dist/state.png)