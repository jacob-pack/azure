# Migration Plan

Microsoft thoroughly documents much of this process in their [Azure Migrate Documentation](https://learn.microsoft.com/en-us/azure/migrate/?view=migrate-classic). I am going to break down a few of the most pertinent steps briefly here:

## Step 1: Azure Migrate Tool

We can most quickly ennumerate resources by using Azure Migrate's assesment option to inventory workloads.


## Step 2: Replication:

We can replicate the target servers into azure using the server migration tool. Both agent and agentless options are available.

## Step 3: Validate Replication

Validate the replicated resources from Step 2.

## Step 4: Cut Over

## Step 5: Performance Tuning

Adjusting and targeting configurations based on collected metrics (such as adjusting storage skus based on IOPS)

