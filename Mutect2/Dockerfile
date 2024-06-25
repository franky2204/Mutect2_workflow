FROM broadinstitute/gatk
LABEL maintainer="pandafake589@gmail.com"

WORKDIR /
RUN apt-get update && \
    apt-get install -y \
    tabix \
    vcftools 
WORKDIR /
COPY ./scripts /scripts