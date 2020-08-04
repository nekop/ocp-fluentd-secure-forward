# ocp-fluentd-secure-forward

External fluentd secure forward server for OpenShift. This repo is not for production use.

```
oc new-project test-fluentd
oc new-app https://github.com/nekop/ocp-fluentd-secure-forward --name=fluentd
oc annotate service fluentd service.beta.openshift.io/serving-cert-secret-name=fluentd-cert
oc set volume dc/fluentd --add --name=fluentd-cert --secret-name=fluentd-cert --mount-path=/fluentd/certs

cat <<EOF > fluent.conf
<source>
  @type  secure_forward
  @id in_secure_forward
  port  24284
  shared_key idontlikethiskey
  secure yes
  self_hostname fluentd.$(oc project -q).svc
  cert_path /fluentd/certs/tls.crt
  private_key_path /fluentd/certs/tls.key
</source>

<filter **>
  @type stdout
  @id stdout_output
</filter>
EOF
oc create configmap fluent-conf --from-file=fluent.conf
oc set volume dc/fluentd --add --name=fluent-conf --configmap-name=fluent-conf --mount-path=/fluentd/conf
```
