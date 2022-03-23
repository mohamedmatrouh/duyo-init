kubectl apply -f volumes/pv-pvc.yaml
kubectl apply -f tasks/check-npm-install.yaml
kubectl apply -f tasks/ls-build-project.yaml
kubectl apply -f tasks/git-clone.yaml
kubectl apply -f tasks/npm-task.yaml
kubectl apply -f pipelines/pipeline.yaml
kubectl apply -f pipelinerun/pipelinerun.yaml