[Lectures](../../README.md#school-lectures)
[Exercises](./exercise/README.md)

# Lecture 2 - Software Architecture

Contents:
- Architecture patterns such as Model View Control (MVC), Client-Server Architecture, Boss-Worker
- RESTful Architecture
- Microservice
- Serverless

[https://martinfowler.com/architecture/](https://martinfowler.com/architecture/)

![img](https://user-images.githubusercontent.com/3501767/99104172-efbd6180-25e0-11eb-9556-507c9a2c8934.png)

## Architecture patterns

### MVC

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

### Client-Server

![img](https://upload.wikimedia.org/wikipedia/commons/c/c9/Client-server-model.svg)

#### Chat Server

![img](https://user-images.githubusercontent.com/3501767/99105569-0a90d580-25e3-11eb-94b4-0cecc6db396c.png)

[https://github.com/AYIDouble/Multithreading-Chat-Client-Java](https://github.com/AYIDouble/Multithreading-Chat-Client-Java)

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