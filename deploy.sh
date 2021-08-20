docker build -t kabean/multi-client:latest -t kabean/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kabean/multi-server:latest -t kabean/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kabean/multi-worker:latest -t kabean/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kabean/multi-client:latest
docker push kabean/multi-server:latest
docker push kabean/multi-worker:latest
docker push kabean/multi-client:$SHA
docker push kabean/multi-server:$SHA
docker push kabean/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kabean/multi-server:$SHA
kubectl set image deployments/client-deployment client=kabean/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kabean/multi-worker:$SHA