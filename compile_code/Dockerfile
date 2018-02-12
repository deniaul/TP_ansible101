FROM ubuntu:16.04
RUN apt-get update && apt-get install -y openssh-server python-apt sudo
RUN useradd -m -s /bin/bash control
COPY ansible_bis.pub /home/control/.ssh/authorized_keys
RUN chown -R control:control /home/control/.ssh/
RUN echo "control ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
RUN echo "control:control" | sudo chpasswd
RUN mkdir /opt/code
RUN mkdir /opt/sart
WORKDIR /opt/code
RUN mkdir -p /var/run/sshd
CMD ["/usr/sbin/sshd", "-D"]
