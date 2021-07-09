# Welcome to Open Source PaaS lesson!

Throughout the release process, the development team has to collaborate closely with the infrastructure team. This is necessary to ensure that the application requirements can be fulfilled by the platform capabilities. However, this is a use case where an organization has enough resources to hire a development and infrastructure team. Small organizations, consists of small teams that focus fully on application development. In these circumstances, it is only a natural movement to delegate the management of platform components to a 3rd party.

In this lesson, we will explore the Platform as a Service (PaaS) mechanism as a way to deploy a service without underlying infrastructure knowledge.
Throughout this lesson we will explore:

- PaaS Mechanisms
- Cloud Foundry
- Function as a Service.

# Cluster Management
Kubernetes offers a wide range of functionalities that form the principles of any modern infrastructure. These capabilities revolve around ***automation, portability, extensibility, flexibility, self-healing***, and many more. However, managing Kubernetes at scale is challenging, especially when the clusters are self-hosted in datacenters or private clouds. In this case, a team has to keep up-to-date with the latest Kubernetes releases, to ensure the platform is updated, upgraded, managed, and configured to meet the production-grade standards.

Within any organization, a release process consists of releasing the application to multiple environments, such as `sandbox, staging, and production`. In this case, each environment is represented by a separate Kubernetes cluster, with a total of 3 clusters. However, the number of clusters grows exponentially if the platform is replicated across different regions. This is usually required to keep market proximity and deliver a service to consumers with minimal latency. As a result, if the infrastructure is distributed across the US, Europe, and the Asia Pacific, a team ends up operating 9 clusters. `Configuring, managing, upgrading, updating, and deploying` to all of these clusters is a herculean task and often requires a dedicated team.

In these circumstances, if an organization does not have sufficient engineering resources, delegating the platform management to a 3rd party provider is a more suitable solution. This is covered by a `PaaS or Platform as a Service solution`.

## PaaS Mechanism
The industry is abundant with cloud-computing offerings that offer variate level of attraction of services. Some of the widely used cloud-computing services are:

- On-premise - where an engineering team has full control over the platform, including the physical servers
- IaaS or Infrastructure as a Service - where a team consumes compute, network, and storage resources from a vendor
- PaaS or Platform as a Service - where the infrastructure is fully managed by a provider, and the team is focused on application deployment.

Releasing a product to a production environment implies that a platform has been build to host this particular product. A platform consists of multiple services that need to be configured, wired, and maintained together. These services are:

- Networking - establish communication between internal and external systems, such as internet connection, firewalls, routers, and cables
- Storage- collect and store digital data, such as files, blocks, or objects
- Servers - physical machines that provide compute services for a platform
- Virtualization - abstracts physical servers, storage, and networking. For example, we have learned that hypervisors are used to virtualize servers.
- O/S - operating systems that connect the software to physical resources (e.g. Linux, Ubuntu, Windows, etc)
- Middleware - help the developers to build an application by making it easy to consume platform capabilities (e.g. messaging, API, data management)
- Runtime - execution context for an application. For example, using JVM (or Java Virtual Machine) as a Java runtime
- Data - tools for collection and storage of data that is required by an application during execution(e.g. MySQL, MongoDB, or CockroachDB)
- Applications - the business logic for a product.

### On-premise
> On-premise - cloud-computing service, where a team owns the entire technology stack.

On-premise represents a cloud-computing offering where the engineering team has full control of the platform services (from networking to applications). This solution is suitable for organizations that have sufficient engineering power and regulations that demand full control of their technology stack and operations within it.

### IaaS
> IaaS - cloud-computing service that offers the abstraction of networking, storage, server, and virtualization layers.

IaaS solutions provide the abstraction of networking, storage, server, and virtualization layers. As a result, these services are consumed on-demand by the engineering teams. Additionally, IaaS provides a suitable abstraction for the management of self-hosted Kubernetes clusters, which depend on compute, network, and storage components for a successful bootstrap process.

The most common IaaS solutions are delivered by public cloud providers such as AWS, GCP, Microsoft Azure, and many more.

### PaaS
> cloud-computing service, where the infrastructure components are managed fully by a 3rd party provider, and a team manages only the application and the data associated with it.

One of the main advantages of choosing PaaS is the easy integration with available services from a provider

