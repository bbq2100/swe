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

```
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

### Includes vs Extends

## Class Diagram

![use_case](../../bin/dist/class.png)

## Sequence Diagram

![use_case](../../bin/dist/sequence.png)

## State Diagram

![use_case](../../bin/dist/state.png)