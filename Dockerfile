FROM tophackathon/ci-java8:1.1

USER root

# Create the praqma Jenkins template
COPY praqma_config.xml /var/jenkins_home/templates/praqma_config.xml
COPY praqma.groovy /usr/share/jenkins/ref/init.groovy.d/praqma.groovy

# Add praqma Jenkins plugin, including several dependencies
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# Update system files
RUN apt-get update && apt-get upgrade -y

# Install maven for general use in Jenkins
ENV MAVEN_VERSION 3.3.3

RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

USER jenkins

# Create global git configuration for Jenkins to use
RUN git config --global user.email "rmx@tophackathon.org"
RUN git config --global user.name "Relax Management"

