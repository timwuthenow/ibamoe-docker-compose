DEMO="Install Demo"
AUTHORS="Community"
PROJECT="https://github.com/timwuthenow/ibamoe-docker-compose.git"
PRODUCT="IBM Business Automation Open Edition"
TARGET=./target
JBOSS_EAP=./target/jboss-eap-7.4.0
#JBOSS_HOME=$TARGET/$JBOSS_EAP
SERVER_DIR=$JBOSS_HOME/standalone/deployments
SERVER_CONF=$JBOSS_HOME/standalone/configuration/
SERVER_BIN=$JBOSS_HOME/bin
SRC_DIR=./installs
SUPPORT_DIR=./support
VERSION=8.0.4
VERSION_EAP=7.4.0
#INSTALL - IBM or Red Hat
#IF INSTALLING IBM BUSINESS AUTOMATION MANAGER OPEN EDITION LEAVE THESE NEXT LINES UNCOMMENTED, IF RED HAT UNCOMMENT 
# THOSE BELOW
#IBM INSTALLATION FILES BEGIN
INSTALL=bamoe
IBAMOE=$INSTALL-$VERSION-business-central-eap7-deployable.zip
IBAMOE_KIE_SERVER=$INSTALL-$VERSION-kie-server-ee8.zip
IBAMOE_ADDONS=$INSTALL-$VERSION-add-ons.zip
IBAMOE_KIE_SERVER=$INSTALL-$VERSION-kie-server-ee8.zip

####UPDATE THIS LINE FOR CHANGING THE DATA SOURCE JDBC PROVIDER TO APPROPRIATE JAR#####
JDBC=postgresql-42.5.1.jar
####UPDATE THIS LINE FOR CHANGING THE DATA SOURCE JDBC PROVIDER TO APPROPRIATE JAR#####
#IBM INSTALLATION FILES END


#If the installation is done with the Red Hat Developer downloaded products 
#(https://developers.redhat.com/products/rhpam/download), uncomment the following:
#RED HAT INSTALLATION FILES BEGIN
#VERSION=7.13
#INSTALL=rhpam
#IBAMOE=rhpam-$VERSION-business-central-eap7-deployable.zip
#IBAMOE_KIE_SERVER=rhpam-$VERSION-kie-server-ee8.zip
#IBAMOE_ADDONS=rhpam-$VERSION-add-ons.zip
#END RED HAT INSTALLATION FILES

PAM_CASE_MGMT=rhpam-7.7.0-case-mgmt-showcase-eap7-deployable.zip
EAP=jboss-eap-$VERSION_EAP.zip
EAP_UPDATE_VERSION=7.4.11
EAP_UPDATES=jboss-eap-$EAP_UPDATE_VERSION-patch.zip
#PROJECT_GIT_REPO=https://github.com/jbossdemocentral/rhpam7-mortgage-demo-repo
#PROJECT_GIT_REPO_NAME=examples-rhpam7-mortgage-demo-repo.git
#NIOGIT_PROJECT_GIT_REPO="MySpace/$PROJECT_GIT_REPO_NAME"

DOCKERNAME=ibamoe-8-bc-persistence-804
