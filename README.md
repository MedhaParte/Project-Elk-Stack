# Project-Elk-Stack
## Automated ELK Stack Deployment

Project:
This project deploys and configures ELK Stack server to monitor cloud network setup on Azure. For this project, new virtual network(Red-Team VN2) was created in new region within the resource group. Peering was established between two virtual networks. New virtual machine was created in VN2 to host a ELK Server and container configuration and docker installation was done using playbook.

The files in this repository were used to configure the network depicted below.

[Network Diagram](https://github.com/MedhaParte/Project-Elk-Stack/blob/main/Diagrams/Network-%20Diagram-Project-Elk-Stack.jpg)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the file may be used to install only certain pieces of it, such as Filebeat.

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
- Beats in Use
- Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly secure and available, in addition to restricting access to the network. The load balancer helps servers move data efficiently, optimizes the use of application delivery resources and prevents server overloads. Load balancers conduct continuous health checks on servers to ensure they can handle requests. If necessary, the load balancer removes unhealthy servers from the pool until they are restored. 

The load balancer defends an organization against distributed denial-of-service (DDoS) attacks. The load balancer actively defends against DDoS by shifting attack traffic from the corporate server to a public cloud provider.The jump box allows the system to have fewer hardware resources and prevents the overuse of memory in cloud space.

Jump-Box minimizes the attack surface on the network since it is the only server exposed to public network. Only SSH Access to internal systems for administrative tasks is allowed from jump-box.  Jump-box is also used to deploy information of the containers to other servers. It can be considered as the main repository for docker. In this Project docker container software (docker.io) was first intalled in jump-box and then ansible container (provisioning tool) was installed by pulling image from cyberxsecurity/ansible. Thus jump-box system can be configured with minimal required memory and hardware resources in cloud setup.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network, containers and system performance. By using Beats the ELK server is able to collect logs data and metrics of the 3 web servers.

    • Filebeat collects data about the specific files on remote system. Filebeat monitors for changes in the log files or locations that are specified and collects log events. 
    • Metric beat records Machine metrics like uptime, cpu usage etc.
      
The configuration details of each machine may be found below.

| Name        | Function                  | IP Address               | Operating System |
|-------------|---------------------------|--------------------------|------------------|
| Jump-Box-VM | Gateway                   | 10.0.0.4 & 20.55.x.xxx   | Linux            |
| Web-1       | DVWA Web Server           | 10.0.0.6                 | Linux            |
| Web-2       | DVWA Web Server           | 10.0.0.7                 | Linux            |
| Web-3       | DVWA Web Server           | 10.0.0.9                 | Linux            |
| Elk-Server  | ELK Information Collector | 10.1.0.4 & 13.86.xxx.xxx | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box machine and Elk Server are accessible from the Internet. Access to this machine is only allowed from the IP addresses: 108.235.XXX.XXX (Bits disabled for security purpose). Access to Jump-box is restricted to SSH port only. Access to Elk-server’s web stack port 5601 is restricted from below listed public IP address. 

Machines within the network can only be accessed by ANSIBLE container on Jumpbox from ip address 10.0.0.4


A summary of the access policies in place can be found in the table below.

| Name        | Publicly Accessible | Allowed IP Addresses       |
|-------------|---------------------|----------------------------|
| Jump-Box-VM | Yes                 | 108.235.xxx.xxx            |
| ELK-Server  | Yes                 | 10.0.0.4 & 108.235.xxx.xxx |

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because manual errors were avoided and deployment of the container applications can be run on several machines at the same time. The configuration and installation of the services of each container were performed by playbooks which are files containing information of software to be installed, ports to be used, etc. The advantages to use ansible to automate the deployment of the container applications is that similar setup can be recreated within few minutes using ansible playbooks and also the playbook can be modified as and when needed.

###Installation of ELK-Server:-

Create a new VM with atleast 4G memory, a public IP address and basic security group that will host ELK-Server under Red-Team VN2.
 - Verify SSH access to it from ansible container on jump-box
 - Add the Elk-Server VM to Ansible’s inventory by updating it’s hosts file in /etc/ansible to include ‘elk’ server under elk group as shown below:
 
		[elk]
	
		10.1.0.4 ansible_python_interpreter=/usr/bin/python3
	
 - Create a playbook to configure servers under [elk] group. 
 
###ELK Configuration:-

Playbook install-elk was used to deploy all packages and configurations needed for ELK-Server. It implements the following tasks: 
 - Increase virtual memory using sysctl command.i.e.Set the `vm.max_map_count` to 	`262144`.
 - Set the remote user which will access ELK server
 - Installs the following `apt` packages:
 	 - `docker.io`: The Docker engine, used for running containers.
 	 - `python3-pip`: Package used to install Python software.
- Installs the following `pip` packages:
	 - `docker`: Python client for Docker. 
- Downloads the Docker container called `sebp/elk:761`. `sebp` is the organization     that made the container. `elk` is the container and `761` is the version.
- Configures the container to start with the following port mappings for Kibana access and transmission of logs to server.
 	 - `5601:5601`
 	 - `9200:9200`
 	 - `5044:5044`

#Deploy the container to ELK server by running playbook install-elk.

Following image shows the success of each step listed in playbook.

[Playbook Install-Elk](https://github.com/MedhaParte/Project-Elk-Stack/blob/main/Diagrams/ELK-Server-%20configuration.png)

## Launch the `elk-docker` container to start the ELK server.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

[Launch the container](https://github.com/MedhaParte/Project-Elk-Stack/blob/main/Diagrams/docker_ps_output.png)


### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 – 10.0.0.6
- Web-2 – 10.0.0.7
- Web-3 – 10.0.0.9

We have installed the following Beats on these machines using playbook:
- FileBeat and Metricbeat

These Beats allow us to collect the following information from each machine:

    • Filebeat monitors for changes in the syslog files of DVWA web-servers and collects log events. 
    • Metric beat records Machine metrics like cpu usage, memory usage, network statistics etc. 

### Using the Playbook

In order to use the playbook, we will use an Ansible control node which is already configured.  

SSH into the control node and follow the steps below:
- Make sure that the ELK server container is up and running
- Copy the filebeat configuration file as /etc/ansible/files/filebeat-config.yml
- Update the filebeat-config.yml file to include elk server as host for elastic search output and kibana keeping default login credentails
- Run the playbook, and navigate to the Filebeat installation page on the ELK server GUI and verify incoming data.

Following image shows the filebeat-configuration file.

[Filebeat config file](https://github.com/MedhaParte/Project-Elk-Stack/blob/main/Diagrams/filebeat-config-file.png)

filebeat-playbook.yml & metricbeat-playbook.yml are the playbook files which are saved in /etc/ansible/roles folder.

Filebeat playbook (filebeat-playbook.yml) includes: (for playbook code see playbook: filebeat-playbook.yml)

[Filebeat](https://github.com/MedhaParte/Project-Elk-Stack/blob/main/Diagrams/Filebeat-Playbook.png)

    • Selecting webservers for installing and launching filebeat 
    • Download the `.deb` file 
    • Installing the ‘.deb’ file
    • Use Ansible's `copy` module to copy the filebeat configuration file to the correct place
    • Enable and configure the filebeat modules
    • Set up and start filebeat service

Metricbeat playbook (metricbeat-playbook.yml) includes: (for playbook code see playbook:  metricbeat-playbook.yml)

[Metricbeat](https://github.com/MedhaParte/Project-Elk-Stack/blob/main/Diagrams/Metricbeat-Playbook.png)

    • Selecting webservers for installing and launching metricbeat
    • Download the `.deb` file 
    • Installing the ‘.deb’ file
    • Use Ansible's `copy` module to copy the metricbeat configuration file to the correct place
    • Configures and enable modules for metric beat
    • Set up and start metric beat service

ELK server is connected via HTTP and viewed through web browser by navigating to ELK-Server Public IP:-  http://[ELK-Server IP]:5601/app/kibana.

Following image shows the kibana dashboard for Filebeat & Metricbeat.

[Kibana Dashboard](https://github.com/MedhaParte/Project-Elk-Stack/blob/main/Diagrams/Kibana-dashboard.png)

Host file is updated to make Ansible run the playbook on a specific machine.

Machine to install elk server has to be listed under [elk] group, Whereas server to install filebeat and metricbeat is listed under [webservers] group in ‘hosts’ file in /etc/ansible/ container.

List of Commands:- [commands](https://github.com/MedhaParte/Project-Elk-Stack/blob/main/Diagrams/Commands%20Used.txt)


