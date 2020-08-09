docker build -t hoge25/multi-client:latest -t hoge25/multi-client:$SHA ./client
docker build -t hoge25/multi-server:latest -t hoge25/multi-server:$SHA ./server
docker build -t hoge25/multi-worker:latest -t hoge25/multi-worker:$SHA ./worker

docker push hoge25/multi-client:latest
docker push hoge25/multi-server:latest
docker push hoge25/multi-worker:latest

docker push hoge25/multi-client:$SHA
docker push hoge25/multi-server:$SHA
docker push hoge25/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hoge25/multi-server:$SHA
kubectl set image deployments/client-deployment client=hoge25/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hoge25/multi-worker:$SHA