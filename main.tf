provider "google"{
    credentials=var.credential
    project=var.project_id
    region=var.region

}
resource "google_compute_network" "vpc"{
    name="vpc"
    auto_create_subnetworks=false

}
resource "google_compute_subnetwork" "subnet"{
    name="subnet"
    ip_cidr_range="10.0.8.0/24"
    network=google_compute_network.vpc.id
    region="us-east1"
    

}
resource "google_compute_firewall" "allow-ssh-rule"{
    name="rule"
    network=google_compute_network.vpc.id
    allow{
        protocol="tcp"
        ports=["22"]
    }
    source_ranges=["0.0.0.0/0"]
}
resource "google_compute_instance" "default"{
    name="test"
    machine_type="e2-medium"
    zone="us-central1-a"
 boot_disk{
     initialize_params{
         image="debian-cloud/debian-9"
     }
 }   
 network_interface{
     network="default"
     
     access_config{

     }
 }
}

