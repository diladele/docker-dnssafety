Dns Safety 0.16 in Docker
=======================================

This project provides a full Docker image for the latest version of [Diladele Dns Safety](https://dnssafety.diladele.com/).

Dns Safety is a free DNS server that enables filtering and sanitizing DNS requests in your network.
Main features:
 * seamlessly works for all devices in your network
 * enables policy based filtering: different filtering levels can be used for different devices
 * blocks sites with inappropriate content by category, enables safe search in Google, Bing and YouTube
 * blocks annoying ads
 * provides extensive insights about the traffic in your network

For more information, please visit our [official website](https://dnssafety.diladele.com/)

The product natively supports all major Linux platforms (Ubuntu, Debian, CentOS, Raspberry PI). With the latest release of Docker it can also run on Windows 10 Professional, Windows Server 2016 and Apple MacOS X.

***For the detailed feature description and administrator guide please check [the documentation](https://dnssafety.diladele.com/docs/).***

# Running the image from Docker Hub

Please install docker from www.docker.com.

If you had the image already deployed please see how you can [clean before updating to the newest version](#removing-existing-images-and-containers).

In order to run the product please execute the following command - it will start a DNS server on your machine on port 53:
```
    docker run -dt --name dnssafety -p 8000:8000 -p 53:53 -p 80:80 -p 443:443 -v dnssafety_etc:/opt/dnssafety/etc -v dnssafety_var:/opt/dnssafety/var diladele/dnssafety:0.16
```
After executing this command, you can connect to the Admin Console typing [http://localhost:8000](http://localhost:8000) in your browser. To enable filtering, you need to specify the IP address of the machine where the docker container is running as your DNS server:
 * either explicitly on your client device
 * or configure the router to use the new DNS server 

To stop the container, please run:

    docker stop dnssafety

To start the container again, please run:

    docker start dnssafety

# Removing existing images and containers

In order to remove the previous version of dnssafety, please perform the following steps:
  * stop running container with the following command:
```
    docker stop dnssafety
```

  * remove the container:
```
    docker rm dnssafety
```

  * remove outdated image (optional):
```
    docker rmi diladele/dnssafety
```
See how you can [install the new version](#running-the-image-from-docker-hub).

# Building the image on your machine

Please install docker from www.docker.com. After cloning this project, build it with

    ./build.sh


# Licensing

Community Edition of Diladele Dns Safety is free.

# Support

In case of any questions, please contact [support@diladele.com](mailto:support@diladele.com?subject=[GitHub]%20Dns%20Safety%20Question)

# References

* For standalone VMware ESXi/vSphere virtual appliance please visit [Dns Safety Virtual Appliance](https://dnssafety.diladele.com/download.html).
* Virtual Appliance can also be deployed natively in [Microsoft Azure](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/diladele.dnsfilter) or [Amazon AWS](https://aws.amazon.com/marketplace/pp/B083M59WBH)
* Detailed documentation for the project is [available online](https://dnssafety.diladele.com/docs/)
