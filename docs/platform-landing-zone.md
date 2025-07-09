# Platform Landing Zone Plan  
*For shared services, governance, and foundational infrastructure*

---

## I. Objective
A centralized and secure Azure environment to host org policies, networking, identity, logging, and monitoring enabling scalable, compliant resource usage across teams. 

While security and system integrity is at the root of our efforts; we also need to ensure that we allow for  flexibility so as to avoid unduly impeding systems and their teams.

---

## II. Identity and Access

- **Centralized Azure AD tenant**  
  All users, groups, and app registrations should exist in a central identity store.

- **RBAC**  
  Define roles like `Platform Admin`, `Security Reader`, and `Network Contributor`.  
  Use **Azure AD groups** for assignment — not individual accounts. (note: as of Q1 2025, Azure now offers the Resource Graph/Graph resource provider. Up until then, you could not as easily automate group/user creation via templates)

- **Privileged Identity Management**  
  Enforce time-based elevation for privileged roles (e.g., Global Admin, Owner). (reflected in conditional access manager)

---

## III. Management Group Hierarchy

- Design an organizational structure:
  - Root Group – high-level policy enforcement.
  - Platform Group – for shared tooling.
  - Application Groups – by department, workload, or environment.

---

## IV. Subscription Layout

- Use **dedicated subscriptions** for:
  - Shared services (DNS, monitoring, firewalls).
  - Identity and governance tooling.
  - for the creation of a logical system boundary at the Subscription border.

- Avoid mixing workloads across subscriptions. This is inline with the general recommendation that you only create a separate subscription for a "tightly coupled workload" or separate systems.

---

## V. Networking Topology

- Implement **hub-and-spoke network design**:
  - **Hub**: firewalls, ExpressRoute/VPN gateways, DNS.
  - **Spokes**: VNet peerings to workload environments.

- Use **NSGs**, route tables, and **Private DNS** for internal security and resolution.
- Enable **Private Link** for secure service connections.

---

## VI. Policy and Security Controls

- Use **Azure Policy** and **Initiatives** to:
  - Enforce tags (e.g., `Environment`, `CostCenter`).
  - Restrict region/SKU use.
  - Require encryption and diagnostic settings.

- Register resource providers globally.
- Configure shared **Key Vault**, **Log Analytics**, and **Microsoft Defender for Cloud**.

---

## VII. Monitoring & Operations

- Centralize logs to a shared **Log Analytics Workspace** (note: while this is ideal, there are complexities with some services logging to multiple places such as a system log workspace and a centralized log workspace.)
- Enable:
  - Activity Logs
  - Security Alerts
  - Change Tracking
  - Metric Alerts

- Integrate with management/observability tools

---

## VIII. Automation & Blueprinting

- Provide **IaC modules** for:
  - Subscription provisioning
  - Hub networking
  - Shared services
  (note: it will likely be neccesary to keep our platform landing zone templates separate from our application landing zone templates)

- Use pipeline managed template deployments or **Azure Blueprints** (optional) to enforce structure.

---

## IX. Cost and Budgeting

- Set **budgets and cost alerts** per subscription.
- Require cost tagging (`Owner`, `Project`, `Environment`) for all deployed resources.
