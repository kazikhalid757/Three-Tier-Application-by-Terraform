# Three-Tier Architecture on AWS using Terraform

## Overview
This project provisions a highly available **Three-Tier Architecture** on AWS using **Terraform**. It consists of the following components:

- **Frontend Tier:** Hosts the web application on EC2 instances behind an **Application Load Balancer (ALB)**.
- **Backend Tier:** Runs the backend application on private EC2 instances, accessible only through ALB.
- **Database Tier:** Uses Amazon RDS to store application data securely in a private subnet.

## Architecture Diagram
```
            Internet
               |
          ALB (Frontend)
           /       \
        EC2        EC2 (Frontend Servers)
           |         |
          ALB (Backend)
           |         |
        EC2        EC2 (Backend Servers)
           |
          RDS (Database)
```

## Project Structure
```
.
├── modules
│   ├── vpc
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── frontend
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── backend
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── rds
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── alb
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── README.md
```

## Prerequisites
- AWS CLI installed & configured (`aws configure`)
- Terraform installed (`terraform -v`)
- IAM user with necessary permissions
- SSH Key Pair created and available in AWS

## Setup and Deployment

### 1. Clone the repository
```sh
$ git clone <repo-url>
$ cd three-tier-terraform
```

### 2. Initialize Terraform
```sh
$ terraform init
```

### 3. Plan the deployment
```sh
$ terraform plan
```

### 4. Apply the deployment
```sh
$ terraform apply -auto-approve
```

### 5. Get output variables
```sh
$ terraform output
```

## Variables
The project uses **variables.tf** to define AWS settings:

| Variable | Description |
|----------|-------------|
| `vpc_cidr` | CIDR range for the VPC |
| `public_subnet_cidr` | CIDR for Public Subnet |
| `private_subnet_cidr` | CIDR for Private Subnet |
| `instance_type` | EC2 instance type |
| `db_user` | RDS database username |
| `db_password` | RDS database password |

## Destroy the Infrastructure
To remove the infrastructure, run:
```sh
$ terraform destroy -auto-approve
```

## Security Considerations
- Security groups restrict access to only required ports.
- RDS database is deployed in a private subnet.
- NAT Gateway enables backend instances to reach the internet securely.

## Future Improvements
- Implement autoscaling for frontend and backend servers.
- Enable HTTPS (TLS/SSL) for secure communication.
- Use a managed service like AWS Lambda for backend to reduce infrastructure complexity.

## Author
**Kazi Tamim**

---
