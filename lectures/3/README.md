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

### Creational Pattern: Builder Pattern

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

### Creational Pattern: Abstract Factory Pattern

![factory](https://refactoring.guru/images/patterns/content/abstract-factory/abstract-factory-en-3x.png)

![example](https://www.baeldung.com/wp-content/uploads/2018/11/updated_abstract_factory.jpg)

```java
public interface Animal {
    String getAnimal();
    String makeSound();
}

```

```java
public class Duck implements Animal {
 
    @Override
    public String getAnimal() {
        return "Duck";
    }
 
    @Override
    public String makeSound() {
        return "Squeks";
    }
}
```

```java
public interface AbstractFactory<T> {
    T create(String animalType) ;
}
```

```java
public class AnimalFactory implements AbstractFactory<Animal> {
 
    @Override
    public Animal create(String animalType) {
        if ("Dog".equalsIgnoreCase(animalType)) {
            return new Dog();
        } else if ("Duck".equalsIgnoreCase(animalType)) {
            return new Duck();
        }
 
        return null;
    }
 
}
```

```java
public class FactoryProvider {
    public static AbstractFactory getFactory(String choice){
        
        if("Animal".equalsIgnoreCase(choice)){
            return new AnimalFactory();
        }
        else if("Color".equalsIgnoreCase(choice)){
            return new ColorFactory();
        }
        
        return null;
    }
}
```

[Source](https://www.baeldung.com/java-abstract-factory-pattern)

### Structural Pattern: Facade Pattern

![facade](https://www.baeldung.com/wp-content/uploads/2018/04/facade-class-diagram.png)

```java
airFlowController.takeAir()
fuelInjector.on()
fuelInjector.inject()
starter.start()
coolingController.setTemperatureUpperLimit(DEFAULT_COOLING_TEMP)
coolingController.run()
catalyticConverter.on()
```

```java
fuelInjector.off()
catalyticConverter.off()
coolingController.cool(MAX_ALLOWED_TEMP)
coolingController.stop()
airFlowController.off()
```

```java
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

```java
facade.startEngine();
// ...
facade.stopEngine();
```

[Source](https://www.baeldung.com/java-facade-pattern)

### Structural Pattern: Decorator Pattern

![image](https://refactoring.guru/images/patterns/content/decorator/decorator-3x.png)

![example](https://www.baeldung.com/wp-content/uploads/2017/09/8poz64T.jpg)

```java
public interface ChristmasTree {
    String decorate();
}
```

```java
public class ChristmasTreeImpl implements ChristmasTree {
 
    @Override
    public String decorate() {
        return "Christmas tree";
    }
}
```

```java
public abstract class TreeDecorator implements ChristmasTree {
    private ChristmasTree tree;
    
    // standard constructors
    @Override
    public String decorate() {
        return tree.decorate();
    }
}
```

```java
public class BubbleLights extends TreeDecorator {
 
    public BubbleLights(ChristmasTree tree) {
        super(tree);
    }
    
    public String decorate() {
        return super.decorate() + decorateWithBubbleLights();
    }
    
    private String decorateWithBubbleLights() {
        return " with Bubble Lights";
    }
}
```

```java
@Test
public void whenDecoratorsInjectedAtRuntime_thenConfigSuccess() {
    ChristmasTree tree1 = new Garland(new ChristmasTreeImpl());
    assertEquals(tree1.decorate(), 
      "Christmas tree with Garland");
     
    ChristmasTree tree2 = new BubbleLights(
      new Garland(new Garland(new ChristmasTreeImpl())));
    assertEquals(tree2.decorate(), 
      "Christmas tree with Garland with Garland with Bubble Lights");
}
```

[Source](https://www.baeldung.com/java-decorator-pattern)

### Behavioral Pattern: Observer Pattern

![observer](https://miro.medium.com/1*W0B2TW5Ekh8-bULK5MIvdA.jpeg)

```java
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

```java
public class NewsChannel implements Channel {
    private String news;
 
    @Override
    public void update(Object news) {
        this.setNews((String) news);
    } 
}
```

```java
public interface Channel {
    public void update(Object o);
}
```

```java
NewsAgency observable = new NewsAgency();
NewsChannel observer = new NewsChannel();
 
observable.addObserver(observer);
observable.setNews("news");
assertEquals(observer.getNews(), "news");

```

[Source](https://www.baeldung.com/java-observer-pattern)

### Behavioral Pattern: Adapter Pattern

![adapter](https://fmoralesdev.com/wp-content/uploads/2019/06/Adapter1.jpeg)

![example](https://www.baeldung.com/wp-content/uploads/2017/09/Rpt_ER5p.jpg)

```java
public interface Movable {
    // returns speed in MPH 
    double getSpeed();
}
```

```java
public class BugattiVeyron implements Movable {
 
    @Override
    public double getSpeed() {
        return 268;
    }
}
```

```java
public interface MovableAdapter {
    // returns speed in KM/H 
    double getSpeed();
}
```


```java
public class MovableAdapterImpl implements MovableAdapter {
    private Movable luxuryCars;
    
    // standard constructors
 
    @Override
    public double getSpeed() {
        return convertMPHtoKMPH(luxuryCars.getSpeed());
    }
    
    private double convertMPHtoKMPH(double mph) {
        return mph * 1.60934;
    }
}
```

```java
Movable bugattiVeyron = new BugattiVeyron();
    MovableAdapter bugattiVeyronAdapter = new MovableAdapterImpl(bugattiVeyron);
 
    assertEquals(bugattiVeyronAdapter.getSpeed(), 431.30312, 0.00001);
```

[Source](https://www.baeldung.com/java-adapter-pattern)

## Clean Code Principles

![clean_code](https://images-na.ssl-images-amazon.com/images/I/41-+g1a2Y1L.jpg)

### KISS


### DRY

### YAGNI

### SOLID

1. Single Responsibility
2. Open/Closed
3. Liskov Substitution
4. Interface Segregation
5. Dependency Inversion

#### Single Responsibility

```java
public class Book {
 
    private String name;
    private String author;
    private String text;
 
    //constructor, getters and setters
}
```

...

```java
public class Book {
 
    private String name;
    private String author;
    private String text;
 
    //constructor, getters and setters
 
    // methods that directly relate to the book properties
    public String replaceWordInText(String word){
        return text.replaceAll(word, text);
    }
 
    public boolean isWordInText(String word){
        return text.contains(word);
    }
}
```

...

```java
public class Book {
    //...
 
    void printTextToConsole(){
        // our code for formatting and printing the text
    }
}
```

```java
 
    // methods for outputting text
    void printTextToConsole(String text){
        //our code for formatting and printing the text
    }
 
    void printTextToAnotherMedium(String text){
        // code for writing to any other location..
    }
}
```

#### Open/Closed

```java
public class Guitar {
 
    private String make;
    private String model;
    private int volume;
 
    //Constructors, getters & setters
}
```

```java
public class SuperCoolGuitarWithFlames extends Guitar {
 
    private String flameColor;
 
    //constructor, getters + setters
}

```

#### Liskov Substitution

"subclasses should be substitutable for their base classes" [Robert C. Martin](https://web.archive.org/web/20150906155800/http://www.objectmentor.com/resources/articles/Principles_and_Patterns.pdf)

```java
public interface Car {

    void turnOnEngine();
    void accelerate();
}
```

```java
public class MotorCar implements Car {
 
    private Engine engine;
 
    //Constructors, getters + setters
 
    public void turnOnEngine() {
        //turn on the engine!
        engine.on();
    }
 
    public void accelerate() {
        //move forward!
        engine.powerOn(1000);
    }
}
```

```java
public class ElectricCar implements Car {
 
    public void turnOnEngine() {
        throw new AssertionError("I don't have an engine!");
    }
 
    public void accelerate() {
        //this acceleration is crazy!
    }
}
```

#### Interface Segregation

```java
public interface Payment { 
    void initiatePayments();
    Object status();
    List<Object> getPayments();
}
```

```java
public class BankPayment implements Payment {
 
    @Override
    public void initiatePayments() {
       // ...
    }
 
    @Override
    public Object status() {
        // ...
    }
 
    @Override
    public List<Object> getPayments() {
        // ...
    }
}
```

....

```java
public interface Payment {
 
    // original methods
    ...
    void intiateLoanSettlement();
    void initiateRePayment();
}
```

```java
public class LoanPayment implements Payment {
 
    @Override
    public void initiatePayments() {
        throw new UnsupportedOperationException("This is not a bank payment");
    }
 
    @Override
    public Object status() {
        // ...
    }
 
    @Override
    public List<Object> getPayments() {
        // ...
    }
 
    @Override
    public void intiateLoanSettlement() {
        // ...
    }
 
    @Override
    public void initiateRePayment() {
        // ...
    }
}
```

```java
public class BankPayment implements Payment {
 
    @Override
    public void initiatePayments() {
        // ...
    }
 
    @Override
    public Object status() {
        // ...
    }
 
    @Override
    public List<Object> getPayments() {
        // ...
    }
 
    @Override
    public void intiateLoanSettlement() {
        throw new UnsupportedOperationException("This is not a loan payment");
    }
 
    @Override
    public void initiateRePayment() {
        throw new UnsupportedOperationException("This is not a loan payment");
    }
}
```

![image](https://www.baeldung.com/wp-content/uploads/2020/07/interface_segregation_poor.png)


```java
public interface Payment {
    Object status();
    List<Object> getPayments();
}
```

```java
public interface Bank extends Payment {
    void initiatePayments();
}
```

```java
public interface Loan extends Payment {
    void intiateLoanSettlement();
    void initiateRePayment();
}
```

```java
public class BankPayment implements Bank {
 
    @Override
    public void initiatePayments() {
        // ...
    }
 
    @Override
    public Object status() {
        // ...
    }
 
    @Override
    public List<Object> getPayments() {
        // ...
    }
}
```

```java
public class LoanPayment implements Loan {
 
    @Override
    public void intiateLoanSettlement() {
        // ...
    }
 
    @Override
    public void initiateRePayment() {
        // ...
    }
 
    @Override
    public Object status() {
        // ...
    }
 
    @Override
    public List<Object> getPayments() {
        // ...
    }
}
```

![image](https://www.baeldung.com/wp-content/uploads/2020/07/interface_segregation_fixed.png)

[Source](https://www.baeldung.com/java-interface-segregation)

#### Dependency Inversion

![image](https://upload.wikimedia.org/wikipedia/commons/9/96/Dependency_inversion.png)

```java
public class Logger {
    public void logInformation(String logInfo) {
        System.out.println(logInfo);
    }
}

// "High level module" Policy equivalent.
public class Foo {
    // direct dependency of a low level module.
    private Logger logger = new Logger();

    public void doStuff() {
        logger.logInformation("Something important.");
    }
}
```

```java
public interface ILogger {
    void logInformation(String logInfo);
}

public class Logger implements ILogger {
    @Override
    public void logInformation(string logInfo) {
        System.out.println(logInfo);
    }
}

public class Foo {
    private ILogger logger;
    public void setLoggerImpl(ILogger loggerImpl) {
        this.logger = loggerImpl;
    }

    public void doStuff() {
        logger.logInformation("Something important.");
    }
}
```

```java
Foo foo = new Foo();
ILogger logger = new Logger();
foo.setLoggerImpl(logger);
foo.doStuff();
```

```java
public class LoggerToDb implements ILogger {
    @Override
    public void logInformation(string logInfo) {
        DbContext databaseContext = new DbContext();
        databaseContext.insertLog(logInfo);
    }
}
```

```java
Foo foo = new Foo();
ILogger logger = new LoggerToDb();
foo.setLoggerImpl(logger);
foo.doStuff();
```

[Source](https://stackoverflow.com/questions/29778275/dependency-inversion-principle-as-it-applies-to-java)
[Source](https://www.baeldung.com/solid-principles)

## Refactoring Strategies

![refactoring](https://images-na.ssl-images-amazon.com/images/I/51k+BvsOl2L.jpg)

### Extract Method

```java
void printOwing() {
  printBanner();

  // Print details.
  System.out.println("name: " + name);
  System.out.println("amount: " + getOutstanding());
}
```

```java
void printOwing() {
  printBanner();
  printDetails(getOutstanding());
}

void printDetails(double outstanding) {
  System.out.println("name: " + name);
  System.out.println("amount: " + outstanding);
}
```

### Extract Variable

```java
void renderBanner() {
  if ((platform.toUpperCase().indexOf("MAC") > -1) &&
       (browser.toUpperCase().indexOf("IE") > -1) &&
        wasInitialized() && resize > 0 )
  {
    // do something
  }
}
```

```java
void renderBanner() {
  final boolean isMacOs = platform.toUpperCase().indexOf("MAC") > -1;
  final boolean isIE = browser.toUpperCase().indexOf("IE") > -1;
  final boolean wasResized = resize > 0;

  if (isMacOs && isIE && wasInitialized() && wasResized) {
    // do something
  }
}
```

### Inline Method
```java
class PizzaDelivery {
  // ...
  int getRating() {
    return moreThanFiveLateDeliveries() ? 2 : 1;
  }
  boolean moreThanFiveLateDeliveries() {
    return numberOfLateDeliveries > 5;
  }
}
```

```java
class PizzaDelivery {
  // ...
  int getRating() {
    return numberOfLateDeliveries > 5 ? 2 : 1;
  }
}
```

### Remove Assignments to Parameters

```java
int discount(int inputVal, int quantity) {
  if (inputVal > 50) {
    inputVal -= 2;
  }
  // ...
}
```

```java
int discount(int inputVal, int quantity) {
  int result = inputVal;
  if (inputVal > 50) {
    result -= 2;
  }
  // ...
}
```

[Source](https://refactoring.guru/extract-method)

## Anti-Patterns / Code Smells

### Long Parameter List

```java
public void doSomething(String name, int id, String deptCode, String regNumber) {
  
    ...
}
```

```java
public class Student {
  
    private int id;
    private String name;
  
    //constructor, getters and setters
  
}

public void doSomething(Student student) {
    ...
}
```

### Error Hiding

```java
try {
  throw new Exception();
} catch {
  // do nothing
}
```

### Magic Numbers

```java
for i from 1 to 52
   j := i + randomInt(53 - i) - 1
   a.swapEntries(i, j)
```

```javascript
constant int deckSize := 52
for i from 1 to deckSize
    j := i + randomInt(deckSize + 1 - i) - 1
    a.swapEntries(i, j)
```

### Spaghetti code

```shell
i=0
i=i+1
PRINT i; "squared=";i*i
IF i>=100 THEN GOTO 6
GOTO 2
PRINT "Program Completed."
END
```

```shell
FOR i=1 TO 100
     PRINT i;"squared=";i*i
 NEXT i
 PRINT "Program Completed."
 END
```


### Primitive Obsession

```java
USER_ADMIN_ROLE = 1
```

[Source](https://www.javacodegeeks.com/2019/09/identifying-code-smells-in-java.html)
[Source](https://refactoring.guru/smells/primitive-obsession)