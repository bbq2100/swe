[Lectures](../../README.md#school-lectures)
[Exercises](./exercise/README.md)

# Lecture 4 - Integrating Software Systems

Contents:
- Discussion
- CI/CD - Goals, Workflows, Practices
- End-To-End Example with Concourse

## Discussion
- How are software releases managed in your company?
- What techniques and practices are you already familiar with?

## Overview: What is Continuous Integration (CI) / Continuous Delivery (CD)?

The go-to books on the subject of integrating modern software systems are Continuous Integration and Continuous Delivery which also
coined the term CI/CD.

In [Extreme Programming](https://en.wikipedia.org/wiki/Extreme_programming) from Kent Beck, another classic literature, it is advocated for the first time
to integrate software updates more than once per day.

Continuous Integration             |  Continuous Delivery 
:-------------------------:|:-------------------------:
![ci](https://images-na.ssl-images-amazon.com/images/I/51lkZKjkpfL._SX376_BO1,204,203,200_.jpg) | ![cd](https://images-na.ssl-images-amazon.com/images/I/51NbiDn81NL._SX385_BO1,204,203,200_.jpg)

CI and CD are both practices to make the integration and delivery of software artefact increments easier and faster available for end users.

CI deals primarily with integrating code changes whenever there's something worth integrating into the main source code so that:
- every change is automatically unit tested
- doesn't produce too large merge conflicts with for other developers
- doesn't break the build on the main source code branch

CD takes the idea of CI a bit further: Every change which is worth to be released is accessible by end users right on. This allows end users to try out new features early and give feedback. Other pros are:
- fast feedback from the end user if updates are what they wanted
- with the automation of the deployment process you have ideally a single button to trigger new releases and deploy into production

## Continuous Integration

### Build At Every Change

![img](https://user-images.githubusercontent.com/3501767/97041382-c5dbc680-156f-11eb-8136-5e1f0f1ffcd4.png)

#### What is a Build?

- Discussion

![mvn](https://miro.medium.com/max/750/1*xsrKVt69q3JsZzLD-ldekQ.jpeg)

Check the official [Maven website](http://maven.apache.org/) out.

#### What is a Source Code Management System (SCM)?

- Discussion

![git](https://i.morioh.com/2019/11/11/1f265e2d4c43.jpg)

Check the official [Git website](https://git-scm.com/) out.

### Ideas

- Commit Code Frequently
- Don’t Commit Broken Code
- Fix Broken Builds Immediately
- Run Private Builds
- All Tests and Inspections Must Pass
- Write Automated Developer Tests

### Value of Continuous Integration

- Reduce risks
- Reduce repetitive manual processes
- Generate deployable software at any time and at any place
- Enable better project visibility
- Establish greater confidence in the software product from the development team

### Anatomy of CI Pipeline

![ci](https://docs.microsoft.com/de-de/azure/cognitive-services/luis/media/luis-concept-devops-automation/luis-automation.png)

- Compile code in CI
- Run tests in CI
- Deploy an artifact from CI

## Continuous Delivery

![cd](https://user-images.githubusercontent.com/3501767/97043393-af833a00-1572-11eb-9a72-13eb534ea8e0.png)

### Deployment Anti-Patterns

- Deploying Software Manually
- Deploying to a Production-like Environment Only after Development Is Complete
- Manual Configuration Management of Production Environments

### Principles

- Create a Repeatable, Reliable Process for Releasing Software
- Automate Almost Everything
- Keep Everything in Version Control
- If It Hurts, Do It More Frequently, and Bring the Pain Forward
- Everybody Is Responsible for the Delivery Process
- Continuous Improvement
 
### Anatomy of CD Pipeline

![workflow](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Continuous_Delivery_process_diagram.svg/731px-Continuous_Delivery_process_diagram.svg.png)

### Summary: Goals and Common Practices

- Maintain a code repository
- Automate the build
- Everyone commits to the baseline every day
- Every commit (to baseline) should be built
- Keep the build fast

## Continuous Inspection

Goals and ideas:

- Reduce Code Complexity
- Perform Design Reviews Continuously
- Maintain Organizational Standards with Code Audits
- Assess Code Coverage
- Reduce Duplicate Code

Generated from automated testing and CI (such as metrics for code coverage, code complexity, and feature completeness)

![sonar](https://miro.medium.com/max/3964/1*z-kdUUZ8_ca6h7HFND-y4Q.png)
[https://www.sonarqube.org/](https://www.sonarqube.org/)

[Live Example](https://sonarcloud.io/dashboard?id=fiunes_elasticsearch)

## [Concourse](https://github.com/concourse/concourse)

_Concourse is an automation system written in Go. It is most commonly used for CI/CD, and is built to scale to any kind of automation pipeline, from simple to complex._
[https://github.com/concourse/concourse](https://github.com/concourse/concourse)

#### Simple Concourse Pipeline

![sample](https://raw.githubusercontent.com/lsilvapvt/misc-support-files/master/docs/images/simple-gated-pipeline.gif)

https://github.com/vmwarepivotallabs/concourse-pipeline-samples/tree/master/concourse-pipeline-patterns/gated-pipelines/01-simple

This sample pipeline TODO

```yml
resources:
- name: my-resource
  type: git
  source:
    branch: master
    uri: https://github.com/pivotalservices/concourse-pipeline-samples.git

jobs:
- name: Run-automatically
  plan:
  - get: my-resource
    trigger: true
  - task: do-your-task-here
    config:
      platform: linux
      image_resource:
        type: docker-image
        source:
          repository: ubuntu
      run:
        path: sh
        args:
        - -exc
        - |
          echo "This job is automatically triggered upon any version change in the resource."
- name: Manually-trigger-me
  plan:
  - get: my-resource
    passed:
      - Run-automatically
    trigger: false
  - task: do-your-manual-task-here
    config:
      platform: linux
      image_resource:
        type: docker-image
        source:
          repository: ubuntu
      run:
        path: sh
        args:
        - -exc
        - |
          echo "Output of your manually triggered task."
- name: Do-more-stuff-after-manual-trigger
  plan:
  - get: my-resource
    passed:
      - Manually-trigger-me
    trigger: true
  - task: do-other-tasks-here
    config:
      platform: linux
      image_resource:
        type: docker-image
        source:
          repository: ubuntu
      run:
        path: sh
        args:
        - -exc
        - |
          echo "Output of your other tasks."
```

## End-To-End Example

[https://github.com/qaismyname/ci-example](https://github.com/qaismyname/ci-example)
