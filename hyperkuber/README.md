## install helm chart on openshift

for example ,helm install name "hkcmp",you should 
```
oc adm policy add-scc-to-user anyuid -z hyperkuber
oc adm policy remove-scc-from-user anyuid -z hkcmp-mysql
oc adm policy remove-scc-from-user privileged -z hkcmp-redis
```


## 更新sheencloud repo
```
helm package  ./ 
helm repo index --url https://sheencloud.github.io/charts ./
```
