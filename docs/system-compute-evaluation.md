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

- Best for legacy workloads requiring:
  - Custom low level control (drivers/kernel tuning)
  - Manual configuration

- Appropriate when:
  - Application is tighlty coupled to the host OS
  - No significant scaling requirements
  - System lacks automation support/skills

- Limitations:
  - Higher ops overhead (patching, availability, monitoring)
  - Poor scalability and more expensive




Qualification considers system compatibility and migration feasibility at the time of evaluation. If more cost effective compute services are desired for a given system; then the appropriate changes must be made to qualify that system for the desired configuration.


