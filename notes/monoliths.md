# Monoliths and microservices
- Monolith: application design where all application tiers are managed as a single unit.
- Microservice: application design where application tiers are managed as independent, smaller units
Prior to an organization delivers a product, the engineering team needs to decide on the most suitable application architecture. In most of the cases 2 distinct models are referenced: monoliths and microservices. Regardless of the adopted structure, the main goal is to design an application that delivers value to customers and can be easily adjusted to accommodate new functionalities.

Also, each architecture encapsulates the 3 main tires of an application:

- UI (User Interface) - handles HTTP requests from the users and returns a response
- Business logic - contained the code that provides a service to the users
- Data layer - implements access and storage of data objects
Monoliths
> In a monolithic architecture, application tiers can be described as:
part of the same unit
managed in a single repository
sharing existing resources (e.g. CPU and memory)
developed in one programming language
released using a single binary
> Imagine a team develops a booking application using a monolithic approach. In this case, the UI is the website that the user interacts with. The business logic contains the code that provides the booking functionalities, such as search, booking, payment, and so on. These are written using one programming language (e.g. Java or Go) and stored in a single repository. The data layer contains functions that store and retrieve customer data. All of these components are managed as a unit, and the release is done using a single binary.
Microservices
In a microservice architecture, application tiers are managed independently, as different units. Each unit has the following characteristics:

managed in a separate repository
own allocated resources (e.g. CPU and memory)
well-defined API (Application Programming Interface) for connection to other units
implemented using the programming language of choice
released using its own binary 
> Now, let's imagine the team develops a booking application using a microservice approach.
In this case, the UI remains the website that the user interacts with. However, the business logic is split into smaller, independent units, such as login, payment, confirmation, and many more. These units are stored in separate repositories and are written using the programming language of choice (e.g. Go for the payment service and Python for login service). To interact with other services, each unit exposes an API. And lastly, the data layer contains functions that store and retrieve customer and order data. As expected, each unit is released using its own binary.

# Trade-offs for Monoliths and Microservices.
> They Impact the logivity of the project. The structure of an application is contoured by functional requirements and available resources. However, each architecture has a set of trade-offs, that need to be thoroughly examined before deciding on the final structure of the application. These trade-offs cover development complexity, scalability, time to deploy, flexibility, operational cost, and reliability. Let's examine each trade-off in more detail!

### Development Complexity
> Development complexity represents the effort required to deploy and manage an application. (Continous project maintainance based on user feedback)

> - Monoliths - one programming language; one repository; enables sequential development
> - Microservice - multiple programming languages; multiple repositories; enables concurrent development

### Scalability
> Scalability captures how an application is able to scales up and down, based on the (load) incoming traffic.

- Monoliths - replication of the entire stack; hence it's heavy on resource consumption
- Microservice - replication of a single unit, providing on-demand consumption of resources

### Time to Deploy
> Time to deploy encapsulates the build of a delivery pipeline that is used to ship features.

- Monoliths - one delivery pipeline that deploys the entire stack; more risk with each deployment leading to a lower velocity rate.
- Microservice - multiple delivery pipelines that deploy separate units; less risk with each deployment leading to a higher feature development rate.

### Flexibility
> Flexibility implies the ability to adapt to new technologies and introduce new functionalities.

- Monoliths - low rate, since the entire application stack might need restructuring to incorporate new functionalities
- Microservice - high rate, since changing an independent unit is straightforward

### Operational Cost
> Operational cost represents the cost of necessary resources to release a product.

- Monoliths - low initial cost, since one code base and one pipeline should be managed. However, the cost increases exponentially when the application needs to operate at scale.
- Microservice - high initial cost, since multiple repositories and pipelines require management. However, at scale, the cost remains proportional to the consumed resources at that point in time.

### Reliability
> Reliability captures practices for an application to recover from failure and tools to monitor an application.

- Monoliths - in a failure scenario, the entire stack needs to be recovered. Also, the visibility into each functionality is low, since all the logs and metrics are aggregated together.
- Microservice - in a failure scenario, only the failed unit needs to be recovered. Also, there is high visibility into the logs and metrics for each unit.

> Each application architecture has a set of trade-offs that need to be considered at the genesis of a project. But more importantly, it is paramount to understand how the application will be maintained in the future e.g. at scale, under load, supporting multiple releases a day, etc.

