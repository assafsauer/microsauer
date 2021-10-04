#!/bin/bash

namespace=wiz

# get pod list
kubectl get pods -n $namespace |  awk '{print $1}' | grep -v NAME > pods.list

# activate ISTIO log on each POD 
while IFS= read -r line; do  echo $line; kubectl logs $line  -c istio-proxy -n  $namespace  >>  logs.istio; let "a++"; done < pods.list

cat logs.istio |grep 'POST\|GET' |grep -v PassthroughCluster | grep -v "HTTP/1.0"|  grep -v "outbound_." | awk  {'print $2" "$3" "$17'}| grep -E ':[0-9]' | sed -e 's/,\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}//g' | tr -d '"' |sed 's/:[0-9]*//' |  grep -E -o -v "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" > final.auth.log

rm manifest/auth/*.yaml

a=1
while IFS="" read -r line 
do
  method=$(echo $line | awk '{print $1}') 
  path=$(echo $line | awk '{print $2}' | sed 's/\"//')
  pod=$(echo $line | awk '{print $3}')

cat <<EOF > manifest/auth/auth.$pod.$a.yaml
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: auth.$pod$a
spec:
  selector:
    matchLabels:
      app: $pod
  action: ALLOW 
  rules:
  - to:
    - operation:
        methods: ["$method"]
        paths: ["$path*"]
EOF
  let "a++"
done < final.auth.log
