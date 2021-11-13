FROM quay.io/ploigos/ploigos-tool-maven
ARG PLOIGOS_USER_UID=1001

# Mock the PSR ###########
COPY bin/mock-psr.sh /usr/local/bin/psr
##########################

# Install openscap #######
RUN INSTALL_PKGS="openscap-scanner" && \
    dnf update -y --allowerasing --nobest && \
    dnf install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    dnf clean all && \
    rm -rf /var/cache /var/log/dnf* /var/log/yum.*

# may not actually be able to run as this user at runtime
# but platforms like OpenShift will still respect users home directory
# so still worth setting
USER ${PLOIGOS_USER_UID}
##########################

# set entrypoint
COPY ploigos-base-entrypoint.sh /
ENTRYPOINT [ "/ploigos-base-entrypoint.sh" ]
