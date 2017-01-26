#!/bin/bash

# Variables
PROJ_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

cd $PROJ_DIR

# Compile the trucking-nifi-bundle project, generating a nar file to copy to the NiFi lib directory.
sbt nifiBundle/compile
cp $PROJ_DIR/trucking-nifi-bundle/nifi-trucking-nar/target/nifi-trucking-nar-0.3.2.nar /usr/hdf/current/nifi/lib/

# Register the project schemas
sbt schemaRegistrar/run

# Build and deploy the Storm topology
sbt topology/assembly
storm jar $PROJ_DIR/trucking-topology/target/scala-2.11/trucking-topology-assembly-0.3.2.jar com.orendainx.hortonworks.trucking.topology.TruckingTopology
