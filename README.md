# OpenAI Whisper Backend and Frontend Deployment

This repository contains the code and configuration for deploying the OpenAI Whisper model through a backend API using AWS services such as Lambda, API Gateway, and ECR, along with a frontend layer utilizing S3, CloudFront, and Route53. The resource provisioning is automated using Terraform, and the CI/CD workflow is managed through GitHub Actions.

## Project Overview

This project aims to provide users with a reliable and high-performance experience by leveraging advanced technologies and cloud services. The OpenAI Whisper model is integrated into a serverless backend API, while the frontend assets are stored in an S3 bucket and distributed via CloudFront for improved speed.

## Components and Services

### Backend API

- AWS Lambda functions integrate the OpenAI Whisper model to process API requests.
- AWS API Gateway manages API requests from the frontend, ensuring security and scalability.
- Docker images, if applicable, are stored and managed in the Elastic Container Registry (ECR).

### Frontend

- Static assets like JavaScript, CSS, and images are stored in an S3 bucket.
- CloudFront optimizes content delivery by distributing assets globally.

### Infrastructure as Code (IaC)

- Terraform scripts automate the provisioning of backend and frontend resources on AWS.
- GitHub Actions orchestrates the CI/CD pipeline, from code testing to resource deployment.

## Getting Started

1. Clone this repository to your local machine.
2. Configure AWS credentials and ensure Terraform is installed.
3. Navigate to the `backend` directory to set up the backend API resources using Terraform.
4. Navigate to the `frontend` directory to configure the frontend resources using Terraform.
5. Follow the steps in the `terraform` directory's README to apply the changes.
6. Set up GitHub Actions by modifying the workflow file in the `.github/workflows` directory to match your environment.

## Usage and Customization

- Update the Lambda functions and API Gateway configuration in the `backend` directory to suit your needs.
- Customize the frontend by adding your static assets to the S3 bucket in the `frontend` directory.
- Modify the Terraform scripts as necessary to adjust resource configurations.

## Contributions

Contributions to this project are welcome. If you encounter issues or have suggestions, please feel free to create a pull request or submit an issue.

## License

This project is licensed under the [MIT License](LICENSE).
