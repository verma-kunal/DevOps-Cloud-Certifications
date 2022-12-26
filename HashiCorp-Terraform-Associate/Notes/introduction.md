# What is Infrastructure as Code?

### Problems with Manual Configuration

- easy to mis-configure a service through human error
- hard to manage the expected state of configuration, on-demand
- hard to transfer configuration knowledge to other team members

### Infrastructure as Code

Writing a configuration script to **automate** processes like:

- creating
- updating
- destroying cloud infra
- is a blueprint of your infra
- allows to easily share, version your cloud infra

# Provisioning vs Deployment vs Orchestration

### Provisioning

- to prepare a server with systems, data, software to make it ready for network operations
- **When you launch a cloud service & configure it - provisioning**
- Configuration tools like Puppet, Ansible, Chef etc. come into use here

### Deployment

- delivering a version of your app to run a provisioned server
- via AWS CodePipeline, GitHub Actions, Jenkins etc.

### Orchestration

- co-ordinating multiple systems or services
- commonly used when working with microservices, containers and K8s

# Popular IaC Tools

<aside>
🔗 Declarative

</aside>

- what you see, is what you will get - Explicitly defining what we want
- More verbose (detailed).
- Zero chance of mis-configuration
- Uses scripting languages like JSON, YAML etc.
- Terraform uses their own called - HCL
- Useful when we want to have info of every detail of what we are doing & want to do

<aside>
🔗 Imperative

</aside>

- You say what you want & rest is done - Implicitly define what we want
- Could end up in mis-configs
- Does more than declarative
- Uses programming languages like Python, Ruby Js etc.

---

### Declarative Tools

- ARM Templates - supports only Azure
- Azure Bluprints
- AWS Cloudformation
- Cloud Deployment Manager - GCP
- Terraform - supports many cloud providers and services

### Imperative Tools

- AWS Cloud Dev Kit (CDK) - only AWS support
- Pulumi - supports AWS, Azure, GCP & K8s

---

### Which way method to choose?

- Depends on team knowledge
- Your organisation’s goals

# Declarative+ with Terraform

- Terraform is declarative but also features imperative-like functionalities
- HCL sits b/w Declarative (YAML, JSON etc.) & Imperative (Python, Js etc.)

![](https://i.imgur.com/6OUy454.png)

# Infrastructure Lifecycle

- A number of clearly defined and distinct work phases for a cloud infra, in order to:
    - plan
    - design
    - build
    - test
    - deliver
    - maintain
    - retire
- There is not a defined workflow as of now, but we broadly divide this into:
    - **Day 0**
        - initial build
        - plan and design
    - **Day 1**
        - develop & iterate over the provisioned infra
        - automate tasks
    - **Day 2**
        - Go live into production
        - Maintain

---

### Advantages - when we add IaC to Infrastructure Lifecycle

- **Reliability**
    - IaC makes changes idempontent, consistent, repeatable & predictable
    - Idempotent →
- **Manageability**
    - enable mutation via code
    - revised, & minimal changes (only which are necessary & the original code remains untouched)
- **Sensibility**
    - Avoid financial and reputational loss

---

### Non-idempotent vs Idempotent

- **Very important**

![](https://i.imgur.com/pHHg8Bl.png)

# Configuration Drift

- Infrastructure has an unexpected configuration change, due to:
    - team members manually adjusting config options
    - malicious actions
    - side effects from APIs, SDK or CLIs
- If gone unnoticed, could:
    - result in loss or breach of cloud services
    - result in interruption of services
    - unexpected downtime

---

### Solution

1. Detect
2. Correct
3. Prevent
    
    ![](https://i.imgur.com/IYWMpHl.png)