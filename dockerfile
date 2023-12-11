# Use an official Tomcat image with Maven included as a parent image

FROM tomcat:8.5.72-jdk8-openjdk-buster

# Set environment variables for Maven

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_VERSION 3.8.4

# Install Maven

RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share && \
    mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files (pom.xml) and the source code into the container
COPY ./pom.xml ./pom.xml
COPY ./src ./src
COPY ./addressbook.war ./addressbook.war

RUN cp /app/addressbook.war /usr/local/tomcat/webapps/

# Optionally, expose the port your Tomcat server listens on (default is 8080)
EXPOSE 8080

# Start the Tomcat server when the container starts
CMD ["catalina.sh", "run"]
