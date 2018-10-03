import boto3
import sys
# List of all subnets in a VPC
subnets = ['subnet-3eaabb01', 'subnet-07f90729', 'subnet-533bfa34', 'subnet-6843c322', 'subnet-144cc51b', 'subnet-f351acaf']
ec2Subnets = []

def getSubnet(li1, li2):
    subnet =  list(set(li1) - set(li2))
    println subnet[0] if len(subnet) > 0 else ""
    sys.exit(0)

# Connect to EC2
ec2 = boto3.resource('ec2')

# Get information for all running instances
running_instances = ec2.instances.filter(Filters=[{
    'Name': 'instance-state-name',
    'Values': ['running']}])

for instance in running_instances:
    ec2Subnets.append(instance.subnet_id)

getSubnet(subnets, ec2Subnets)
