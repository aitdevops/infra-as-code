# Infrastructure-as-Code (IaC) with Terraform

## Overview

This repository contains Terraform configurations for setting up and managing cloud infrastructure across different cloud providers. The current setup includes resources on Google Cloud Platform (GCP), with plans to expand to other clouds and add more features.

## Current Infrastructure

### Google Cloud Platform (GCP)

The following resources are currently managed using Terraform in GCP:

# Cloud Infrastructure Components

- **VPC Network**: A Virtual Private Cloud (VPC) network to host cloud resources.
- **Private Subnet**: A private subnet within the VPC for internal resources.
- **Public Subnet**: A public subnet within the VPC for internet-facing resources.
- **Internet Gateway**: A gateway to provide internet access to resources in the public subnet.
- **NAT Gateway**: A Network Address Translation (NAT) gateway for private subnet resources to access the internet securely.
- **Google Kubernetes Engine (GKE)**: A managed Kubernetes cluster for containerized applications.
- **Cloud Storage**: Google Cloud Storage for storing and managing data.
- **PostgreSQL**: A managed PostgreSQL database for data storage and retrieval.
- **Artifact Registry**: A secure, private Docker image repository to store and manage container images.
- **IAM Role and Service Account**: Identity and Access Management (IAM) roles and service accounts for managing permissions and access control.
- **Ingress**: Kubernetes Ingress resources for managing external access to the services within the GKE cluster.
- **ArgoCD**: A declarative GitOps continuous delivery tool for Kubernetes.
- **CertManager**: A Kubernetes add-on to automate the management and issuance of TLS certificates.
- **Cloud DNS**: A scalable, reliable, and managed authoritative Domain Name System (DNS) service.


## Future Plans

- **AWS Setup**: Provisioning similar infrastructure in AWS, including VPC, subnets, EC2 instances, and RDS.
- **Azure Setup**: Setting up Azure Virtual Networks (VNet), subnets, and Azure Kubernetes Service (AKS).
- **Multi-cloud Support**: Integrating and managing multi-cloud environments through Terraform modules.
- **Continuous Integration/Continuous Deployment (CI/CD)**: Implementing a CI/CD pipeline to automate infrastructure deployment.
- **Monitoring & Logging**: Adding monitoring and logging capabilities with tools like Prometheus, Grafana, and ELK stack.
- **Security Best Practices**: Implementing IAM roles, security groups, and other security best practices across all cloud providers.

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:

- [Terraform](https://www.terraform.io/downloads.html) (version >= 1.0.0)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- Access to a GCP project with necessary permissions
- Service Account key for authentication (downloaded as a JSON file)

## Setup Instructions

### Install Terraform

1. Download the [Terraform binary](https://www.terraform.io/downloads.html) for your OS.
2. Extract the binary and move it to a directory included in your system's `PATH`.
3. Verify the installation by running:

   ```bash
   terraform --version
