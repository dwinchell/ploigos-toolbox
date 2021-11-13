FROM quay.io/ploigos/ploigos-tool-maven

# Mock the PSR ###########
COPY bin/mock-psr.sh /usr/local/bin/psr
##########################

# set entrypoint
COPY ploigos-base-entrypoint.sh /
ENTRYPOINT [ "/ploigos-base-entrypoint.sh" ]
