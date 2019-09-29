docker build -t svisagan/multi-client:latest -t svisagan/multi-client$SHA -f ./client/Dockerfile ./client
docker build -t svisagan/multi-server:latest -t svisagan/multi-server$SHA -f ./server/Dockerfile ./server
docker build -t svisagan/multi-worker:latest -t svisagan/multi-worker$SHA -f ./worker/Dockerfile ./worker
docker push svisagan/multi-client:latest
docker push svisagan/multi-server:latest
docker push svisagan/multi-worker:latest
docker push svisagan/multi-client:$SHA
docker push svisagan/multi-server:$SHA
docker push svisagan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=svisagan/multi-server:$SHA
kubectl set image deployments/client-deployment client=svisagan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker= svisagan/multi-worker:$SHA


