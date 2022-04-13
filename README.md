# taskApp

#### 1.- Crear una tabla con diferentes tipos de celdas donde en la primer celda tenga un texfield en el cual se pedirá el nombre y se permitirán únicamente caracteres álfabeticos, la segunda celda pedirá una selfie al usuario al seleccionar la celda se mostrara un popup mostrando la opción de visualizar o retomar/tomar la foto (Puede usar elemetos nativos), la última celda mostrará una descripción sobre “Gráficas” y al seleccionarla mostrará el ejercicio del punto 3.

Response: Implemented in MainViewController file


#### 2.- Consumir el siguiente servicio creando los modelos correspondientes al json de respuesta.

Response: Implemented in ChartViewController file and Network module.


#### 3.-Crear una tabla dinámica a partir de la respuesta(response) del punto 2, parecida a la que se muestra a continuación:

Response: Implemented in ChartViewController file


#### 4.- Crear un proyecto en firebase para consultar la Data Base Real Time y poder manipular el color de fondo de las pantallas de la aplicación en tiempo real.

Response: Implemented in MainViewController file


#### 5.- Crear un botón de enviar al final de la tabla que envie la foto tomada en el punto 1 a googleStorage (firestoreStorage) con el nombre del usuario.

Response: Implemented in MainViewController file



#### 6.- Explique el ciclo de vida de un view controller. 

viewDidLoad: Este metodo es llamado despues de que la vista fue cargada. Se mandan a ejecutar tareas como networking.

viewWillAppear: Este metodo es llamado cada vez que la vista es visible, sirve para configurar, desabilitar o habialitar componentes de la vista. 

viewDidAppear: Este metodo es llamado despues de que la vista esta presente en la pantalla. Se puede utilizar para iniciar animaciones. 

viewWillDisappear: Este metodo es llamado cuando la vista esta por desaparecer. Se puede utilizar para detener procesos en segundo plano o operaciones.


viewDidDisappear: Este metodo es llamado cuando la vista desaparecio de la pantalla. Este metodo puede servir para detener procesos o dejar de esuchar eventos.




#### 7.- Explique el ciclo de vida de una aplicación.

    * aplication: didFinishLaunchingWithOptions : Este metodo es el primero en ejecutarse en toda la aplicacion. Sirve parapara configurar el set up inicial o configurar servicios como firebase.
    
    * AplicactionnWillEnterInForeground:Este metodo indica que la aplicacion esta por regresar a la pantalla. Tambien se dispara cuando la aplicacion regresa de background a foreground.
    
    * ApllicationDidBecomeActive: Este metodo indica que la aplicacion esta en pantalla. Aqui se pueden ejecutar tareas de codigo.
    
    * ApplicationWillResignActive: Este metodo indica que la aplicacion esta por salir de la pantalla y estar inactiva. 
    
    * Aplication did enter in background: Este metodo indica que la aplicacion paso a segundo plano.
    
    * AplicationWillTerminate: Este metodo indica que la aplicacion murio y ya no estara dispnioble. Se puede utilizar para cancelar procesos o borrar datos.
  


#### 8.- En que casos se usa un weak, un strong y un unowned. 

    * weak: Es una referencia debil que suma +1 en el ARC. Por lo cual no siempre puede que sea recolectada y cree un memory leak. Su uso dependera de lo que se este trabajando pero en general es cuando no se tiene un valor inicial.
    
    * unowned: Es una referencia debil que no en el contador del ARC. Por lo cual facilmente puede ser recolectada. Esta propieda inpide el uso de opcionales. Su uso es cuando tenemos la seguridad de que existira un valor.
    
    * strong: Es una referencia fuerte. Esta propiedad nos permmite asignnar nil pero tambien caer en problema de dependencias circulares que provocan memory leaks. Su uso puede ser para valores que sabemos que tendremos en algun momento o que pueden ser nulos.



##### 9.- ¿Qué es el ARC?

 Automatic Reference Counting. Es el recolector de basura de swift. Utilizar contadores de referencias para saber cuales deberá eliminar de memoria.

#### Punto extra

Response: El color rojo sería el color del contralador debido a que primero se ejecuta el ciclo de vida de la aplicación y posteriormente el del controlador.





