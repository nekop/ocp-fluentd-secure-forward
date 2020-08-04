# ocp-fluentd-secure-forward

External fluentd secure forward server for OpenShift

```
oc new-app https://github.com/nekop/ocp-fluentd-secure-forward --name=fluentd
oc annotate service fluentd service.beta.openshift.io/serving-cert-secret-name=fluentd-cert
oc set volume dc/fluentd --add --name=fluentd-cert --secret-name=fluentd-cert --mount-path=/fluentd/certs
```
