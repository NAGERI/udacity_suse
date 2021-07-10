# Welcome to the Cloud Native CI/CD lesson!

Once a team has built a product and has structured a release process onto the platform, the next phase is to bring automation. `A release process should enable a team to deliver new features to consumers, and it should be highly automated to eliminate misconfiguration scenarios`. These functionalities are encapsulated by a CI/CD pipeline, for continuous integration and delivery of the new code changes.

In this lesson, we will explore how to use cloud-native tooling to construct a CI/CD pipeline. As well, we will explore template configuration managers, such as Helm to enable the easy deployment of an application to multiple clusters.

Overall, in this lesson we will explore:

- Continuous Application Deployment
- The CI Fundamentals
- The CD Fundamentals
- Configuration Managers

## Big Picture: Application Releases
Up to this stage, we have practiced the packaging of an application using Docker and its deployment to a Kubernetes cluster using kubectl commands. As well, we have explored the simplified developer experience of application release with Cloud Foundry. However, in both cases, a user has to manually trigger and complete all the operations. This is not sustainable if tens and hundreds of releases are performed within a day. Automation of the release process is fundamental!

In the case of a PaaS offering, the release of a new feature is managed by the provider. For example, Cloud Foundry monitors the repository with the source code, and when a new commit is identified, the user can easily deploy the latest changes with a click of a button. On the other side, releasing an application to a Kubernetes cluster consists of a series of manually typed `docker` and `kubectl` commands. At this stage, this approach has no automation integrated.

In this lesson, we will not cover how a PaaS automates the release process, since this is already solutionized by the 3rd party providers. Instead, we will focus on building a delivery pipeline to automate the deployment to Kubernetes using cloud-native tooling.

## Continuous Application Deployment
Every company has the same goal: `to deliver value to customers` and maintain `customer satisfaction`. To achieve this, an organization needs to `be fast in integrating` customer feedback and release new features.

It is possible to manually deploy every release for a small product. However, this is not viable for a product that has thousands of microservices developed by hundreds of engineers. A delivery pipeline is essential for continuous and automated deployment of new functionalities.

A delivery pipeline includes stages that can test, validate, package, and push new features to a production environment. It is common practice for the main branch commits to proceed through all stages of the pipeline to reach the end-users. Overall, a delivery pipeline is triggered when a new commit is available. The new changes should traverse the following stages:

- Build - compile the application source code and its dependencies. If this stage fails the developer should address it immediately as there might be missing dependencies or errors in the code.
- Test - run a suite of tests, such as unit testing, integration, UI, smoke, or security tests. These tests aim to validate the behavior of the code. If this stage fails, then developers must correct it to prevent dysfunctional code from reaching the end-users.
- Package - create an executable that contains the latest code and its dependencies. This is a runnable instance of the application that can be deployed to end-users.
- Deploy - push the packaged application to one or more environments, such as sandbox, staging, and production. Usually, the sandbox and staging deployments are automatic, and the production deployment requires engineering validation and triggering.

It is common practice to push an application through multiple environments before it reaches the end-users. Usually, these are categorized as follows:`deploy stage`(CD)

- Sandbox - development environment, where new changes can be tested with minimal risk.
- Staging - an environment identical to production, and where a release can be simulated without affecting the end-user experience.
- Production - customer-facing environment and any changes in this environment will affect the customer experience.
Overall, a delivery pipeline consists of two phases:

> **Continuous Integration (or CI)** includes the build, test, and package stages.
> **Continuous Delivery (or CD)** handles the deploy stage.

> Advantages of a CI/CD pipeline
- Frequent releases - automation enables engineers to ship new code as soon as it's available and improves responsiveness to customer feedback.
- Less risk - automation of releases eliminates the need for manual intervention and configuration.
Developer productivity - a structured release process allows every product to be released independently of other components

> New terms
- Continuous Integration - a mechanism that produces the package of an application that can be deployed.
- Continuous Delivery - a mechanism to push the packaged application through multiple environments, including production.
- Continuous Deployment - a procedure that contains the Continuous Integration and Continuous Delivery of a product.

