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

### Creational Pattern:  Builder Pattern

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

[Source](https://www.vogella.com/tutorials/DesignPatternBuilder/article.html)

### Structural Pattern: Facade Pattern

![facade](https://www.baeldung.com/wp-content/uploads/2018/04/facade-class-diagram.png)

```
airFlowController.takeAir()
fuelInjector.on()
fuelInjector.inject()
starter.start()
coolingController.setTemperatureUpperLimit(DEFAULT_COOLING_TEMP)
coolingController.run()
catalyticConverter.on()
```

```
fuelInjector.off()
catalyticConverter.off()
coolingController.cool(MAX_ALLOWED_TEMP)
coolingController.stop()
airFlowController.off()
```

```
public class CarEngineFacade {
    private static int DEFAULT_COOLING_TEMP = 90;
    private static int MAX_ALLOWED_TEMP = 50;
    private FuelInjector fuelInjector = new FuelInjector();
    private AirFlowController airFlowController = new AirFlowController();
    private Starter starter = new Starter();
    private CoolingController coolingController = new CoolingController();
    private CatalyticConverter catalyticConverter = new CatalyticConverter();
 
    public void startEngine() {
        fuelInjector.on();
        airFlowController.takeAir();
        fuelInjector.on();
        fuelInjector.inject();
        starter.start();
        coolingController.setTemperatureUpperLimit(DEFAULT_COOLING_TEMP);
        coolingController.run();
        catalyticConverter.on();
    }
 
    public void stopEngine() {
        fuelInjector.off();
        catalyticConverter.off();
        coolingController.cool(MAX_ALLOWED_TEMP);
        coolingController.stop();
        airFlowController.off();
    }

```

```
facade.startEngine();
// ...
facade.stopEngine();
```

[Source](https://www.baeldung.com/java-facade-pattern)

### Behavioral Pattern: Observer Pattern

![observer](https://miro.medium.com/1*W0B2TW5Ekh8-bULK5MIvdA.jpeg)

```
public class NewsAgency {
    private String news;
    private List<Channel> channels = new ArrayList<>();
 
    public void addObserver(Channel channel) {
        this.channels.add(channel);
    }
 
    public void removeObserver(Channel channel) {
        this.channels.remove(channel);
    }
 
    public void setNews(String news) {
        this.news = news;
        for (Channel channel : this.channels) {
            channel.update(this.news);
        }
    }
}
```

```
public class NewsChannel implements Channel {
    private String news;
 
    @Override
    public void update(Object news) {
        this.setNews((String) news);
    } 
}
```

```
public interface Channel {
    public void update(Object o);
}
```

```
NewsAgency observable = new NewsAgency();
NewsChannel observer = new NewsChannel();
 
observable.addObserver(observer);
observable.setNews("news");
assertEquals(observer.getNews(), "news");

```

[Source](https://www.baeldung.com/java-observer-pattern)

## Clean Code Principles

![clean_code](https://images-na.ssl-images-amazon.com/images/I/41-+g1a2Y1L.jpg)

## Refactoring Strategies

![refactoring](https://images-na.ssl-images-amazon.com/images/I/51k+BvsOl2L.jpg)

## Anti-Patterns
