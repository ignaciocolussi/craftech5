# academy-devops-junio-2022-tarea-clase-5

## Tarea clase 5 - CI/CD

1. Crear un helm chart utilizando el comando `helm create nginx-academy` y almacenarlo en el directorio [chart/](chart).
2. Crear un registry publico en Docker Hub llamado `nginx-academy` y generar un [access-token](https://docs.docker.com/docker-hub/access-tokens/)
3. Agregar los values de helm al archivo [deploy/scopes/main.yaml](deploy/scopes/main.yaml) que se utilizaran para hacer el deploy.
   1. **Nota**: configurar el valor `image.repository` con el registry de Docker Hub, que será de la forma: `<username>/nginx-academy` 
4. CI/CD GitHub Actions:
   1. Generar un stage de build & push utilizando el [Dockerfile](Dockerfile). Subir la imagen de docker al registry creado en el punto (2).
      1. Elegir tags apropiados, de modo que al menos una de las tags sea unica para un commit.
   2. Hacer un deploy del chart a un cluster de minikube en el CI, tomar este ejemplo como referencia: https://minikube.sigs.k8s.io/docs/tutorials/setup_minikube_in_github_actions/
      1. Para instalar helm en el job de deploy se puede utilizar la action [azure/setup-helm@v3](https://github.com/Azure/setup-helm)
         1. Utilizar la version `v3.9.0` de helm
      2. Utilizar el siguiente comando de helm para hacer el deploy:
         1. `helm upgrade --install nginx-academy chart/nginx-academy --values=deploy/scopes/main.yaml --set image.tag=<image_tag> --wait --timeout "3m0s"`
            1. **Nota**: reemplazar `<image_tag>` con la variable que corresponda.
      3. Modificar los comandos que se ejecutan en el step `Test service URLs` del [ejemplo de minikube](https://minikube.sigs.k8s.io/docs/tutorials/setup_minikube_in_github_actions/) para hacer un curl al servicio de la aplicacion
5. Una vez que se hayan completado los stages de build y deploy, modificar el archivo [www/index.html](www/index.html) y validar que estos cambios se reflejen en el CI/CD.

**Nota**: Antes de hacer pruebas con minikube en el CI/CD se pueden hacer pruebas en un cluster minikube local. 
