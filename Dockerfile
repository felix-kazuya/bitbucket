ARG     IMAGE=felixkazuyadev/openjava-base
ARG     TAG=latest
FROM $IMAGE:$TAG
MAINTAINER Christian Walonka <christian@walonka.de>
MAINTAINER Christian Walonka <cwalonka@it-economics.de>

ENV REFRESHED_AT 2019-03-04
RUN wget http://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-6.1.1-x64.bin && \
chmod +x atlassian-bitbucket-6.1.1-x64.bin && \
touch response.varfile.bitbucket && \
echo 'app.install.service$Boolean=true' >> response.varfile.bitbucket && \
echo 'portChoice=custom' >> response.varfile.bitbucket && \
echo 'httpPort=8080' >> response.varfile.bitbucket && \
echo 'serverPort=8006' >> response.varfile.bitbucket && \
echo 'app.stashHome=/var/atlassian/application-data/bitbucket' >> response.varfile.bitbucket && \
echo 'app.bitbucketHome=/var/atlassian/application-data/bitbucket' >> response.varfile.bitbucket && \
echo 'sys.installationDir=/opt/atlassian/bitbucket' >> response.varfile.bitbucket && \
echo 'app.defaultInstallDir=/opt/atlassian/bitbucket' >> response.varfile.bitbucket && \
./atlassian-bitbucket-6.1.1-x64.bin -q -varfile response.varfile.bitbucket


EXPOSE 8080
EXPOSE 8006

CMD [ "/opt/atlassian/bitbucket/bin/start-bitbucket.sh -fg" ]