PaaS is a cloud-computing offering that enables an engineering team to fully focus on application development. It abstracts all services except the application and the data associated with it. As a result, the team is required to manage the code base and any database service that the product needs to be fully operational.

Popular PaaS solutions are App Engine from GCP, Heroku, Cloud Foundry, Beanstalk from AWS, and many more.

> Advantages:

    - Time-efficiency - engineering focus is shifter toward development rather than infrastructure management
    - Scalability and high availability - on-demand resource consumption enables an application to easily scale and fail-over
    - Rich application catalog - integration of external service (e.g. databases) with minimal effort.

Disadvantages:

- Vendor lock-in - it is challenging to interchange PaaS providers without service disruption.
- Data security - since data is managed by a 3rd party, an extra layer of complexity is added to ensure data confidentiality.
- Operational limitations - the service catalog is limited to the services offered by the integrated cloud provider.

Throughout its evolution, an organization might use one or a subset of available cloud-computing services. It is essential to select an offering that closely meets business requirements. However, it is important to consider the following traits of cloud-computing services:

- The fewer components are delegated to external providers, the more control there is over available functionalities
- The more ownership there is across the stack, the more complexity is introduced in managing and delivering the product
- The fewer components are managed by an engineering team, the quicker is the usability of the stack. As such, with a PaaS offering the engineering team can deploy their application immediately. While if choosing an on-premise solution, the release of a product is possible only after the platform is built.

### For a web-store application.
By default, the PaaS (`Applications & data`) solutions offer the management of the underlying infrastructure, such as storage, databases, compute (`runtime,middleware,O/S,Virtualization, Servers`), hosting, and many more. Also, the majority of solutions will provide data analytics, security, and advanced scheduling.

As such, the web-store project will benefit from the following PaaS capabilities:

database - for storing the customer details, orders, and products details
compute - accessible scalability for the application to serve millions of customers
networking - hosting and serving the requests with no downtime
analytics - an add-on to collect data and provide metrics and logs about customer interaction with the web-store.

# Cloud Foundry
Integrating PaaS solutions within an organization shifts the engineering effort from infrastructure management to product development. Additionally, it provides a powerful developer experience throughout the release process of an application, where the main functionalities are consumed through a UI or console. However, there is one major downside with this offering: vendor and application catalog lock-in. If an application is deployed using a PaaS offering from GCP, the application catalog of external services is narrowed down to GCP services mainly. Consequently, the open-source fundamentals were applied to PaaS offerings, resulting in an open-source PaaS such as Cloud Foundry.

Cloud Foundry is an open-source PaaS, a stand-alone software package that can be installed on any available infrastructure; private, public, or hybrid cloud. Due to its open-source nature, there is no vendor lock-in and the community can contribute to its future releases and definition of the roadmap. As such, Cloud Foundry offers a production-grade release process through a solid developer experience, that enables any application to be deployed with ease.

Note: some offerings of Cloud Foundry, can be deployed on top of Kubernetes, meaning that its main components are running as pods within a cluster.

Cloud Foundry consists of multiple components that provide these core capabilities:

- Routing - handle the incoming external traffic and route it to applications
- Authentication - identity management to user accounts
- Application lifecycle - controls the application deployments, monitors their status, and reconciles any new changes to reach the desired state of the application.
- Application storage and execution - handle the availability of artifacts to applications
- Service - use service brokers to provisions on-demand the dependency services for an application, such as a database or third-party APIs
- Messaging - ensure the communication between Cloud Foundry components
- Metrics and logging - aggregates the system and application metrics and logs

