# Software Engineering Lecture

![logo](https://knda.de/wp-content/uploads/2019/Betriebe/FOM_2015_CMYK_MitWortmarke.png)

Slides & example code from the Software Engineering lecture first held WS 20/21 @ [FOM University of Applied Sciences for Economics and Management Berlin](https://www.fom.de/studiengaenge/it-management/bachelor-studiengaenge/informatik/_produkte;inhalte.html).

The lecture is practical-oriented, e.g. it doesn't explain all possible UML diagram types but rather focuses on few selected key topics. All explanations are accompanied by code examples and UML diagrams. Also, all lectures contain exercises together with solutions. The target audience of this lecture are students which are familiar with at least one high-level programming language, e.g. Java.

## :mag_right: Focus

The key focus of the lecture is:

- Software Design and Modeling: UML, Design Patterns, Architecture Patterns, SOLID Principles, Modularisation
- Implementing and Integrating Real-Word Software Systems: Clean Code, Top-down vs Bottom-Up approach, Continuous Integration, Continuous Delivery

## :no_entry_sign: Non-Focus

Topics which are not discussed, but which will be addressed by my colleagues during the semester, are:

- Project Management
- Requirements Engineering
- Effort Estimation Techniques
- Software Testing
- Software Configurations Management
- Operating Software Systems

## :white_check_mark: Goal of the Lecture

After attending the lecture, students should be able to...

- Using UML in order to explain software systems, to capture requirements and model them out with appropriate UML diagrams
- Understand and being able to communicate important aspects of good software designs, e.g. loose coupling, high cohesion, modularisation and clean code
- Design and implement software systems in modern environments by using shown architecture and design patterns

## :school: Lectures

[1 UML Introduction](./lectures/1/README.md)

In the first lecture we are familiarizing with common UML diagram types such as: use case, class, state, and sequence diagrams

[2 Software Architecture](./lectures/2/README.md)

The second lecture is about common architecture patterns such as Model View Control (MVC), and modularisation

[3 Software Design Patterns](./lectures/3/README.md)

After looking into architecture patterns we will examine concrete design patterns and clean code practices when designing and implementing software

[4 Integrating Software Systems](./lectures/4/README.md)

This lecture is about Continuous Integration and Continuous Delivery (also known as `CI/CD`) - we will learn how to integrate and rollout software in existing software systems

[5 Case Study - Implementing an `Alerting Service`](./lectures/5/README.md)

At the end of the semester we will have a look at a small software project in which we try to apply the learned material by focusing on the following aspects:

- Understanding the requirements and use cases
- Crafting and design a solution architecture 
- Integrate and rollout the implemented solution

[6 Exam Preparation / Final Q&A](./lectures/6/README.md)

In the last lecture we will have a final look at the learned material and preparse for the examination

Note that each lecture directory contains exercises and solutions for the exercises.

For example, for [lecture 1](https://github.com/qaismyname/softwareengineering-lecture/blob/master/lectures/1/README.md) you'll find the following resources under `./lectures/1`

```bash
lectures/1
|-- README.md
|-- exercise
|   `-- README.md
`-- solution
    `-- README.md
```

## :raising_hand: How to Contribute?

Not sure how to contribute ideas, changes, etc. to this repository? Check [github.com/firstcontributions/first-contributions](https://github.com/firstcontributions/first-contributions/blob/master/README.md) out!
