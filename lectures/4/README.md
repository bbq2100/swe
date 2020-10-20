[Lectures](../../README.md#school-lectures)
[Exercises](./exercise/README.md)

# Lecture 4 - Integrating Software Systems

Continuous Integration             |  Continuous Delivery
:-------------------------:|:-------------------------:
![ci](https://images-na.ssl-images-amazon.com/images/I/51lkZKjkpfL._SX376_BO1,204,203,200_.jpg) | ![cd](https://images-na.ssl-images-amazon.com/images/I/51NbiDn81NL._SX385_BO1,204,203,200_.jpg)

## Goals and Common Practices

### CI vs CD

### CD vs Continuous Deployment

## [Concourse](https://github.com/concourse/concourse)

TODO

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