> There is no ***"golden path"*** to design a product, but a good understanding of the trade-offs will provide a clear project roadmap. Regardless if a monolith or microservice architecture is chosen, as long as the project is coupled with an efficient delivery pipeline, the ability to adopt new technologies, and easily add features, the path to could-native deployment is certain.

# Summary
Given the scenario, it is paramount to choose an architecture that would be replicable and scalable. For example, if thousands of customers access the payment service in the same timeframe, then this particular service should be scaled up. In a monolith architecture, scaling up creates a replica of everything, including front-end and customer services, in addition to the payment service. This will also consume more resources on the platform, such as CPU and memory, and takes longer to spin up.

> On the other side, a microservice is a lightweight component that requires fewer resources (CPU and memory) and less time for provisioning.

> For this example, a microservice-based architecture is chosen, based on considerations that the application is a central booking system for multiple airlines, that implies a high load. The main components are:

- Front-end - entry-point for the user, where they will choose their airline or choice
- Customer - requires a database (MySQL or Mongo) to store the customer details
- Payments - to implement PayPal and Debit based operations
> Additionally, the "payments" microservice is capable of handling multiple payment systems. Interaction with the PayPal interface and management of debit card APIs are fundamentally different. The "payments" component is a monolith that can be divided into multiple parts.

> Payments:
- PayPal - handling all the PayPal payments
- Debit - handling all the debit card payments

# Best practices for application deployment.
A set of good development practices can be applied to improve the application lifecycle throughout the release and maintenance phases.<br>
Adopting these practices increases resiliency, lowers the time to recovery, and provides transparency of how a service handles incoming requests.<br>
 Health checks are represented by an HTTP endpoint such as <code>/healthz</code> or <code>/status</code>
 ### Metrics
Metrics are necessary to quantify the performance of the application. To fully understand how a service handles requests, it is mandatory to collect statistics on how the service operates additionally it is paramount to gather statistics on resources that the application requires to be fully operational. For example, the amount of CPU, memory, and network throughput.
## Logging
Logging is a core factor in increasing the visibility and transparency of an application. When in troubleshooting or debugging scenarios, it is paramount to pin-point the functionality that impacted the service.
- How to enable auto-complete on python objects ( is it linting or ?)
> Contouring the architecture for an application is not a simple task. It requires a thorough understanding of the requirements and available resources.
### Edge Case: Amorphous Applications.
> Throughout the maintenance stage, the application structure and functionalities can change, and this is expected! The architecture of an application is not static, it is amorphous and in constant movement. This represents the organic growth of a product that is responsive to customer feedback and new emerging technologies.

> Both monolith and microservice-based applications transition in the maintenance phase after the production release. When considering adding new functionalities or incorporating new tools, it is always beneficial to focus on extensibility rather than flexibility. Generally speaking, it is more efficient to manage multiple services with a well-defined and simple functionality (as in the case of microservices), rather than add more abstraction layers to support new services (as we’ve seen with the monoliths). However, to have a well-structured maintenance phase, it is essential to understand the reasons an architecture is chosen for an application and involved trade-offs. An amorphas(dynamic) app is one that's changing.

> Some of the most encountered operations in the maintenance phase are listed below:
- A split operation - is applied if a service covers too many functionalities and it's complex to manage. Having smaller, manageable units is preferred in this context.
- A merge operation- is applied if units are too granular or perform closely interlinked operations, and it provides a development advantage to merge these together. For example, merging 2 separate services for log output and log format in a single service.
- A replace operation - is adopted when a more efficient implementation is identified for a service. For example, rewriting a Java service in Go, to optimize the overall execution time.
- A stale operation - is performed for services that are no longer providing any business value, and should be archived or deprecated. For example, services that were used to perform a one-off migration process.

> Performing any of these operations increases the longevity and continuity of a project. Overall, the end goal is to ensure the application is providing value to customers and is easy to manage by the engineering team. But more importantly, it can be observed that the structure of a project is not static. It amorphous and it evolves based on new requirements and customer feedback.
Watch how [Monzo is managing thousands](https://www.youtube.com/watch?v=t7iVCIYQbgk) of microservices and evolves their ecosystem