# The CI Fundamentals
Continuous Integration (CI) is a mechanism that produces the package of an application that can be deployed to consumers. As such, every commit to the main branch is built, tested, and packaged, if it meets the expected behavior. Within the cloud-native, the result of Continuous Integration represents a Docker image or an artifact that is OCI compliant.

Let's explore the commands and tools associated with each Continuous Integration stage!
### Build
The build stage compiles the application source code and associated dependencies. We have explored this stage as part of the Dockerfile. For example, the Dockerfile for the Python hello-world application instructed the installation of dependencies from requirements.txt file and execution of the app.py at the container start.
```
# use pip to install any application dependencies 
RUN pip install -r requirements.txt

# execute command  on the container start
CMD [ "python", "app.py" ]
```
### Test
The technology landscape provides an abundance of frameworks, libraries, and tools to test and validate the behavior of an application. For Python application, some of the well-known frameworks are:

- pytest - for functional testing of the application
- pylint - for static code analysts of the application codebase.

### Package
The result of the package stage is an executable that contains the latest features and their dependencies. With Docker, this stage is implemented using docker build and docker push commands. These create a Docker image using a Dockerfile, and stores the image to a registry, such as `DockerHub`. For example, to create and store the image for Python hello-world application, the following commands are used:
```
# build an image using a Dockerfile
docker build -t python-helloworld .

# store and distribute an image using DockerHub
docker push pixelpotato/python-helloworld:v1.0.0
```
## Github Actions
There are plenty of tools that automate the Continuous Integration stages, such as Jenkins, CircleCI, Concourse, Travis and Spinnaker. However, in this lesson, we will explore GitHub Actions to build, test, and package an application.

GitHub Actions are event-driven workflows that can be executed when a new commit is available, on external or scheduled events. These can be easily integrated within any repository and provide immediate feedback if a new commit passes the quality check. Additionally, GitHub Actions are supported for multiple programming languages and can offer tailored notifications (e.g. in Slack) and status badges for a project.

A GitHub Action consists of one or more jobs. A job contains a sequence of steps that execute standalone commands, known as actions. When an event occurs, the GitHub Action is triggered and executes the sequence of commands to perform an operation, such as code build or test.
Let's configure a GitHub Action that prints the Python version!

GitHub Actions are configured using YAML syntax, hence uses the .yaml or .yml file extensions. These files are stored in .github/workflows directory within the code repository. Within this folder, the python-version.yml contains the following sections:
```
## file location and name: # .github/workflows/python-version.yml

##  Named of the workflow.
name: Python version
## Set the trigger policy.
## In this case, the workflow is execute on a `push` event,
## or when a new commit is pushed to the repository
on: [push]
## List the steps to be executed by the workflow
jobs:
  ## Set the name of the job
  check-python-version:
    ## Configure the operating system the workflow should run on.
    ## In this case, the job on Ubuntu
    runs-on: ubuntu-latest
    ## Define a sequence of steps to be executed 
    steps:
      ## Use the public `checkout` action in version v2  
      ## to checkout the existing code in the repository
      - uses: actions/checkout@v2
      ## Use the public `setup-python` action  in version v2  
      ## to install python on the  Ubuntu based environment 
      - uses: actions/setup-python@v2
      ## Executes the `python --version` command
      - run: python --version
```
On the successful execution of the workflow, the Python version is printed.

```
# This is a basic workflow to help you get started with Actions

name: CI

# Controls when the workflow will run
on:
  # Triggers the workflow on push or pull request events but only for the main branch
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - uses: actions/checkout@v2

      # Runs a single command using the runners shell
      - name: Run a one-line script
        run: echo Hello, world!

      # Runs a set of commands using the runners shell
      - name: Run a multi-line script
        run: 
          echo Add other actions to build,
          echo test, and deploy your project.
```

## CI fundamentals links
- [DockerHub tokens](https://www.docker.com/blog/docker-hub-new-personal-access-tokens/)
- [Github Encrypted secrets](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets)
- [Build and Push Docker images](https://github.com/marketplace/actions/build-and-push-docker-images)