#  Sample Microservice Application

Stan's Robot Shop is a sample microservice application you can use as a sandbox to test and learn containerised application orchestration and monitoring techniques. It is not intended to be a comprehensive reference example of how to write a microservices application, although you will better understand some of those concepts by playing with Stan's Robot Shop. To be clear, the error handling is patchy and there is not any security built into the application.

You can get more detailed information from my [blog post](https://www.instana.com/blog/stans-robot-shop-sample-microservice-application/) about this sample microservice application.

This sample microservice application has been built using these technologies:
- NodeJS ([Express](http://expressjs.com/))
- Java ([Spring Boot](https://spring.io/))
- Python ([Flask](http://flask.pocoo.org))
- Golang
- PHP (Apache)
- MongoDB
- Redis
- MySQL ([Maxmind](http://www.maxmind.com) data)
- RabbitMQ
- Nginx
- AngularJS (1.x)

The various services in the sample application already include all required Instana components installed and configured. The Instana components provide automatic instrumentation for complete end to end [tracing](https://docs.instana.io/core_concepts/tracing/), as well as complete visibility into time series metrics for all the technologies.

To see the application performance results in the Instana dashboard, you will first need an Instana account. Don't worry a [trial account](https://instana.com/trial?utm_source=github&utm_medium=robot_shop) is free.

## Automation Authorization
 
To download the tracing module for Nginx, it needs a valid Instana agent key. Set this in the environment before starting the build.

```shell
git clone https://github.com/assafsauer/Microservices-demo-app.git
cd Microservices-demo-app/authsec
chmod 777 auto.sec.sh
./auto.sec.sh
git branch
git add manifest/auth/
git commit -m "auth policies"
git push 
sleep 20 ; kubectl get AuthorizationPolicy -A
 
BEFORE:
root@sauer-virtual-machine:/home/sauer/demo-TSM/cluter-1# curl -i --request HEAD -H 'Cache-Control: no-cache'  http://35.204.232.183/images/Ewooid.png
Warning: Setting custom HTTP method to HEAD with -X/--request may not work the 
Warning: way you want. Consider using -I/--head instead.
HTTP/1.1 200 OK
x-powered-by: Express
accept-ranges: bytes
content-length: 1955066
content-type: image/jpeg
last-modified: Wed, 06 Feb 2019 03:20:56 GMT
date: Tue, 21 Sep 2021 15:10:01 GMT
x-envoy-upstream-service-time: 21
server: istio-envoy

AFTER
root@sauer-virtual-machine:/home/sauer/demo-TSM/cluter-1# curl -i --request HEAD -H 'Cache-Control: no-cache'  http://35.204.232.183/images/Ewooid.png
Warning: Setting custom HTTP method to HEAD with -X/--request may not work the 
Warning: way you want. Consider using -I/--head instead.
HTTP/1.1 403 Forbidden
content-length: 19
content-type: text/plain
date: Tue, 21 Sep 2021 15:10:03 GMT
server: istio-envoy
x-envoy-upstream-service-time: 5
```

Now build all the images.
