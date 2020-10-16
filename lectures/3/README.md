[Lectures](../../README.md#school-lectures)
[Exercises](./exercise/README.md)

# Lecture 3 - Software Design Patterns

![gangof4](https://brigittealice.files.wordpress.com/2011/06/110614_design_pattern_elements_of_reusable.jpg)

In their classic book the authors define: *Creational*, *Structural* and *Behavioral* design patterns:

- Creational Patterns: are about systematically creating objects or families of objects based on required criterion
- Structural Patterns: helping to organize and structure code so that objects can form a larger cohesive structure
- Behavioral Patterns: abstracting common interactions between objects

## Common Design Patterns

In the following few selected patterns (for each category of pattern type) are explained in detail

### Builder Pattern

![builder](https://refactoring.guru/images/patterns/diagrams/builder/problem1.png)

```java
public class Task {
    private final long id;
    private String summary = "";
    private String description = "";
    private boolean done = false;
    private Date dueDate;

    public Task(long id) {
        this.id = id;
    }

    public Task(long id, String summary, String description, boolean done,
            Date dueDate) {
        this.id = id;
        this.summary = summary;
        this.description = description;
        this.done = done;
        this.dueDate = dueDate;

    }

    public long getId() {
        return id;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isDone() {
        return done;
    }

    public void setDone(boolean done) {
        this.done = done;
    }

    public Date getDueDate() {
        return new Date(dueDate.getTime());
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = new Date(dueDate.getTime());
    }
}
```

```java
public class TaskBuilder {

    private final long id;
    private String summary = "";
    private String description = "";
    private boolean done = false;
    private Date dueDate;

    public TaskBuilder(long id, String summary, String description, boolean done,
            Date dueDate) {
        this.id = id;
        this.summary = summary;
        this.description = description;
        this.done = done;
        this.dueDate = dueDate;
    }


    public TaskBuilder setSummary(String summary) {
        this.summary = summary;
        return this;
    }

    public TaskBuilder setDescription(String description) {
        this.description = description;
        return this;
    }

    public TaskBuilder setDone(boolean done) {
        this.done = done;
        return this;
    }

    public TaskBuilder setDueDate(Date dueDate) {
        this.dueDate = new Date(dueDate.getTime());
        return this;
    }
    public Task build() {
        return new Task(id,summary, description,done, dueDate);
    }
}
```

```java
   Task task = new TaskBuilder(5).setDescription("Hello").setSummary("Test").build();
        System.out.println(task);
```

[Ref](https://www.vogella.com/tutorials/DesignPatternBuilder/article.html)

### Facade Pattern

### Observer Pattern

## Clean Code Principles

![clean_code](https://images-na.ssl-images-amazon.com/images/I/41-+g1a2Y1L.jpg)

## Refactoring Strategies

![refactoring](https://images-na.ssl-images-amazon.com/images/I/51k+BvsOl2L.jpg)

## Anti-Patterns
