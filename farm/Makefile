install:
	bazel build --host_force_python=PY2 \
		//farm/k8s:k8s.apply \
		//farm/server/k8s:k8s.apply \
		//farm/worker/k8s:k8s.apply
	bazel run --host_force_python=PY2 //farm/k8s:k8s.apply
	bazel run --host_force_python=PY2 //farm/server/k8s:k8s.apply
	bazel run --host_force_python=PY2 //farm/worker/k8s:k8s.apply

uninstall:
	bazel run --host_force_python=PY2 //farm/k8s:k8s.delete

port-forward:
	kubectl -n farm port-forward \
		`kubectl -n farm get pods --selector=k8s-app=server -o jsonpath='{.items[0].metadata.name}'` \
		8980
