https://docs.github.com/assets/cb-33882/images/help/images/overview-actions-event.png
# Introduction to Deployment Patterns
## Explore Microservices Architecture
Microservices are a word that is commonly heard nowadays. A microservice is a software component that is self-contained, deployable independently, and scalable.They're tiny, focused on doing one thing well, and can operate independently. If one microservice changes, it should have no effect on the other microservices in your landscape.By using a microservices architecture, you will be able to construct a landscape of services that can be built, tested, and deployed independently. It indicates additional dangers and complexities.It would be ideal if you established a database to track interfaces and how they interact with one another. In addition, you must manage numerous application lifecycles rather than just one.

https://cdn.hamoye.com/39cd157bd8251641f000
A multi-layer design is common in conventional applications.One layer has the user interface, another contains the business logic and services, and a third contains the data services.There are sometimes separate teams for the user interface and the backend. When anything needs to be changed, it must be changed at all levels.When transitioning to a microservices architecture, all of these levels become part of the same microservice.Only one function is provided by the microservice.The interaction between the microservices occurs asynchronously.They do not communicate directly with one another but instead employ asynchronous techniques such as queues or events.Each microservice has its own lifetime and pipeline for Continuous Delivery. If they were properly developed, you could deploy new microservice versions without affecting other portions of the system.Although the microservice design is not required for Continuous Delivery, smaller software components do aid in the implementation of a fully automated pipeline.



## Understand Modern Deployment Patterns
End users always utilize your program in a unique way. Unexpected events will occur in a data center, and numerous events from various users will cooccur, activating code that has not been tested in this manner.

To address this, we must accept that some features can only be tested in production.

Testing in production may seem intimidating, but it should not be.

We saw that it is feasible to deploy features without exposing them to all users when we discussed splitting our functional and technical releases.

We can test our software in production by combining this notion of feature toggling with our deployment procedures.

As an example:

* Canary releases.
* Dark launching.
* Blue-green deployments.
* Progressive exposure or ring-based deployment.
* Feature toggles.
* A/B testing.
* Take a critical look at your architecture
* Is your architecture and present software state ready for Continuous Delivery?

You might wish to think about the following topics:

* Is your software built as a single massive monolith or in numerous components?
* Can you supply individual components of your application?
* Can you ensure the quality of your software when it is deployed many times each week?
* How do you put your software through its paces?
* Do you have one or more versions of your software running?
* Can different versions of your software operate concurrently?
* What has to be improved in order to deploy Continuous Delivery?

