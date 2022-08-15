## install helm chart on openshift

for example ,helm install name "hkcmp",you should 
```
oc adm policy add-scc-to-user anyuid -z hyperkuber
oc adm policy add-scc-to-user anyuid -z hkcmp-mysql
oc adm policy add-scc-to-user anyuid -z hkcmp-redis
```


## 更新sheencloud repo
```
helm package  ./ 
helm repo index --url https://charts.sheencloud.com ./
```
