#!/bin/bash
# © Copyright IBM Corporation 2015.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html

start()
{
	echo "----------------------------------------"
        /opt/ibm/iib-10.0.0.22/iib version
	echo "----------------------------------------"
	echo "----------------------------------------"
	pwd
	echo "Create File ConnectionParameters.docker"
	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?><IntegrationNodeConnectionParameters Version=\"10.0.0\" host=\"$INPUT_REMOTE_IP\" integrationNodeName=\"$INPUT_REMOTE_NODE_NAME\" listenerPort=\"$INPUT_REMOTE_PORT\" sslIncludeProtocols=\"SSL_TLSv2\" sslTrustStorePath=\"$INPUT_REMOTE_SSL_TRUST_STORE_PATH\" useSsl=\"$INPUT_REMOTE_USE_SSL\" userName=\"$INPUT_REMOTE_USER\" password=\"$INPUT_REMOTE_PASSWORD\" xmlns=\"http://www.ibm.com/xmlns/prod/websphere/iib/8/IntegrationNodeConnectionParameters\"/>" > /tmp/deploy/ConnectionParameters.docker
	echo "----------------------------------------"
	echo "----------------------------------------"
	echo "Starting syslog"
	sudo /usr/sbin/rsyslogd
	echo "----------------------------------------" 
	echo "----------------------------------------"
	echo "Create package $INPUT_PROJECT.bar"
	mqsipackagebar -w /github/workspace -a /tmp/bar/$INPUT_PROJECT.bar -k $INPUT_PROJECT -w 120
	echo "----------------------------------------"
	for f in /tmp/bar/* ; do
		echo "----------------------------------------"
		echo "Remote Deployment $f"
		echo "----------------------------------------"
		echo "PROJECT: $INPUT_PROJECT"
		echo "REMOTE_NODE_NAME: $INPUT_REMOTE_NODE_NAME"
		echo "REMOTE_SERVER_NAME: $INPUT_REMOTE_SERVER_NAME"
		echo "REMOTE_IP: $INPUT_REMOTE_IP"
		echo "REMOTE_PORT: $INPUT_REMOTE_PORT"			
		mqsideploy -n /tmp/deploy/ConnectionParameters.docker -e $INPUT_REMOTE_SERVER_NAME -a /tmp/bar/$INPUT_PROJECT.bar -w 120
 	done		  
	echo "----------------------------------------"
	echo "----------------------------------------"       
}


iib-license-check.sh
start
