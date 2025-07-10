# Application Landing Zone Plan

To clarify, as the term "landing zone" is a bit obfuscative; 
a landing zone represents what Microsoft calls an "opinionated target architecture".
There are essentially two elements to this "opinionated target architecture".

"Opinionated", in this case, means the orgs architectual plan and intent, or just the "architecture's design" for short.
Some material considered and included in the architectural plan and intent includes:
- Security posture (threat detection, vuln mgmt, network segmentation and other security configs)
- ops consistency (centralized logging, metrics, DR, config baselines, IaC, pipelines)
- environment isolation (dev/tst/uat/prd)
- Identity and access plan
- governance and compliance (HIPAA/SOX/PCI-DSS, blueprints, policies, auditing)
- network connectivity plan (hub and spoke vs mesh, private links, DNS, IPAM)
- scalability/extensibliity
- cost management
- resiliency and high availability (fault planning, DR, health monitoring)
- Development and Engineer enablment (sandboxed environments for testing, standard pipeline, appropriate permissions)
- change management/lifecycle
- observability and intelligence (monitoring, alerts, integration with alerting tool)

The "Target Architecture" represents resources and configurations that are deployed. While the design describes how they would and should be configured.
- tenant configs
- management groups
- subscriptions
- network topology
- Logging and monitoring
- security baselines
- automation baselines
- identity and access management (RBAC, PIM, Conditional Access)

Most of these concepts are described throughout microsoft's cloud adoption framework and other policy documents here:
https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/

With that out of the way we can go further into what these look like for us:



## 1 - Naming scheme
While this will flex between resources and naming restrictions, we want naming to be as clear, condensed, and as representive as possible.
The following structure I believe achieves a suitable, modular, foundation for naming that can be flexed or adjusted minorly as needed.
I do believe there are improvements that could be made but I hesitate to dwell too long allowing "perfect to get in the way of good".

{Resource Abbreviation}-{system abbreviation}-{description}-{region abbreivation}-{instance number (where applicable)}

ex.: An azure sql database served out of the East US region would look like "{sqldb-JSP-tracking-eus}".
---

## 2 - Subscription and Resource Group Design

- Microsoft generally recommends use of *one subscription per application* or tightly coupled workload.
- I find "one subscription per application" to be a little too restrictive, as you can target subscriptions for things such as dev/tst pricing. In the instance I have the "one subscription per application", and I have DEV/TST/UAT/PRD in that subscribtion, I lose out on the ability to tailor system needs per env at the subscription level. This falls in line moreso with a "tightly coupled workload" philosphy. But, this also requires a higher level of application and infrastructure maturity for the system being considered.
- Organize **resource groups** by service type:
  - Compute / Containers (ex. "rg-JSP-compute-001")
  - Storage (ex. "rg-JSP-storage-001")
  - Databases (ex. "rg-JSP-db-001")## 
  
 ## 3 - Identity and Access Control
- **Use Managed Identities**  
  Avoid hardcoded credentials. You can use system identities to easily facilitate communication needs between resources by assigning roles to the identities.

- **Role Separation**
  - Devs: Contributor role on Dev/Test Resource Groups.
  - Systems Teams: Sub-contributor/limited in Production.
  - Enforce RBAC and Key Vault access policies.

---

## 4 - Network and Connectivity

- Integrate with hub network via VNet peering.
- Use:
  - **NSGs/ASGs** for access segmentation
  - **Private Endpoints** for PaaS connectivity
  - **No public IPs** unless absolutely neccesary; approval will be required on a case-by-case basis.

---

## 5 - CI/CD and Automation

- Standardize pipelines using:
  - Azure DevOps
  - GitHub Actions
  - Jenkins

- Include:
  - IaC modules for environment setup
  - Code-to-deploy lifecycle
  - Multi-stage gates (Dev -> Test -> UAT -> Prod)
  - PR gates/approvals for policy and infra template changes

- Store pipeline secrets in Key Vault, not in source control.

---

## 6 - Monitoring and Alerting

- Enable:
  - Application Insights for telemetry
  - Log Analytics for query and log aggregation
  - Metric alerts based on SLA (availability, latency, errors)

- Use load balancer or gateway **health probes** to track availability.

---

## 7 - Policy Compliance

- Inherit platform-level governance:
  - Tag enforcement
  - Region/SKU restrictions
  - Security baselines

- Add workload-specific policies if needed (e.g., container registry restrictions).

---

## 8 - Environment Lifecycle

- Isolate environments:
  - Separate subscriptions preferred

- Define:
  - Naming conventions
  - Backup schedules
  - Patch/update policies

---

## 9 - Cost Awareness

- Tag resources with `CostCenter`, `Owner`, `Project` or similar.
- Review budgets and usage regularly.
- Monitor unused/overprovisioned resources for cleanup.

---

## 10 - Documentation and Support

Each application environment should include:

- System architecture diagrams store in the systems infrastructure repository
- Deployment instructions
- Incident response playbooks

