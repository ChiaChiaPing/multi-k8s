docker build -t s0261105/multi-client:latest -t s0261105/multi-client:$SHA ./client/Dockerfile ./client
docker build -t s0261105/multi-server:latest -t s0261105/multi-server:$SHA ./server/Dockerfile ./server
docker build -t s0261105/multi-worker:latest -t s0261105/multi-worker:$SHA ./client/Dockerfile ./worker

docker push s0261105/multi-worker:latest
docker push s0261105/multi-client:latest
docker push s0261105/multi-server:latest

docker push s0261105/multi-worker:$SHA
docker push s0261105/multi-client:$SHA
docker push s0261105/multi-server:$SHA


kubectl apply -f ./k8s

kubectl set image deployments/server-deployment server=s0261105/multi-server:$SHA
kubectl set image deployments/client-deployment client=s0261105/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=s0261105/multi-worker:$SHA



