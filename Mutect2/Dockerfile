FROM broadinstitute/gatk
LABEL maintainer="francesco.pantini@edu.unito.it"

WORKDIR /
RUN apt-get update && \
    apt-get install -y \
    tabix \
    vcftools 
RUN apt-get install -y python3
RUN pip install tqdm
WORKDIR /
COPY ./scripts /scripts