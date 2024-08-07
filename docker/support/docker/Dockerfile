# Use Universal Base Image with OpenJDK 11 as the base
FROM registry.access.redhat.com/ubi8/openjdk-11:latest


#Arguments
ARG VERSION
ARG IBAMOE
ARG IBAMOE_KIE_SERVER
ARG EAP
ARG PROJECT_GIT_REPO
ARG JBOSS_EAP
ARG JDBC
#ARG EAP_PATCH

# Environment Variables
ENV HOME /opt/jboss
#ENV JBOSS_HOME $HOME/$JBOSS_EAP

# ADD Installation Files
#COPY --chown=jboss:jboss installs/$IBAMOE installs/$IBAMOE_KIE_SERVER installs/$IBAMOE_ADDONS installs/$EAP installs/$EAP_UPDATES /opt/jboss/

COPY installs/$EAP installs/jboss-eap-7.4.11-patch.zip installs/$IBAMOE_installer installs/installation.xml installs/installation.xml.variables /opt/jboss/

#RUN ls -al /opt/jboss
#RUN whoami
# Update Permissions on Installers
USER root
# RUN useradd -ms /bin/bash jboss
        # Switch to 'root' user to install 'jboss.container.user' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.user' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y unzip tar rsync shadow-utils \
            && microdnf clean all \
            && rpm -q unzip tar rsync shadow-utils

        # Custom scripts from 'jboss.container.user' module
        #   USER jboss

#RUN chown 185:185 /opt/jboss /opt/jboss/$EAP /opt/jboss/$IBAMOE /opt/jboss/IBAMOE-8.0-KS8.zip /opt/jboss/$IBAMOE_ADDONS


# Prepare and run installer and cleanup installation components

RUN unzip -qo /opt/jboss/$EAP -d $HOME 
RUN rm -rf /opt/jboss/$EAP
RUN echo /opt/jboss/$IBAMOE
#RUN unzip -qo /opt/jboss/$IBAMOE -d $HOME  
RUN rm -rf /opt/jboss/$IBAMOE

RUN dir -s /opt/jboss

#RUN unzip -qo /opt/jboss/$IBAMOE_KIE_SERVER -d /opt/jboss/jboss-eap-7.4/standalone/deployments 
#RUN rm -rf /opt/jboss/$IBAMOE_KIE_SERVER
#RUN touch /opt/jboss/jboss-eap-7.4/standalone/deployments/kie-server.war.dodeploy
#RUN rm -rf /opt/jboss/jboss-eap-7.4/standalone/configuration/standalone_xml_history/
# RUN mkdir -p /opt/jboss/jboss-eap-7.4/modules
# RUN mkdir -p /opt/jboss/jboss-eap-7.4/modules/org
# RUN mkdir -p /opt/jboss/jboss-eap-7.4/modules/org/postgresql
# RUN mkdir -p /opt/jboss/jboss-eap-7.4/modules/org/postgresql/main

####UPDATE THIS LINE FOR CHANGING THE DATA SOURCE JDBC PROVIDER TO APPROPRIATE JAR#####
#RUN mv /opt/jboss/postgresql-42.5.1.jar /opt/jboss/jboss-eap-7.4/standalone/deployments
####UPDATE THIS LINE FOR CHANGING THE DATA SOURCE JDBC PROVIDER TO APPRORPIATE JAR#####
RUN mkdir -p /opt/jboss/.m2/repository
RUN mv /opt/jboss/settings.xml /opt/jboss/.m2/settings.xml


##This was validating permissions - the image right now is using root a lot of places due to challenges in the image
#RUN cat /opt/jboss/jboss-eap-7.4/bin/add-user.sh
#RUN  /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u bamAdmin -p ibmpam1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all,Administrators 
#RUN  /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u adminUser -p test1234! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all,Administrators 
#RUN  /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u kieserver -p kieserver1! -ro kie-server,rest-all
#RUN  /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u caseUser -p ibmpam1! -ro user
#RUN  /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u caseManager -p ibmpam1! -ro user,manager 
#RUN  /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u caseSupplier -p ibmpam1! -ro user,supplier 
COPY --chown=jboss:jboss support/config.cli /opt/jboss
COPY --chown=jboss:jboss installs/installation.xml /opt/jboss
COPY --chown=jboss:jboss installs/installation.xml.variables /opt/jboss
RUN chown jboss:jboss /opt/jboss/jboss-eap-7.4/standalone/configuration

