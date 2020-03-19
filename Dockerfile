from ubuntu

#Setup pre requerments
RUN apt update && apt install python python-pip wget gpg curl unzip less  -y

#Setup mongodb repo
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list


#Install mongo-clients
RUN apt update && apt install mongodb-org-shell mongo-tools -y

#Install aws client
WORKDIR /opt
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
WORKDIR /opt/aws
RUN ./install
RUN aws --version


# Add bash scripts
COPY ./code/* /code/

# Start up
CMD /code/run.sh