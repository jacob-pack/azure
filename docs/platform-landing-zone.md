# Platform Landing Zone Plan  

## 1 - Purpose and Overview
A centralized and secure Azure environment to host org policies, networking, identity, logging, and monitoring enabling scalable, compliant resource usage across teams. While security and system integrity is at the root of our efforts; we also need to ensure that we allow for flexibility so as to avoid unduly impeding systems and their teams.


A general, overview, flow of how resources should be defined on tenant creation is as follows:
  - 1) Management Group Resources
  - 2) Policy Definitions
  - 3) Role Based Access Control Definitions
  - 4) Logging and Security Configurations
  - 5) Management Group Diagnostic Settings
  - 6) Hub Networking
  - 7) Role Based Access Control Assignments
  - 8) Subscription Configuratinos
  - 9) Policy Assignments

---

## 2 - Identity and Access

- Centralized Azure AD tenant
  All users, groups, and app registrations should exist in a central identity store.

- RBAC  
  Define roles like Platform Admin, Security Reader, and Network Contributor.  
  Use Azure AD groups for assignment — not individual accounts. (note: as of Q1 2025, Azure now offers the Resource Graph/Graph resource provider. Up until then, you could not as easily automate group/user creation via templates)

- Privileged Identity Management
  Enforce time-based elevation for privileged roles (e.g., Global Admin, Owner). (reflected in conditional access manager)

---

## 3 -  Management Group Hierarchy

- Design an organizational structure:
  - Root Group – high-level policy enforcement.
  - Platform Group – for shared tooling.
  - Application Groups – by department, workload, or environment.

---

## 4 - Subscription Layout

- Use dedicated subscriptions for:
  - Shared services (DNS, monitoring, firewalls).
  - Identity and governance tooling.
  - Creation of a logical system boundary at the Subscription border.

- Avoid mixing workloads across subscriptions. This is inline with the general recommendation that you only create a separate subscription for a "tightly coupled workload" or separate systems.

---

## 5 - Networking Topology

- Implement hub-and-spoke network design:
  - Hub: firewalls, ExpressRoute/VPN gateways, DNS.
  - Spokes: VNet peerings to workload environments.

- Use NSGs, route tables, and Private DNS for internal security and resolution.
- Enable Private Link for secure service connections.

---

## 6 - Policy and Security Controls

- Use Azure Policy and Initiatives to:
  - Enforce tags (Environment, CostCenter, etc...).
  - Restrict region/SKU use.
  - Require encryption and diagnostic settings.

- Register resource providers globally.
- Configure shared Key Vault, Log Analytics, and Microsoft Defender for Cloud.

---

## 7 -  Monitoring & Operations

- Centralize logs to a shared Log Analytics Workspace (note: while this is ideal, there are complexities with some services logging to multiple places such as a system log workspace and a centralized log workspace.)
- Enable:
  - Activity Logs
  - Security Alerts
  - Change Tracking
  - Metric Alerts
- Integrate with management/observability tools
---

## 8 - Automation & Blueprinting

- Provide IaC modules for:
  - Subscription provisioning
  - Hub networking
  - Shared services
  (note: it will likely be neccesary to keep our platform landing zone templates separate from our application landing zone templates)

- Use pipeline managed template deployments or Azure Blueprints (optional) to enforce structure.

---

## 9 - Cost and Budgeting

- Set budgets and cost alerts per subscription.
- Require cost tagging (Owner, Project, Environment) for all deployed resources.
