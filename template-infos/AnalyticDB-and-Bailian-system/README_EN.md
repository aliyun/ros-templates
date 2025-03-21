## Overview

Although large models can understand and generate natural language, due to the lack of domain-specific knowledge, enterprise private domain knowledge, and timely knowledge updates, they cannot be directly used for enterprise AI intelligent customer service. To solve this problem, enterprises can adopt RAG technology to retrieve knowledge from external knowledge bases (enterprise private domain knowledge). The retrieved knowledge will be integrated with the original query to form a prompt, providing richer context information for the large model, thus generating more accurate answers. This solution will guide you to quickly create an RAG application (AnalyticDB for PostgreSQL vector storage + Tongyi Qianwen LLM model), enabling enterprise AI intelligent customer service, and more efficiently solving customer problems.

## Solution Advantages

* **Simple and easy to use:** Simply click a few pages to achieve knowledge retrieval enhancement, allowing the large model to have richer context information and generate more accurate answers. At the same time, this solution provides an example code for AI intelligent customer service, making it easy for you to experience AI intelligent customer service quickly.
* **Flexible and secure management:** The vector data is stored in AnalyticDB for PostgreSQL, which allows enterprises to flexibly manage data. The accompanying audit, permission management functions, etc., meet enterprise security compliance requirements.
* **Cost-effective:** Completing this solution deployment and experience will cost no more than 10 yuan (assuming that you choose to deploy the relevant specifications of the preparation stage, and the running time does not exceed 1 hour. If you adjust the resource specifications, please refer to the price displayed on the console and the final bill.)

## Solution Architecture

The cloud private network built on Ali Cloud as shown in the figure below. When deploying on-site, you can modify some settings according to the resource planning, but the resulting operating environment and architecture diagram are similar.


The technical architecture of this solution includes the following infrastructure and cloud services:

* 1 VPC: Deploy the native data warehouse AnalyticDB PostgreSQL edition in the VPC.
* 1 switch: Deploy the cloud server ECS instance and the cloud-native data warehouse AnalyticDB PostgreSQL edition instance in the switch to enable network communication between them.
* 1 cloud server ECS: Deploy the intelligent customer service.
* 1 cloud-native data warehouse AnalyticDB PostgreSQL edition instance: Provide vector data storage and retrieval services.
* Bailian: One-stop enterprise exclusive large model production platform. In this solution, call the LLM model and obtain the index function.
