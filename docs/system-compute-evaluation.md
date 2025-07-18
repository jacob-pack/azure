# System and Application Maturity Progression

Microsoft defines system and application maturity in variable ways through the cloud adoption framework.
From a high level , when a system is approached for cloud migration consideration, the efficacy of its migration effort
will, in part, be based on it's current maturity in several areas such as: telemetry/metrics collection and visibilty, staff readiness, and general automation. This is described in the general term "shift left", where left represents the respective workload/application. This level of observed maturity will help define how the system can be architected in a cloud environment and what approches it will qualify for up front.


## Step 0: System Definitions and Standardization

Before I continue, I'd like to recongize that the phrase "system" here is a loaded term. It represents a logical construct that is important to define before additional steps can be made in a migration; several components that should be defined for a more succesful migration to begin can be found below.

We can rely on standardized NIST documentation for these structures and terms. While some of these plans are defined with federal systems in mind; the same principles can be applied to systems in regulated and protected environments.

### NIST SP 800-18 Rev. 1 (Guide for Developing Security Plans for Information Systems)
    - Defines the initial steps needed to embark on creating a System Security Plan
    - Defines roles and responsibilities for roles such as: CIO, System Owner, Information Systems Security Officer, and others

### NIST SP 800-53 Rev. 5 (Security and Privacy Controls for Information Systems and Organizations)
    - Defines the structure the can be used for evaluating and enforcing system and security controls in detail.
    - Defines privacy controls, audit and accountability mechanisms, incident response, and more.

### NIST SP 800-37 Rev. 2 (Risk Management Framework for Information Systems and Organizations: A System Life Cycle Approach for Security and Privacy)
    - Defines additional logical and security control structures to enable risk and security management
    - Defines authorization/system boundaries, system components, and the risk management framework

These particular publications are just a few examples of several. Many individuals worry concepts like these only serve to encumber the cloud migration and evaluation process. In my experience, reviewing and defining these concepts for evaluated systems accelerate cloud adoption and migration. By giving precise, specific, language to abstract concepts we enable communication of those concepts.

By breaking down this language barrier around complex technical and organizational blockers; we can enable our teams to execute efficiently, effectively, and securely on their migration plans.

With that in mind; we can evaluate systems and their environments for the most appropriate target infrastructure.


# Step 1: Evaluating Appropriate Compute Resources based on System Characteristcs

Below are some of the most common azure compute resources and the general criteria for a system to qualify for use of that structure. 


## Virtual Machines (VMs)

- Best for:
  - legacy workloads requiring:
  - Custom low level control (drivers/kernel tuning)
  - Manual configuration

- Appropriate when:
  - Application is tighlty coupled to the host OS
  - No significant scaling requirements
  - System lacks automation support/skills

- Limitations:
  - Higher ops overhead (patching, availability, monitoring)
  - Poor scalability and more expensive


## Virtual Machine Scale Sets (VMSS)

- Best for:
 - stateless applications needing horizontal scaling capabilities

- Appropriate when:
  - Workload/application needs require dynamic scaling
  - Application is decoupled from individual instances
  - System needs zone redundancy or auto-healing

- Considerations:
  - Requires workload/application readiness (e.g., statelessness, health checks)
  - Moderate ops complexity (autoscale config, image management)

---

## App Services (PaaS)

- Best for:
  - Web APIs
  - Web apps
  - Backend services using .Net, Node.JS, Java, Python, PHP, Go, or other supported runtimes.

- Appropriate when:
  - Application is stateless
  - Ops team prefers managed hosting (no OS level access needed)
  - CI/CD pipelines are established or actively being established

- Limitations:
  - Limited control of the host/runtime
  - No support for complex networking (sidecars/sidecar injection/custom mesh)

---

## Azure Container Apps (ACA)
- Best for:
  - Systems requiring container level control without managing kubernetes

- Appropriate when:
  - Application is stateless and containerized
  - System requires granular control over resource scaling and minimal ops overhead.

- Limitations:
  - Limited control of the host/runtime
  - No support for complex networking (sidecars/sidecar injection/custom mesh)


---

## Azure Kubernetes Service (AKS)

- Best for:
  - Advanced orchestration 
  - custom runtimes 
  - multi-container workloads/applications.

- Appropriate when:
  - Application is stateless
  - Team has baseline Kubernetes skills.
  - IaC and observability components are in place.

- Limitations:
  - High complexity and management overhead (node pools, observability stack, network policy, etc.).

---


Microsoft covers these considerations in much more detail in their [Migration Strategy Assessment](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/plan/select-cloud-migration-strategy)
---
# System Evaluation Insight

Qualification considers system compatibility and migration feasibility at the time of evaluation. If more cost effective compute services are desired for a given system then (then the ones it qualified for at evaluation); then the appropriate changes must be made to qualify that system for the desired configuration.

One might notice, and be generally surprised, that the infrastructure is frequently not the most significant factor in these evaluations. Rather, many of the more efficient solutions depend on the hosted workload/application being stateless vs stateful.

This is important as many workloads/applications depend on historical configurations/operations to operate. Examples being applications that mantain user preferences locally, shopping applications mantaining information like items in a cart, or anything that mantains a current or ongoing client session. Stateless applications treat each operation as completely new and unrelated to previous operations. Applications like HTTP hosted API's are the most common example of this.

Stateful applications are frequently converted to stateless applications by rearchitecting the application into microservices or by rehosting the required stateful information to a seperate durable storage medium (such as an Azure Storage Account or a database). This generally looks like several, smaller apps, each serving specific functionality, that use the centralized storage/databases for referencing needed information.

While easy to say; refactoring applications frequently includes significant investment in development time and effort. If an organization is actively migrating to a cloud platform, and the organization decides they would like to refactor the application to better suit stateless compute offerings, they must either prioritize the migration or prioritize the refactor.

Microsoft has extensive documentation on many of these strategies and approaches in their [Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/modernize/modernize-strategies/)

---

# System Compute Maturity/Modernization Flow




