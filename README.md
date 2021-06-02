[![Build Status](https://dev.azure.com/wikiazure/kemp%20toolkit/_apis/build/status/kemp%20toolkit?branchName=master)](https://dev.azure.com/wikiazure/kemp%20toolkit/_build/latest?definitionId=23&branchName=master)
# Kemp toolkit

## QuickStart Guide for POCs

This repo contains all currently available KEMP resources 


| Specifications  | VLM-500 | VLM-3000 |VLM-5000 |VLM-10G |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| Balancer Throughput License †  | Up to 500 Mbps |Up to 3 Gbps |Up to 5 Gbps  |Up to 10 Gbps  |
| SSL TPS License †  | Up to 500  | Up to 4,000  |Up to 10,000  |Up to 12,000  |
| Layer 4 concurrent connections ‡  | 3,000,000  |3,000,000  |3,000,000  | 3,000,000  |
| Max Servers Supported / Virtual Clusters  | 1000/1000 |1000/1000 |1000/1000  |1000/1000  |
| LoadMaster Clustering  | YES |YES |YES  |YES  |

## Scope of POC

Description: Define the administrative structure of the extended project team. Include roles and responsibilities, contact information, reporting structure, server share names, file directory structures, meeting schedules, and status reporting.

Determine what functionalities must be reviewed within a reasonable time frame (i.e. 75 mins) and within organizational and management constraints. Look at most the urgent and/or strategic aspects of the business problem and narrow down the assessment to a specific scope.

The scope document should answer the following questions:
- What goals does the operations assessment intend to accomplish?
- What are the applications that require highly available application delivery?
- How much traffic is generated by the applications for which the Load Balancer will service?
- How many application requests are received during peak utilization?
- Are there any special requirements for content manipulation, data caching, data compression or SSL handling?
- What security features do you need with your Load Balancers? i.e. Content Switching, SSL Acceleration, Data Compression, Data Caching Intrusion Prevention, Single Sign-On, Pre-Authentication...
- How many redundant application servers are currently working in your environment?
- Timeframe to implement an ADC within your infrastructure?