In the following sections, we will explore Cloud Foundry using [SUSE Cloud Application Platform Developer Sandbox](https://epinio.io//). However, you can explore Cloud Foundry's functionalities using the following offerings as well:

- [IBM Cloud Foundry](https://www.ibm.com/cloud/cloud-foundry)
- [SAP Cloud Platform](https://www.sap.com/products/cloud-platform/get-started.html)
- [Anynines](https://paas.anynines.com/)

Some of the note worthy sections of cloud foundry are:

- Marketplace and Services - research the service catalog and explore any integrated services
- Organizations - used to manage multi-tenancy, quotas, and access to applications
- Routes - list all available endpoints used to access deployed applications
- Build Packs - explore available buildpacks packages used to build an application
- Security groups - configure the endpoints that the application can communicate with.


# Solution: Cloud Foundry
It is pivotal to understand the application functionalities and available resources. This is especially the case when a microservice-based design is chosen, and solutions suck as IaaS (Infrastructure as a Service), PaaS (Platform as a Service), SaaS (Software as a Service) are available from a multitude of vendors. Choosing the most suitable deployment tooling will lead to the efficient delivery of the product.

Considering that the application code is available, these are the steps to adopt each proposed solution:

## Kubernetes
- create an OCI (Open Container Initiative) compliant image, usually created by using Docker
- deploy a Kubernetes cluster with a valid ingress controller for the routing of requests
- deploy an observability stack, including logs and metrics
- create the YAML manifests for the application deployment
- create a CI/CD pipeline to push the Kubernetes resources to the cluster
Cloud Foundry
- write a manifest file to provide main application deployment parameters
- deploy Cloud Foundry or use Cloud Foundry PaaS solutions from 3rd part vendors
- deploy the application to Cloud Foundry (via CLI or UI)
- Note: Cloud Foundry will create the OCI compliant image by default, and it will provide the routing capacities as well.

> Cloud Foundry provides a better developer experience for application deployment, as it offers a greater level of component abstraction (no need to manage the underlying infrastructure). However, a PaaS solution locks-in the customer to a specific vendor. On the other side, Kubernetes offers full control over the container orchestration, providing more flexible management of the application.

# FaaS or Function as a Service 
> event-driven cloud-computing service that requires only the application code to execute successfully.
An organization will always explore the most efficient offering to deploy a product to consumers. PaaS solutions are lightweight on initial setup, as a team can release the code in production within days.

However, there are use cases where customers interact with a service only once a day or for a couple of hours within a day. For example, a service to update a timetable with the new bus schedule once a day. In this case, using a PaaS offering has one major downside: it is not cost-efficient. For example, with Cloud Foundry there will always be an instance of the application up and running, even if the service is used once a day. However, the team is billed for a full day.

For this scenario, a `FaaS` or [`(clickable)Function as a Service`](https://www.redhat.com/en/topics/cloud-native-apps/what-is-faas?source=searchresultlisting) is a more suitable offering. FaaS is an event-driven cloud-computing service that allows the execution of code without any management of the infrastructure and configuration files. As a result, the timetable update service is invoked only once a day, and for the rest of the time, there are no replicas of this service. A team will be billed only for the time the service is executed.

Popular FaaS solutions are AWS Lambda, Azure Functions, Cloud Functions from GCP, and many more.
> Follows this hierachy On-premises > IaaS > PaaS > FaaS
Throughout the release process, a FaaS solution only requires the application code that is built and executed immediately. In comparison with a PaaS offering, this FaaS has a quicker usability rate, as no data management or configuration files are necessary.

## Exercise: Function as a Service
FaaS (Function as a service) unlocks the ability to solely focus on building an application with no concerns for the underlying infrastructure. However, it is crucial to comprehend its usage within a microservice-based design.

Imagine the following scenario: you are working for a media (newspaper) company and was assigned to develop a microservice responsible for the life-cycle of customer accounts. The principal operations include account creation and deletion.

Considering the above, reflect on what mechanisms you would choose to deploy the microservice, PaaS, or FaaS. Elaborate on your reasoning.
```
For this particular exercise, choosing either a PaaS or FaaS would reach the end goal: making the service available to customers.

In most cases, in a newspaper context, the readers are more focused on the news content rather than managing their accounts. Also, the number of requests to get an article can be a thousandfold higher than the number of requests to create or delete an account. As such, you can assume that the microservice should not be running at all times consuming available resources, and instead invoke it on demand-only.

Conclusively, a FaaS solution would be more suitable for the management of customer account microservice.

(Services that are invoked on demand, are more cost effective, hence FaaS)
```
## Glossary

- On-premise - cloud-computing service, where a team owns the entire technology stack.
- IaaS or Infrastructure as a Service - cloud-computing service that offers the abstraction of networking, storage, server, and virtualization layers.
- PaaS or Platform as a Service - cloud-computing service, where the infrastructure components are managed fully by a 3rd party provider, and a team manages only the application and the data associated with it.
- Cloud Foundry - an open-source PaaS offering, that can be hosted on any available infrastructure
- FaaS or Function as a Service - event-driven cloud-computing service that requires only the application code to execute successfully.
[Cloud Foundry Vs Kubernetes](https://stackoverflow.com/questions/32047563/kubernetes-vs-cloudfoundry)