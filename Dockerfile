ARG     IMAGE=felixkazuyadev/openjava-base
ARG     TAG=latest
FROM $IMAGE:$TAG
MAINTAINER Christian Walonka <christian@walonka.de>
MAINTAINER Christian Walonka <cwalonka@it-economics.de>

ARG INSTALLDIR=/opt/atlassian/bitbucket
ENV INSTALLDIR=${INSTALLDIR}
ARG BITBUCKETVERSION=atlassian-bitbucket-6.1.1-x64.bin
ARG DOWNLOADPATH=http://www.atlassian.com/software/stash/downloads/binary
ARG SERVERPORT=8080
ENV SERVERPORT=${SERVERPORT}
ARG SSHSERVERPORT=8006


ENV REFRESHED_AT 2019-03-04
RUN wget $DOWNLOADPATH/$BITBUCKETVERSION && \
chmod +x $BITBUCKETVERSION && \
touch response.varfile.bitbucket && \
echo 'app.install.service$Boolean=true' >> response.varfile.bitbucket && \
echo 'portChoice=custom' >> response.varfile.bitbucket && \
echo "httpPort=$SERVERPORT" >> response.varfile.bitbucket && \
echo "serverPort=$SSHSERVERPORT" >> response.varfile.bitbucket && \
echo 'app.stashHome=/var/atlassian/application-data/bitbucket' >> response.varfile.bitbucket && \
echo 'app.bitbucketHome=/var/atlassian/application-data/bitbucket' >> response.varfile.bitbucket && \
echo 'sys.installationDir=/opt/atlassian/bitbucket' >> response.varfile.bitbucket && \
echo 'app.defaultInstallDir=/opt/atlassian/bitbucket' >> response.varfile.bitbucket && \
./$BITBUCKETVERSION -q -varfile response.varfile.bitbucket && \
ln -n /usr/share/java/mysql-connector-java.jar $INSTALLDIR/lib/mysql-connector-java.jar


EXPOSE $SERVERPORT
EXPOSE $SSHSERVERPORT

COPY entrypoint /entrypoint
RUN chmod +x /entrypoint
CMD [ "/entrypoint" ]
