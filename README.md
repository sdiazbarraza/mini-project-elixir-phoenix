# Instalar dependecias


## Requisitos previos

Asegúrate de tener instalados los siguientes paquetes en tu sistema (Linux):

```bash
sudo apt update
sudo apt install -y curl git build-essential autoconf libssl-dev libncurses5-dev \
 libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev \
 unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
```
### Instalación de postgresql

```bash
sudo apt install postgresql postgresql-contrib
```

### Crear usuario postgres1

Entrar a la consola de PostgreSQL como usuario administrador:

```bash
sudo -u postgres psql
```

En la consola ejecutar 

```bash
CREATE USER postgres1 WITH PASSWORD 'postgres1';
ALTER USER postgres1 WITH SUPERUSER;
```


### Instalación de asdf

Clona el repositorio de asdf :


```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
```


Ejecuta para instalar Erlang y Elixir desde el
```.tool-versions ```


```bash
asdf install
```

### Instalar dependencias

```bash
mix deps.get
```

### Creación de migraciones con generadores

Pacientes

```bash
mix phx.gen.html --web admin Patients Patient patients \
 first_name:string last_name:string phone:string birthdate:date email:string
```
Médicos

```bash
mix phx.gen.html --web admin Practitioners Practitioner practitioners \
 first_name:string last_name:string phone:string birthdate:date email:string
```

Recetas

```bash
mix phx.gen.html --web admin Prescriptions Prescription prescriptions \
 detail:text practitioner_id:references:practitioners patient_id:references:patients
```

### Ejecutar migraciones

```
mix ecto.migrate
```

### Cargar de Loaders

Abrir consola 

```bash
iex -S mix
```
Se recomienda usar el orden siguiente para ejecutar los loaders

Pacientes

```bash
MiniProject.Patients.loader()
```

Médicos

```bash
MiniProject.Practitioners.loader()
```
Recetas

```bash
MiniProject.Prescriptions.loader()
```

### Crear usuario para ingreso al sistema

Abrir consola

```bash
iex -S mix
```

Ejecutar la siguiente línea

```bash
alias MiniProject.Accounts

{:ok, user} = Accounts.register_user(%{
  email: "admin@example.com",
  password: "superseguro123"
})
```
### Levantar el servidor

```bash
 mix phx.server
```


## Consideraciones

Se recomienda seguir los pasos anteriores de manera secuencial

Para hacer uso del show en cada recurso de los CRUD de la aplicación, se debe hacer
click en la fila de la tabla del index del recurso visto.

Para las apis cada recurso al crear y actualizar el recurso debe seguir la siguiente estructura

```bash
{"practitioner": data para crear o actualizar}

{"patient": data para crear o actualizar}

{"prescription": data para crear o actualizar}
```
