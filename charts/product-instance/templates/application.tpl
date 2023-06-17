---
apiVersion: core.oam.dev/v1beta1
kind: Application
metadata:
  name: {{ include "product.fullname" . }}
  labels:
    app: {{ include "product.fullname" . }}
spec:
  components:
    - name: nginx
      type: webservice
      properties:
        image: "nginx:1.14.2"
        port: 80
