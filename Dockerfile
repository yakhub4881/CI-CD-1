FROM nginx:latest
RUN apt-get update && apt-get install curl -y
RUN mkdir project1
WORKDIR /project1
VOLUME ["/STORAGE1"]
ARG value=80
EXPOSE ${value}
ENV USER=SYED