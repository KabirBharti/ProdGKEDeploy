docker build -t evilfiend/multi-client:latest -t evilfiend/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t evilfiend/multi-server:latest -t evilfiend/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t evilfiend/multi-worker:latest -t evilfiend/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push evilfiend/multi-client:latest
docker push evilfiend/multi-server:latest
docker push evilfiend/multi-worker:latest

docker push evilfiend/multi-client:$SHA
docker push evilfiend/multi-server:$SHA
docker push evilfiend/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=evilfiend/multi-server:$SHA
kubectl set image deployments/client-deployment client=evilfiend/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=evilfiend/multi-worker:$SHA