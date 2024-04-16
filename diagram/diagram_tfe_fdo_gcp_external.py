from diagrams import Cluster, Diagram
from diagrams.onprem.compute import Server


from diagrams.gcp.compute import ComputeEngine
from diagrams.gcp.database import SQL
from diagrams.gcp.storage import Filestore



# Variables
title = "VPC with 1 public subnet for the TFE server \nservices subnet for PostgreSQL"
outformat = "png"
filename = "diagram_tfe_fdo_gcp_mounted_disk"
direction = "TB"


with Diagram(
    name=title,
    direction=direction,
    filename=filename,
    outformat=outformat,
) as diag:
    # Non Clustered
    user = Server("user")

    # Cluster 
    with Cluster("gcp"):
        with Cluster("vpc"):
          with Cluster("subnet_public1"):
            ec2_tfe_server = ComputeEngine("TFE_server")
          with Cluster("subnet_services"):
            postgresql = SQL("PostgreSQL database")
        bucket = Filestore("TFE bucket")   
               
    # Diagram

    user >> ec2_tfe_server >> [postgresql,
                                 bucket]
   
diag
