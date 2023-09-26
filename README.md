
# Trafic-Manager-AppService-MySQL

 Deploy a Web Server Instance Wordpress with Azure Trafic Manager and Flexible MySQL DataBase

 [Diagram](https://github.com/Ventsislav86/Trafic-Manager-AppService-MySQL/blob/c1d7472bdf9cf6eacf8461fe8b7f5bfc947f7205/Diagram-Wordpress-App.png)





# Documentation

## Trafic Manager
Azure Traffic Manager is a DNS-based traffic load balancer. This service allows you to distribute traffic to your public facing applications across the global Azure regions. Traffic Manager also provides your public endpoints with high availability and quick responsiveness.

Traffic Manager uses DNS to direct client requests to the appropriate service endpoint based on a traffic-routing method.

[Trafic Manager Documentation](https://learn.microsoft.com/en-us/azure/traffic-manager/traffic-manager-overview)

## MySQL Flexible server
Azure Database for MySQL - Flexible Server is a fully managed production-ready database service designed for more granular control and flexibility over database management functions and configuration settings. 
Azure Database for MySQL - Flexible Server allows configuring high availability with automatic failover.

- Zone Redundant High Availability (HA):  Zone redundant HA is preferred when you want to achieve highest level of availability against any infrastructure failure in the availability zone and where latency across the availability zone is acceptable.

- Same-Zone High Availability (HA): Same-Zone HA is preferred when you want to achieve highest level of availability within a single Availability zone with the lowest network latency.

[MySQL Flexible server Documentation](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/overview)

## App Service and App Service Plan

A web app in Azure actually consists of two things, an App Service Plan and an App Service.
- The App Service it’s the actual instance of your web application, it’s where you deploy your code, set up SSL certificates, connection strings etc
- The App Service Plan when you create your app you select a plan and this determines what you pay.

[App Service Documentation](https://learn.microsoft.com/en-us/azure/app-service/)

[App Service Plan Documentation](https://learn.microsoft.com/en-us/azure/app-service/overview-hosting-plans)






# Deployment
## Deploy Trafic Manager
Deploy trafic manager with two azure end points:
 - primary endpoint - apps-west
 - secondary endpoint - apps-north
I use the following parametars:
- protocol                     = "HTTP" - The protocol used by the monitoring checks
 - port                         = 80 - The port number used by the monitoring checks.
- path                         = "/" - The path used by the monitoring checks
 - interval_in_seconds          = 30 - the interval used to check the endpoint health from a Traffic Manager probing agent. 
 - timeout_in_seconds           = 9 - The amount of time the Traffic Manager probing agent should wait before considering that check a failure when a health check probe is sent to the endpoint.
 - tolerated_number_of_failures = 3 - The number of failures a Traffic Manager probing agent tolerates before marking that endpoint as unhealthy.


## Deploy MySQL Flexible Server
Deploy MySQL Flexible server  with Flexiable Data Base and properly parametars. The MySQL server will be added with high availability Zone Redundant. For our case the firewall rule with public access will be deployed .

[mysql.tf](https://github.com/Ventsislav86/Trafic-Manager-AppService-MySQL/blob/c1d7472bdf9cf6eacf8461fe8b7f5bfc947f7205/mysql.tf)


## Deploy Service Plans and Service Apps
Deploy two Service Plans in differant region with properly sku.
Add two Service Apps with information for DB_HOST, DB_Name, DB_User and DB_password, to enable the connection between the application and database. Adding the docker image that will be used (wordpress:6.3). The traffic might get routed to the west region because the number of priority is one. In case of issue is going to route to the north region that has the second priority.

[web-app.tf](https://github.com/Ventsislav86/Trafic-Manager-AppService-MySQL/blob/c1d7472bdf9cf6eacf8461fe8b7f5bfc947f7205/web-app.tf)

[web-app-north.tf](https://github.com/Ventsislav86/Trafic-Manager-AppService-MySQL/blob/c1d7472bdf9cf6eacf8461fe8b7f5bfc947f7205/web-app-north.tf)

```bash  
  terraform init
  terraform plan
  terraform apply 
```

