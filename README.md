# EKS Example Project

This repository contains the necessary Terraform configurations to set up an Amazon EKS (Elastic Kubernetes Service) cluster along with its underlying infrastructure, including VPC, subnets, internet gateway, route tables, and a NAT gateway in AWS.

## Overview

Terraform is used to define the required infrastructure as code, making it easy to create, modify, and manage the AWS resources in a repeatable and predictable manner. This project is structured to provide a modular approach to organizing Terraform configurations.

## Prerequisites

Before you begin, ensure you have the following installed:

- [AWS CLI](https://aws.amazon.com/cli/)
- [Terraform](https://www.terraform.io/downloads.html)
- An AWS account and credentials configured locally through AWS CLI (`aws configure`)

## Project Structure

- `provider.tf` - Sets up the AWS provider
- `variables.tf` - Defines variables used across the configurations
- `vpc.tf` - Contains the VPC, subnets, internet gateway, route tables, and NAT gateway configuration
- `eks-cluster.tf` - Configuration for EKS cluster including node groups
- `outputs.tf` - Defines the outputs to fetch important data about the resources
- `README.md` - Project documentation (this file)

## Usage

To deploy the AWS infrastructure and EKS cluster:

1. **Initialize Terraform**:
   ```bash
   terraform init
