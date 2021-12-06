FROM registry.redhat.io/codeready-workspaces/plugin-java11-rhel8:2.13-6
#ARG PLOIGOS_USER_UID=1001

USER root

# Mock the PSR ###########
COPY ./psr /usr/local/bin/psr
COPY ./templates/Jenkinsfile /var/lib/psr/templates/Jenkinsfile
##########################

# Install openscap #######
#RUN INSTALL_PKGS="openscap-scanner" && \
#    dnf update -y --allowerasing --nobest && \
#    dnf install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
#    dnf clean all && \
#    rm -rf /var/cache /var/log/dnf* /var/log/yum.*

# may not actually be able to run as this user at runtime
# but platforms like OpenShift will still respect users home directory
# so still worth setting
##########################

RUN microdnf install -y wget python3 npm

# Dependency check #######
RUN wget https://github.com/jeremylong/DependencyCheck/releases/download/v6.4.1/dependency-check-6.4.1-release.zip && \
    unzip dependency-check-6.4.1-release.zip -d /opt && \
    ln -s /opt/dependency-check/bin/dependency-check.sh /usr/bin/dependency-check
##########################

# snyk
RUN npm install snyk@latest -g

#RUN chown -R jboss: ~/.npm
RUN rm -rf ~/.npm

USER jboss

# set entrypoint
#COPY ploigos-base-entrypoint.sh /
#ENTRYPOINT [ "/ploigos-base-entrypoint.sh" ]
