FROM ubuntu:20.04
LABEL maintainer="sandrogepiro.contaldo@unito.it"

#machine initialization
RUN apt-get update -y
RUN apt-get install gcc make libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev bzip2 g++ rsync libsqlite3-dev bzip2 -y

COPY findFiles.sh .
COPY sendFiles.sh .
COPY findBowtie.sh .
COPY sendBowtie.sh .
COPY findReport.sh .
COPY sendReport.sh .
