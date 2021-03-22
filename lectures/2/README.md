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

### Another Example

![img](https://examples.javacodegeeks.com/wp-content/uploads/2016/01/swing_mvc_components.jpg.webp)

### Model

```java
public class Model extends DefaultTableModel {
 
    public Model() {
        super(Constants.DATA, Constants.TABLE_HEADER);
    }
 
}

....

public class Constants {
 
    public static final Object[] TABLE_HEADER = { "Symbol", "Company Name",
            "Price", "Change", "% Change", "Volume" };
 
    public static final Object[][] DATA = {
            { "BAC", "Bank of America Corporation", 15.98, 0.14, "+0.88%",
                    32157250 },
            { "AAPL", "Apple Inc.", 126.57, -1.97, "-1.54%", 31367143 },
            { "ABBV", "AbbVie Inc.", 57.84, -2.43, "-4.03%", 30620258 },
            { "ECA", "Encana Corporation", 11.74, -0.53, "-4.33%", 27317436 },
            { "VALE", "Vale S.A.", 6.55, -0.33, "-4.80%", 19764400 },
            { "FB", "Facebook, Inc.", 81.53, 0.64, "+0.78%", 16909729 },
            { "PBR", "Petróleo Brasileiro S.A. - Petrobras", 6.05, -0.12,
                    "-2.02%", 16181759 },
            { "NOK", "Nokia Corporation", 8.06, 0.01, "+0.12%", 13611860 },
            { "PCYC", "Pharmacyclics Inc.", 254.67, 24.19, "+10.50%", 13737834 },
            { "RAD", "Rite Aid Corporation", 7.87, -0.18, "-2.24%", 13606253 } };
     
}
```

### View

```java
public class View {
 
    public View() {
        // Create views swing UI components 
        JTextField searchTermTextField = new JTextField(26);
        JButton filterButton = new JButton("Filter");
        JTable table = new JTable();
 
        // Create table model
        Model model = new Model();
        table.setModel(model);
 
        // Create controller
        Controller controller = new Controller(searchTermTextField, model);
        filterButton.addActionListener(controller);
 
        // Set the view layout
        JPanel ctrlPane = new JPanel();
        ctrlPane.add(searchTermTextField);
        ctrlPane.add(filterButton);
 
        JScrollPane tableScrollPane = new JScrollPane(table);
        tableScrollPane.setPreferredSize(new Dimension(700, 182));
        tableScrollPane.setBorder(BorderFactory.createTitledBorder(BorderFactory.createEtchedBorder(), "Market Movers",
                TitledBorder.CENTER, TitledBorder.TOP));
 
        JSplitPane splitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, ctrlPane, tableScrollPane);
        splitPane.setDividerLocation(35);
        splitPane.setEnabled(false);
 
        // Display it all in a scrolling window and make the window appear
        JFrame frame = new JFrame("Swing MVC Demo");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.add(splitPane);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
 
}
```

### Controller

```java
public class Controller implements ActionListener {
     
    private JTextField searchTermTextField = new JTextField(26);
    private DefaultTableModel model;
 
    public Controller(JTextField searchTermTextField, DefaultTableModel model) {
        super();
        this.searchTermTextField = searchTermTextField;
        this.model = model;
    }
 
    @Override
    public void actionPerformed(ActionEvent e) {
 
        String searchTerm = searchTermTextField.getText();
        if (searchTerm != null && !"".equals(searchTerm)) {
            Object[][] newData = new Object[Constants.DATA.length][];
            int idx = 0;
            for (Object[] o: Constants.DATA) {
                if ("*".equals(searchTerm.trim())) {
                    newData[idx++] = o;
                } else {
                    if(String.valueOf(o[0]).startsWith(searchTerm.toUpperCase().trim())){
                        newData[idx++] = o;
                    }   
                }   
            }
            model.setDataVector(newData, Constants.TABLE_HEADER);
        } else {
            JOptionPane.showMessageDialog(null,
                    "Search term is empty", "Error",
                    JOptionPane.ERROR_MESSAGE);
        }
    }
 
}
```

![img](https://examples.javacodegeeks.com/wp-content/uploads/2016/01/swing_mvc_demo.jpg.webp)

Usage
- Architecture for World Wide Web applications in major programming languages.
- Web frameworks such as Django and Rails.


### Client-Server

![img](https://upload.wikimedia.org/wikipedia/commons/c/c9/Client-server-model.svg)

### Characteristics of a Client-Server Architecture

- Client and server machines need different amount of hardware and software resources.
- Client and server machines may belong to different vendors.
- Horizzontal scalability (increase of the client machines) and vertical scalability (migration to a more powerful server or to a multiserver solution)
- A client or server application interacts directly with a transport layer protocol to establish communication and to send or receive information.
- The transport protocol then uses lower layer protocols to send or receive individual messages. Thus, a computer needs a complete stack of protocols to run either a client or a server.
- A single server-class computer can offer multiple services at the same time; a separate server program is needed for each service.

#### Chat Server

![img](https://user-images.githubusercontent.com/3501767/99105569-0a90d580-25e3-11eb-94b4-0cecc6db396c.png)

[https://github.com/AYIDouble/Multithreading-Chat-Client-Java](https://github.com/AYIDouble/Multithreading-Chat-Client-Java)


### Web Browser

```
<!DOCTYPE html>
<html>
	<head>
		<title>My First Webpage</title>
	</head>
	<body>
		<h1>Happy Coding</h1>
		<p>Hello world!</p>
	</body>
</html>
```

![img](https://happycoding.io/tutorials/html/images/html-1.png)


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

### Usage
- Online applications such as email, document sharing and banking.


### Boss-Worker

This pattern consists of two parties; boss and workers. The boss component distributes the work among identical workers components, and computes a final result from the results which the workers return.

#### Usage
- In database replication, the master database is regarded as the authoritative source, and the slave databases are synchronized to it.
- Peripherals connected to a bus in a computer system (master and slave drives).

![img](https://miro.medium.com/max/524/1*t3afE6XumWMXhUGtgzVZQA.png)

#### MySQL Replication

![img](https://www.percona.com/blog/wp-content/uploads/2017/01/replicationarchitecturexample.png)

#### Another Example

![img](https://cdn-images-1.medium.com/max/800/1*1m6mZynfl0qy38VOZicMTA.jpeg)

### Pipe And filter

This pattern can be used to structure systems which produce and process a stream of data. Each processing step is enclosed within a filter component. Data to be processed is passed through pipes. These pipes can be used for buffering or for synchronization purposes.
Usage
- Compilers. The consecutive filters perform lexical analysis, parsing, semantic analysis, and code generation.
- etl pipelines
- data processing

![img](https://static.packt-cdn.com/products/9781788992992/graphics/6dcf7298-18ab-4d18-a493-7eea17cc165f.png)

#### Shell

```bash
cat sample | grep -v a | sort - r
```

#### Another Example

![img](https://homepages.fhv.at/thjo/lecturenotes/sysarch/figures/pap/pipes_and_filters_example.png)

#### ETL Pipeline

![img](https://panoply.io/uploads/versions/diagram4---x----750-328x---.jpg)

### Broker pattern

This pattern is used to structure distributed systems with decoupled components. These components can interact with each other by remote service invocations. A broker component is responsible for the coordination of communication among components.
Servers publish their capabilities (services and characteristics) to a broker. Clients request a service from the broker, and the broker then redirects the client to a suitable service from its registry.
Usage
- Message broker software such as Apache ActiveMQ, Apache Kafka, RabbitMQ and JBoss Messaging.

![img](https://apptraitsolutions.com/wp-content/uploads/2019/07/Broker-Pattern-Diagrm.jpg)


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

![img](https://miro.medium.com/max/1400/0*RRPP-ZT1U2nZFqDa)

### Principles
- Application state and functionality are divided into resources and than the application would respond based on the resource that the operation is being performed
Resources are addressable using standard URIs that can be used as hypermedia links such as http://example.com/resources/ and than for each resource the type of the resource is added in the URI such as http://example.com/resources/resource.
- Resources provide information using MIME( Multipurpose Internet Mail Extensions)types supported by HTTP (e.g JSON, XML, Atom, etc.)
- Use only standard HTTP methods, they are GET, PUT, POST and DELETE.
- Protocol is stateless, cacheable and layered

![img](https://miro.medium.com/max/842/0*XCPO8UXIQ_nL5Ha0)

![img](https://miro.medium.com/max/1400/0*hf6eSRZm5GM7W_hB)


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

### Stripe

[https://stripe.com/docs/api/balance_transactions/object](https://stripe.com/docs/api/balance_transactions/object)

![img](https://i.ibb.co/rHpHrcF/Screenshot-2021-03-22-at-11-31-16.png)

### Twitter

[twitter](https://developer.twitter.com/en/docs/twitter-api/tweets/search/quick-start/recent-search)

![img](https://i.ibb.co/D9zcR8c/Screenshot-2021-03-22-at-11-34-29.png)

## Microservice Architecture

Microservices - also known as the microservice architecture - is an architectural style that structures an application as a collection of services that are

- Highly maintainable and testable
- Loosely coupled
- Independently deployable
- Organized around business capabilities
- Owned by a small team
- The microservice architecture enables the rapid, frequent and reliable delivery of large, complex applications. It also enables an organization to evolve its technology stack.

![img](https://martinfowler.com/articles/microservices/images/sketch.png)

[https://martinfowler.com/articles/microservices.html](https://martinfowler.com/articles/microservices.html)

### Netflix

![img](https://zdnet1.cbsistatic.com/hub/i/r/2018/07/30/3cd011df-430d-4cda-aab8-e6ae707eac1b/resize/770xauto/18ff327ee8ecfb2e024ad709d1142030/netflix-microservices-diagram-bruce-wong.jpg)


### e-commerce shop

![img](https://microservices.io/i/Microservice_Architecture.png)

### Video Platform

![img](https://www.edureka.co/blog/wp-content/uploads/2018/03/Microservice-Architecture-Of-Use-Case-Microservices-Tutorial-Edureka.png)

### Disadvantages

- Developers must deal with the additional complexity of creating a distributed system:
- Developers must implement the inter-service communication mechanism and deal with partial failure
- Implementing requests that span multiple services is more difficult
- Testing the interactions between services is more difficult
- Implementing requests that span multiple services requires careful coordination between the teams
- Developer tools/IDEs are oriented on building monolithic applications and don’t provide explicit support for developing distributed applications.
- Deployment complexity. In production, there is also the operational complexity of deploying and managing a system comprised of many different services.
- Increased memory consumption. The microservice architecture replaces N monolithic application instances with NxM services instances. If each service runs in its own JVM (or equivalent), which is usually necessary to isolate the instances, then there is the overhead of M times as many JVM runtimes. Moreover, if each service runs on its own VM (e.g. EC2 instance), as is the case at Netflix, the overhead is even higher.

### Microservice vs Monolith

![img](https://martinfowler.com/articles/microservices/images/decentralised-data.png)

### Patterns

![img](https://microservices.io/i/PatternsRelatedToMicroservices.jpg)

## Serverless

Serverless computing is a cloud computing execution model in which the cloud provider allocates machine resources on demand, taking care of the servers on behalf of their customers. Serverless computing does not hold resources in volatile memory; computing is rather done in short bursts with the results persisted to storage. When an app is not in use, there are no computing resources allocated to the app. Pricing is based on the actual amount of resources consumed by an application.[1] It can be a form of utility computing. "Serverless" is a misnomer in the sense that servers are still used by cloud service providers to execute code for developers. However developers of serverless applications are not concerned with capacity planning, configuration, management, maintenance, operating or scaling of containers, VMs, or physical servers.

Serverless computing can simplify the process of deploying code into production. Serverless code can be used in conjunction with code deployed in traditional styles, such as microservices or monoliths. Alternatively, applications can be written to be purely serverless and use no provisioned servers at all.[2] This should not be confused with computing or networking models that do not require an actual server to function, such as peer-to-peer (P2P).

### Advantages:
- No server management is necessary
- Developers are only charged for the server space they use, reducing cost
- Serverless architectures are inherently scalable
- Quick deployments and updates are possible
- Code can run closer to the end user, decreasing latency

### Disadvantages

- Testing and debugging become more challenging
- Serverless computing introduces new security concerns
- Serverless architectures are not built for long-running processes
- Performance may be affected
- Vendor lock-in is a risk

![img](https://miro.medium.com/max/1160/1*FZez47Cx47OO4eVS7XA_Sg.png)

### Hello World

[https://cloud.google.com/functions/docs/tutorials/http](https://cloud.google.com/functions/docs/tutorials/http)

```
exports.helloGET = (req, res) => {
  res.send('Hello World!');
};
```

```
gcloud functions deploy helloGET \
--runtime nodejs10 --trigger-http --allow-unauthenticated
```

```
curl "https://REGION-PROJECT_ID.cloudfunctions.net/helloGET" 
```

### Optical Character Recognition

[https://cloud.google.com/functions/docs/tutorials/ocr](https://cloud.google.com/functions/docs/tutorials/ocr)

![img](https://cloud.google.com/functions/img/gcf-ocr.svg)

Dependencies

```
// Get a reference to the Pub/Sub component
const {PubSub} = require('@google-cloud/pubsub');
const pubsub = new PubSub();
// Get a reference to the Cloud Storage component
const {Storage} = require('@google-cloud/storage');
const storage = new Storage();

// Get a reference to the Cloud Vision API component
const Vision = require('@google-cloud/vision');
const vision = new Vision.ImageAnnotatorClient();

// Get a reference to the Translate API component
const {Translate} = require('@google-cloud/translate').v2;
const translate = new Translate();
```

Processing the image

```
exports.processImage = async event => {
  const {bucket, name} = event;

  if (!bucket) {
    throw new Error(
      'Bucket not provided. Make sure you have a "bucket" property in your request'
    );
  }
  if (!name) {
    throw new Error(
      'Filename not provided. Make sure you have a "name" property in your request'
    );
  }

  await detectText(bucket, name);
  console.log(`File ${name} processed.`);
};
```

Detecting Text in image

```
  console.log(`Looking for text in image ${filename}`);
  const [textDetections] = await vision.textDetection(
    `gs://${bucketName}/${filename}`
  );
  const [annotation] = textDetections.textAnnotations;
  const text = annotation ? annotation.description : '';
  console.log('Extracted text from image:', text);

  let [translateDetection] = await translate.detect(text);
  if (Array.isArray(translateDetection)) {
    [translateDetection] = translateDetection;
  }
  console.log(
    `Detected language "${translateDetection.language}" for ${filename}`
  );

  // Submit a message to the bus for each language we're going to translate to
  const TO_LANGS = process.env.TO_LANG.split(',');
  const topicName = process.env.TRANSLATE_TOPIC;

  const tasks = TO_LANGS.map(lang => {
    const messageData = {
      text: text,
      filename: filename,
      lang: lang,
    };

    // Helper function that publishes translation result to a Pub/Sub topic
    // For more information on publishing Pub/Sub messages, see this page:
    //   https://cloud.google.com/pubsub/docs/publisher
    return publishResult(topicName, messageData);
  });

  return Promise.all(tasks);
};
```

Translating text

```
exports.translateText = async event => {
  const pubsubData = event.data;
  const jsonStr = Buffer.from(pubsubData, 'base64').toString();
  const {text, filename, lang} = JSON.parse(jsonStr);

  if (!text) {
    throw new Error(
      'Text not provided. Make sure you have a "text" property in your request'
    );
  }
  if (!filename) {
    throw new Error(
      'Filename not provided. Make sure you have a "filename" property in your request'
    );
  }
  if (!lang) {
    throw new Error(
      'Language not provided. Make sure you have a "lang" property in your request'
    );
  }

  console.log(`Translating text into ${lang}`);
  const [translation] = await translate.translate(text, lang);

  console.log('Translated text:', translation);

  const messageData = {
    text: translation,
    filename: filename,
    lang: lang,
  };

  await publishResult(process.env.RESULT_TOPIC, messageData);
  console.log(`Text translated to ${lang}`);
};
```

### Slack Command

[img](https://cloud.google.com/functions/docs/tutorials/slack)

![img](https://cloud.google.com/functions/img/gcf-slack.svg)

```
const google = require('googleapis/build/src/apis/kgsearch');
const {verifyRequestSignature} = require('@slack/events-api');

// Get a reference to the Knowledge Graph Search component
const kgsearch = google.kgsearch('v1');
```

```
exports.kgSearch = async (req, res) => {
  try {
    if (req.method !== 'POST') {
      const error = new Error('Only POST requests are accepted');
      error.code = 405;
      throw error;
    }

    // Verify that this request came from Slack
    verifyWebhook(req);

    // Make the request to the Knowledge Graph Search API
    const response = await makeSearchRequest(req.body.text);

    // Send the formatted message back to Slack
    res.json(response);

    return Promise.resolve();
  } catch (err) {
    console.error(err);
    res.status(err.code || 500).send(err);
    return Promise.reject(err);
  }
};
```

```
  return new Promise((resolve, reject) => {
    kgsearch.entities.search(
      {
        auth: process.env.KG_API_KEY,
        query: query,
        limit: 1,
      },
      (err, response) => {
        console.log(err);
        if (err) {
          reject(err);
          return;
        }

        // Return a formatted message
        resolve(formatSlackMessage(query, response));
      }
    );
  });
};
```
