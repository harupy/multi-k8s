# build images
docker build -t harupy/multi-client:latest -t harupy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t harupy/multi-server:latest -t harupy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t harupy/multi-worker:latest -t harupy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# push latest images
docker push harupy/multi-client:latest
docker push harupy/multi-server:latest
docker push harupy/multi-worker:latest

# push dev images
docker push harupy/multi-client:$SHA
docker push harupy/multi-server:$SHA
docker push harupy/multi-worker:$SHA

# set images
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=harupy/multi-server:$SHA
kubectl set image deployments/client-deployment client=harupy/multi-client:$SHA
kubectl set image deployments/worker-deployment client=harupy/multi-worker:$SHA
