# Instalar dependecias


## Requisitos previos


Asegúrate de tener instalados los siguientes paquetes en tu sistema (Linux):


```bash
sudo apt update
sudo apt install -y curl git build-essential autoconf libssl-dev libncurses5-dev \
 libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev \
 unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
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

### Crear migraciones

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

# MiniProject

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
