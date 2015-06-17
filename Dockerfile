FROM tophackathon/ci-java8:1.0

USER root

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

RUN apt-get update && apt-get upgrade -y
RUN apt-get download maven -y
RUN dpkg -i --force-depends $(find . -iname *.deb)

USER jenkins

RUN git config --global user.email "rmx@tophackathon.org"
RUN git config --global user.name "Relax Management"

