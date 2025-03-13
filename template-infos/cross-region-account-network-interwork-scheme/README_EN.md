## Overview
When you need to deploy services in multiple Alibaba Cloud accounts and want to achieve network resource interconnectivity, you can use Alibaba Cloud CEN products to achieve cross-region and cross-account network interconnectivity.

This technical solution will show you how to configure cross-region and cross-account network interconnectivity.

### Architecture

The default settings (such as regions, VPCs, instances, etc.) provided by the scheme complete the deployment of the website running environment on Alibaba Cloud. The architecture diagram is shown below. You can modify some settings according to actual situations when deploying, but the final running environment and architecture diagram are similar.


The scheme simplifies the architecture by not showing Availability Zones, vSwitches, security groups, etc.

The technical architecture of this scheme mainly includes the following infrastructure and cloud services:

* 1 CEN instance: The CEN instance is the basis for integrated network management. One CEN instance manages one network, which can cover one or more regions. Before achieving network instance interconnectivity, you need to create a CEN instance first.
* 2 TR instances: The TR instance is the core