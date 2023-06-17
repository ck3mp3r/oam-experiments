---
apiVersion: core.oam.dev/v1beta1
kind: ComponentDefinition
metadata:
  name: nginx-server
spec:
  workload:
    definition:
      apiVersion: apps/v1
      kind: Deployment
  schematic:
    cue:
      template: |
        output: {
          apiVersion: "apps/v1"
          kind:       "Deployment"
          spec: {
            selector: matchLabels: {
              "app.oam.dev/component": context.name
            }
            template: {
              metadata: labels: {
                "app.oam.dev/component": context.name
              }
              spec: {
                containers: [{
                  name:  context.name
                  image: parameter.image

                  if parameter["cmd"] != _|_ {
                    command: parameter.cmd
                  }

                  if parameter["port"] != _|_ {
                    ports: [{
                      containerPort: parameter.port
                    }]
                  }

                  if parameter["env"] != _|_ {
                    env: parameter.env
                  }
                }]
              }
            }
          }
        }
        parameter: {
          image: string
          cmd?: [...string]
          port?: int
          env?: [...{
            name:  string
            value: string
          }]
        }

