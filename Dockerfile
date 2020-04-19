FROM ubuntu

RUN apt-get update
RUN apt-get install wget --assume-yes
RUN apt-get install bash --assume-yes
RUN apt-get install git --assume-yes
RUN apt-get install xz-utils --assume-yes
RUN apt-get install unzip --assume-yes
RUN apt-get install openjdk-8-jdk --assume-yes

RUN wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.9-stable.tar.xz
RUN tar -xJvf flutter_linux_v1.12.13+hotfix.9-stable.tar.xz -C /opt/
RUN rm flutter_linux_v1.12.13+hotfix.9-stable.tar.xz
ENV PATH=$PATH:/opt/flutter/bin

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip
RUN mkdir /usr/lib/android-sdk/
RUN unzip commandlinetools-linux-6200805_latest.zip -d /usr/lib/android-sdk/
RUN rm commandlinetools-linux-6200805_latest.zip
ENV ANDROID_HOME=/usr/lib/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/tools/bin

RUN yes | sdkmanager --sdk_root=$ANDROID_HOME tools
RUN sdkmanager "platforms;android-28" "platform-tools" "build-tools;28.0.3" # Android Pie
RUN yes | flutter doctor --android-licenses