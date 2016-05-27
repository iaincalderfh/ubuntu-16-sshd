FROM 1and1internet/ubuntu-16:unstable
MAINTAINER james.poole@fasthosts.com
COPY files /
ENV NOTVISIBLE "in users profile"
RUN \
apt-get update && apt-get install -y openssh-server && \
mkdir /var/run/sshd && \
echo 'root:screencast' | chpasswd && \
# SSH login fix. Otherwise user is kicked off after login
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
