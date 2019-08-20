docker build -t nibblefritz/multi-client:latest -t nibblefritz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nibblefritz/multi-server:latest -t nibblefritz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nibblefritz/mulit-worker:latest -t nibblefritz/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nibblefritz/multi-client:latest
docker push nibblefritz/multi-server:latest
docker push nibblefritz/multi-worker:latest
docker push nibblefritz/multi-client:$SHA
docker push nibblefritz/multi-server:$SHA
docker push nibblefritz/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nibblefritz/multi-server:$SHA
kubectl set image deployments/client-deployment client=nibblefritz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nibblefritz/multi-worker:$SHA