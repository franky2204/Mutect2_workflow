FROM broadinstitute/gatk
LABEL maintainer="pandafake589@gmail.com"

WORKDIR /
RUN apt-get update && \
    apt-get install -y \
    tabix \
    vcftools 
RUN apt-get install -y python3
RUN pip install tqdm
WORKDIR /
COPY ./scripts /scripts