# CLI to change Java security logging level - this was done due a HTTP 405 error showing up with a different user ID
# The ID in the dockerfile typically uses kieserver/kieserver1! but I ended up using bamAdmin to get over 405 error more debugging will be needed

RUN  /opt/jboss/jboss-eap-7.4/bin/jboss-cli.sh --file="/opt/jboss/config.cli"
RUN cat /opt/jboss/installation.xml
RUN java -jar /opt/jboss/bamoe-installer-8.0.5.jar /opt/jboss/installation.xml

#RUN unzip -qo /opt/jboss/case-management.zip -d /opt/jboss/jboss-eap-7.4/standalone/deployments


#COPY --chown=jboss:jboss support/standalone-full.xml /opt/jboss/jboss-eap-7.4/standalone/configuration/
#COPY  --chown=jboss:jboss support/standalone-full.xml /opt/jboss/jboss-eap-7.4/standalone/configuration/standalone.xml
#COPY --chown=jboss:jboss support/userinfo.properties /opt/jboss/jboss-eap-7.4/standalone/deployments/business-central.war/WEB-INF/classes/

# USER 185
# # Add support files
# RUN /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u bamAdmin -p ibmpam1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all,Administrators --silent  
# RUN  /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u adminUser -p test1234! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all,Administrators --silent 
# RUN  /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u kieserver -p kieserver1! -ro kie-server --silent 
# RUN  /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u caseUser -p ibmpam1! -ro user --silent 
# RUN  /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u caseManager -p ibmpam1! -ro user,manager --silent 
# RUN  /opt/jboss/jboss-eap-7.4/bin/add-user.sh -a -r ApplicationRealm -u caseSupplier -p ibmpam1! -ro user,supplier --silent
# COPY support/standalone-full.xml /opt/jboss/jboss-eap-7.4/standalone/configuration/
# COPY support/userinfo.properties /opt/jboss/jboss-eap-7.4/standalone/deployments/business-central.war/WEB-INF/classes/

# Swtich back to root user to perform cleanup
# USER root

# Fix permissions on support files
#RUN chown jboss:jboss /opt/jboss/jboss-eap-7.4/standalone/configuration/standalone-full.xml /opt/jboss/jboss-eap-7.4/standalone/deployments/business-central.war/WEB-INF/classes/userinfo.properties
RUN chown jboss:jboss /opt/jboss
# Run as JBoss
RUN ls -al /opt/jboss/jboss-eap-7.4
RUN ls -al /opt/jboss/jboss-eap-7.4/standalone
RUN ls -al /opt/jboss

#RUN /opt/jboss/jboss-eap-7.4/bin/jboss-cli.sh --controller=0.0.0.0:9990 -c "patch apply /opt/jboss/jboss-eap-7.4.11-patch.zip"


RUN mkdir /home/jboss/.niogit
RUN chown jboss:jboss /home/jboss/.niogit
RUN rm -rf  /opt/jboss/jboss-eap-7.4/standalone/configuration/standalone_xml_history/current

#USER jboss
# Expose Ports
EXPOSE 9990 9999 8080

## This was a recommendation on the 405 error, but did not solve it, I am inclkuding it in case you want to explore this further
# RUN export JAVA_OPTS="$JAVA_OPTS -Djboss.modules.system.pkgs=org.jboss.byteman,org.jboss.logmanager -Djava.util.logging.manager=org.jboss.logmanager.LogManager -Dorg.jboss.logging.Logger.pluginClass=org.jboss.logging.logmanager.LoggerPluginImpl"
# RUN export JAVA_OPTS="$JAVA_OPTS -Xbootclasspath/p:$JBOSS_HOME/modules/system/layers/base/org/jboss/logmanager/main/jboss-logmanager-2.0.3.Final-redhat-1.jar"

# Run BRMS
ENV JAVA_OPTS="-Xmx4g"
ENTRYPOINT ["/opt/jboss/jboss-eap-7.4/bin/standalone.sh"]
CMD ["-c","standalone-full.xml","-b", "0.0.0.0","-bmanagement","0.0.0.0"]
