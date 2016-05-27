FROM 1and1internet/ubuntu-16:unstable
MAINTAINER james.poole@fasthosts.com
COPY files /
ENV NOTVISIBLE "in users profile"
RUN \
apt-get update && apt-get install -y openssh-server && \
mkdir --mode 700 /var/run/sshd && \
echo 'root:screencast' | chpasswd && \
# SSH login fix. Otherwise user is kicked off after login
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
echo "export VISIBLE=now" >> /etc/profile && \
chmod 755 /proxy_wrapper.sh && \
chmod 600 /etc/ssh/sshd_config && \
mkdir --mode 755 /sshenv && \
rm -rf /var/lib/apt/lists/*
EXPOSE 2222
