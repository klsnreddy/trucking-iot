#!/bin/bash

# Variables
projVer="0.3.2"
projDir="$(cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd)"

# Jump to the project directory for executing SBT commands
cd $projDir

# Storm: Build and deploy the Storm topology
echo "Building and deploying the specified Storm topology"
sbt stormTopology/assembly
storm jar $projDir/trucking-topology/target/scala-2.11/trucking-topology-assembly-$projVer.jar com.orendainx.hortonworks.trucking.topology.topologies.KafkaToKafka