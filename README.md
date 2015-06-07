Descargar:
```
git clone https://github.com/seangel92/docker-lamp.git
```

Construir:
```
docker build -t tunombre/contenedor:etiqueta .
```

Correr el contenedor
```
docker run -d --net=host tunombre/contenedor:etiqueta
```

Ver los contenedores que tienes corriendo:
```
docker ps
```

Entrar dentro:
```
docker exec -t -i ID /bin/bash
```

Para ejecutar la playbook de ansible cuando le hagamos algún cambio es mediante:
```
ansible-playbook -s site.yml -c local
```


