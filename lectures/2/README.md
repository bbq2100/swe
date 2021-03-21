[Lectures](../../README.md#school-lectures)
[Exercises](./exercise/README.md)

# Lecture 2 - Software Architecture

Contents:
- Architecture patterns such as Model View Control (MVC), Client-Server Architecture, Boss-Worker
- RESTful Architecture
- Microservice
- Serverless

### [Great resource to learn about software architecture](https://martinfowler.com/architecture/)

![img](https://user-images.githubusercontent.com/3501767/99104172-efbd6180-25e0-11eb-9556-507c9a2c8934.png)

## Architecture patterns

### MVC

MVC (Model-View-Controller) is an architectural design pattern that encourages improved application organization through a separation of concerns. It divides an interactive application into three components: Model / View and Controller. It enforces the isolation of business data (Models) from user interfaces (Views), with a third component (Controllers) traditionally managing logic, user-input and coordinating both the models and views. The goal of MVC is to help structure the separate the concerns of an application into three parts:

Model is responsible for managing the data of the application. It receives user input from the controller.

View means the presentation of the model in a particular format.

Controller responds to the user input and performs interactions on the data model objects. The controller receives the input, optionally validates it and then passes the input to the model.

![img](https://www.tektutorialshub.com/wp-content/uploads/2017/10/Model-View-Controller-in-ASP.NET-Core.png)

#### [AngularJS](https://angularjs.org/)

![img](https://howtodoinjava.com/wp-content/uploads/2016/01/Angular-Hello-World.png)

```html
<!doctype html>
<html ng-app="helloWorldApp">
<head>
    <title>Hello World - AngularJS</title>
</head>
<body>
    <div ng-controller="MyController">
        <span>First Value:</span> <input type="text" ng-model="first"> <br />
        <span>Second Value:</span> <input type="text" ng-model="second"> <br /><br />
        <button ng-click='updateSum()'>Sum</button> <br /><br />
        {{heading}}  {{total}}
    </div>
    <script src="angular.min.js"></script>
    <script src="app.js"></script>
</body>
</html>
```

```javascript
var firstApp = angular.module('helloWorldApp', []);
firstApp.controller('MyController', function($scope) {
    $scope.first = 5;
    $scope.second = 10;
    $scope.heading = 'Sum is : ';
    $scope.total = 15;
    $scope.updateSum = function() {
        $scope.total = parseInt($scope.first) + parseInt($scope.second);
    };
});
```

### Advantages

- Simultaneous development — Multiple developers can work simultaneously on the model, controller and views.
- High cohesion — MVC enables logical grouping of related actions on a controller together. The views for a specific model are also grouped together.
- Low coupling — The very nature of the MVC framework is such that there is low coupling among models, views or controllers
- Ease of modification — Because of the separation of responsibilities, future development or modification is easier
- Multiple views for a model — Models can have multiple views

### Cons of MVC Pattern:

- The complexity is high to develop the applications using this pattern.
- Not right suitable for small applications which has adverse effect in the application’s performance and design.
- In terms of servlet and JSP, both often contains business logic and presentation tier.
- The isolated development process by UI authors, business logic authors and controller authors may lead to delay in their respective modules development.


### Client-Server

![img](https://upload.wikimedia.org/wikipedia/commons/c/c9/Client-server-model.svg)

#### Chat Server

![img](https://user-images.githubusercontent.com/3501767/99105569-0a90d580-25e3-11eb-94b4-0cecc6db396c.png)

[https://github.com/AYIDouble/Multithreading-Chat-Client-Java](https://github.com/AYIDouble/Multithreading-Chat-Client-Java)

### Characteristics of a Client-Server Architecture

- Client and server machines need different amount of hardware and software resources.
- Client and server machines may belong to different vendors.
- Horizzontal scalability (increase of the client machines) and vertical scalability (migration to a more powerful server or to a multiserver solution)
- A client or server application interacts directly with a transport layer protocol to establish communication and to send or receive information.
- The transport protocol then uses lower layer protocols to send or receive individual messages. Thus, a computer needs a complete stack of protocols to run either a client or a server.
- A single server-class computer can offer multiple services at the same time; a separate server program is needed for each service.


### Advantages Of Client Server Architecture
- The data is centralized within the system that is maintained in a single place. 
- The model is efficient in delivering resources to the client and also requires low-cost maintenance. 
- It is easy to manage, and the data can be easily delivered to the client. 
- As the data is centralized, this system is more secure and serves added security to the data. 
- Within this type of model, more clients and servers can be embedded into the server, which makes the performance outstanding and increases the model’s overall flexibility. 

### Disadvantages Of Client Server Architecture
- Clients’ systems can get a virus or any malicious scripts if any are running on the server. 
- Extra security must be added so that the data does not get spoofed in between the transmission. 
- The main problem can be server down. When the server is down, the client loses its connection and will not access the data. 

### Boss-Worker

![img](https://miro.medium.com/max/524/1*t3afE6XumWMXhUGtgzVZQA.png)

#### MySQL Replication

![img](https://www.percona.com/blog/wp-content/uploads/2017/01/replicationarchitecturexample.png)

### Pipe-filter

![img](https://static.packt-cdn.com/products/9781788992992/graphics/6dcf7298-18ab-4d18-a493-7eea17cc165f.png)

#### Shell

```bash
cat sample | grep -v a | sort - r
```

#### ETL Pipeline

![img](https://panoply.io/uploads/versions/diagram4---x----750-328x---.jpg)

### Broker pattern

![img](https://lh3.googleusercontent.com/proxy/ntruUNB9Rf332qdqfhRVgqOYEBIxdFInPBnZHVF3AGE2dZlKKQbCfjHFzPK2gzZxPUmXjkWDlrBfi_bqtCLdbmszF70uhCnAXE4Q5AaAT4-5IUDjSrwo)

#### Apache Kafka

![img](https://raw.githubusercontent.com/DXHeroes/knowledge-base-content/master/files/kafka_architecture.png)

```java
public class Producer {

    public static void main(String[] args){
        Properties properties = new Properties();
        properties.put("bootstrap.servers", "localhost:9092");
        properties.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        properties.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");

        KafkaProducer kafkaProducer = new KafkaProducer(properties);
        try{
            for(int i = 0; i < 100; i++){
                System.out.println(i);
                kafkaProducer.send(new ProducerRecord("devglan-test", Integer.toString(i), "test message - " + i ));
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            kafkaProducer.close();
        }
    }
}
```

```java
public class Consumer {

    public static void main(String[] args) {
        Properties properties = new Properties();
        properties.put("bootstrap.servers", "localhost:9092");
        properties.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        properties.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        properties.put("group.id", "test-group");

        KafkaConsumer kafkaConsumer = new KafkaConsumer(properties);
        List topics = new ArrayList();
        topics.add("devglan-test");
        kafkaConsumer.subscribe(topics);
        try{
            while (true){
                ConsumerRecords records = kafkaConsumer.poll(10);
                for (ConsumerRecord record: records){
                    System.out.println(String.format("Topic - %s, Partition - %d, Value: %s", record.topic(), record.partition(), record.value()));
                }
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }finally {
            kafkaConsumer.close();
        }
    }
}
```

```
Topic - devglan-test, Partition - 0, Value: test message - 0
Topic - devglan-test, Partition - 0, Value: test message - 1
Topic - devglan-test, Partition - 0, Value: test message - 2
```

[https://www.devglan.com/apache-kafka/apache-kafka-java-example](https://www.devglan.com/apache-kafka/apache-kafka-java-example)

## RESTful APIs

![img](https://www.seobility.net/en/wiki/images/f/f1/Rest-API.png)

#### Github REST API

[https://developer.github.com/v3/search/](https://developer.github.com/v3/search/)

Example REST API Call: search for popular Tetris repositories written in Assembly

```bash
curl https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc
```

```json
Status: 200 OK
Link: <https://api.github.com/resource?page=2>; rel="next",
      <https://api.github.com/resource?page=5>; rel="last"
X-RateLimit-Limit: 20
X-RateLimit-Remaining: 19
{
  "total_count": 40,
  "incomplete_results": false,
  "items": [
    {
      "id": 3081286,
      "node_id": "MDEwOlJlcG9zaXRvcnkzMDgxMjg2",
      "name": "Tetris",
      "full_name": "dtrupenn/Tetris",
      "owner": {
        "login": "dtrupenn",
        "id": 872147,
        "node_id": "MDQ6VXNlcjg3MjE0Nw==",
        "avatar_url": "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
        "gravatar_id": "",
        "url": "https://api.github.com/users/dtrupenn",
        "received_events_url": "https://api.github.com/users/dtrupenn/received_events",
        "type": "User"
      },
      "private": false,
      "html_url": "https://github.com/dtrupenn/Tetris",
      "description": "A C implementation of Tetris using Pennsim through LC4",
      "fork": false,
      "url": "https://api.github.com/repos/dtrupenn/Tetris",
      "created_at": "2012-01-01T00:31:50Z",
      "updated_at": "2013-01-05T17:58:47Z",
      "pushed_at": "2012-01-01T00:37:02Z",
      "homepage": "",
      "size": 524,
      "stargazers_count": 1,
      "watchers_count": 1,
      "language": "Assembly",
      "forks_count": 0,
      "open_issues_count": 0,
      "master_branch": "master",
      "default_branch": "master",
      "score": 1.0
    }
  ]
}
```

## Microservice Architecture

![img](https://martinfowler.com/articles/microservices/images/sketch.png)

[https://martinfowler.com/articles/microservices.html](https://martinfowler.com/articles/microservices.html)

### Netflix

![img](https://zdnet1.cbsistatic.com/hub/i/r/2018/07/30/3cd011df-430d-4cda-aab8-e6ae707eac1b/resize/770xauto/18ff327ee8ecfb2e024ad709d1142030/netflix-microservices-diagram-bruce-wong.jpg)

![img](https://www.honeycomb.io/wp-content/uploads/2018/10/netflix-microservices-traffic-flow-768x466.png)

## Serverless

![img](https://miro.medium.com/max/1160/1*FZez47Cx47OO4eVS7XA_Sg.png)

### AWS Lambda

![img](https://d1.awsstatic.com/aws-answers/answers-images/serverless-image-handler-architecture.043b4d76d253e5fe669791a85558b9908748e27b.png)
