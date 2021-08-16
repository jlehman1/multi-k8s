docker build -t jlehman2020/multi-client:latest -t jlehman2020/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jlehman2020/multi-server:latest -t jlehman2020/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jlehman2020/multi-worker:latest -t jlehman2020/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jlehman2020/multi-client:latest
docker push jlehman2020/multi-server:latest
docker push jlehman2020/multi-worker:latest

docker push jlehman2020/multi-client:$SHA 
docker push jlehman2020/multi-server:$SHA 
docker push jlehman2020/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jlehman2020/multi-server:$SHA
kubectl set image deployments/client-deployment client=jlehman2020/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jlehman2020/multi-worker:$SHA

