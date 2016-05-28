FROM 1and1internet/ubuntu-16:unstable
MAINTAINER james.poole@fasthosts.com
ARG DEBIAN_FRONTEND=noninteractive
COPY files /
ENV NOTVISIBLE "in users profile"
RUN \
chmod 600 /etc/ssh/sshd_config /etc/sssd/sssd.conf && \
chmod 644 /etc/ssh/ssh_config && \
apt-get update && apt-get -o Dpkg::Options::="--force-confold" install -y openssh-server sssd ssd-ipa ibpam-sss libnss-sss && \
mkdir --mode 700 /var/run/sshd && \
echo 'root:screencast' | chpasswd && \
# SSH login fix. Otherwise user is kicked off after login
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
echo "export VISIBLE=now" >> /etc/profile && \
chmod 755 /proxy_wrapper.sh && \
mkdir --mode 755 /sshenv && \
rm -rf /var/lib/apt/lists/*
EXPOSE 2222
