# Aplicacion de turnos de banco para Ruby TTPS

# Autor: Joaquin Ignacio Olmos | Legajo: 18707/4

## Manual de instalacion:

__Prerequisitos__

```
- Ruby version 3.0.4
- Clonar el repositorio
```

__Instalacion__

Una vez hecho esto podemos proceder a iniciar el servidor
1) Bundle install
2) rails db:create
3) rails db:migrate
4) rails db:seed
5) rails s

Estos comandos se encargaran de descargar e instalar todas las dependencias necesarias, crear la base de datos, realizar las migracions, poner informacion en ella e iniciar el servidor.

__Uso__

Para comenzar a utilizar la aplicacion tendremos que ingresar a la ip que nos dara como resultado el comando rails s.

La informacion de inicio de sesion es la siguiente:
Email: admin@admin.com
Contraseña: 123456
Esta cuenta es de administrador y nos dejara crear otros administradores y empleados.

Tambien podemos crear una cuenta de cliente desde el boton que dice, Registrate.

__Diseño__

Uso de gemas:
En este proyecto se usan dos gemas muy populares en el enterno de desarrollo de ruby, estas son devise y cancancan. La primera cubre la tarea de autenticacion y la segunda la de autorizacion. Decidi usar estas gemas porque sostengo que es una solucion mucho mas completa y probada que cualquier propuesta que hubiera podido hacer en el marco del tiempo de la cursada.

Uso de bootstrap:
El uso de bootstrap en este proyecto se realizo con la finalidad de facilitar lo mas posible la tarea de diseño de interfaz, permitiendome asi entregar una aplicacion con buen aspecto y que cumpla con los requisitos de la consigna.

Privacidad:
Solo la persona que es propietara de una cuenta (conoce email y contraseña), puede cambiar la ccontraseña de dicha cuenta dentro de la aplicacion. Esto es asi porque desde mi punto de vista, esto previene abusos de permisos y corrupcion de los datos, ya que no se facilita el acceso a cuentas ajenas.

Administrador:
Aparte de la restriccion previamente mencionada, el administrador no tiene acceso a pedir turnos, ni modificar turnos finalizados. Por el resto este rol puede hacer practicamente todo.

Flexibilidad:
Teniendo en cuenta las consideraciones de privacidad, esta aplicacion se desarrollo con la flexibilidad en mente, es por esto que como mencione anteriormente el administrador tiene la capacidad de editar, crear, borrar y ver tanta informacion. Porque por ejemplo, si un operador se relocaliza, este diseño contempla dicho caso y le permite al administrador asignarle una nueva sucursal, sin necesidad de dar de baja la cuenta vieja y crear una nueva.

