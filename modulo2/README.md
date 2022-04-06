# MÓDULO 2

# :one: **Definición de problemas y objetivos**

En la primera sesión del módulo 2 seguimos conversando sobre la importancia de definir el problema a resolver. Además, abordamos el modelo de marco lógico (MML) para ayudar a esta definición, de los objetivos y sus actividades.

### :tv:[ [Video](https://youtu.be/fu0vGLGvr0Y) ]

### :closed_book: [ [Slides](https://github.com/opensaludlab/ciencia_datos/blob/main/modulo2/Sesion_1.pdf) ]

*Nota: esta sesión no tiene script.*

### Lectura recomendada

La CEPAL tiene un documento muy completo en donde explica la metodología del marco lógico (MML). Te recomiendamos mucho que lo leas y profundices en ello.

[Metodología del marco lógico para la planificación, el seguimiento y la evaluación de proyectos y programas](https://repositorio.cepal.org/bitstream/handle/11362/5607/S057518_es.pdf).

[Acá puedes revisar la tesis](http://cybertesis.uach.cl/tesis/uach/2017/bpmr457p/doc/bpmr457p.pdf) a la que se hace referencia en la charla y que se pone como ejemplo.

Complementariamente a los documentos anteriores, te dejamos un par que nos parecen interesantes:

1.  [Elaboración de la matriz de marco lógico (DIPRES. Chile)](https://www.dipres.gob.cl/598/articles-140852_doc_pdf.pdf)

2.  [Estrategia de Gestión Integrada de Prevención y Control de Dengue para Chile (OPS)](https://www.paho.org/es/node/38615)

3.  [Indicadores (UNESCO)](https://es.unesco.org/creativity/sites/creativity/files/iucd_manual_metodologico_1.pdf)

4.  [Manual de planificación, seguimiento y evaluación de los resultados de desarrollo (PNUD)](https://www.undp.org/content/dam/undp/documents/evaluation/handbook/spanish/documents/manual_completo.pdf)

------------------------------------------------------------------------

# :two: **Transformación de datos**

En esta sesión estuvimos revisando la importancia de transformar datos y cómo usar la librería `dplyr` (del megapaquete `Tidyverse`) para ello.

### :tv:[ [Video](https://youtu.be/vIErcXee7hE) ]

Nota: [El dataset usado es este](https://github.com/MinCiencia/Datos-COVID19/blob/master/output/producto2/2020-12-28-CasosConfirmados.csv)

### :raised_hand_with_fingers_splayed:[ [Taller 1](https://youtu.be/Y2dD3ie8PiQ) / [Script](https://github.com/opensaludlab/ciencia_datos/blob/main/modulo2/workshop_dplyr.R) ]

### :raised_hand_with_fingers_splayed:[ [Taller 2](https://youtu.be/Ew2o-PtT3l8) / [Script](https://github.com/opensaludlab/ciencia_datos/blob/main/Talleres/excel_workshop.R) ]

### Lectura recomendada

Para complementar lo visto en la sesión, te recomendamos mucho que leas lo siguiente:

1.  [Documentación oficial dplyr](https://dplyr.tidyverse.org/)

2.  [Capítulo 5 - R para Ciencia de Datos](https://es.r4ds.hadley.nz/transform.html)

3.  [Manipulación de data frames con dplyr](https://swcarpentry.github.io/r-novice-gapminder-es/13-dplyr/)

4.  [Programación en R](https://rsanchezs.gitbooks.io/rprogramming/content/chapter9/dplyr.html) (uso de librería `dplyr`)

Para el taller 2:

1.  [Documentación oficial librería `readxl`](https://readxl.tidyverse.org/reference/read_excel.html)

2.  [Alcances sobre aspectos geométricos de archivos Excel](https://readxl.tidyverse.org/articles/sheet-geometry.html)

3.  [Ayuda con librería purrr](http://enrdados.net/post/chuleta-de-purrr/)

------------------------------------------------------------------------

# Charla

### [¿Por qué los funcionarios públicos de salud deberías saber R para analizar sus datos?](https://youtu.be/y77nz9XBlXc)

Charla realizada en la conferencia latinoamericana LatinR 2021.

Puedes ver todo el contenido de la conferencia en [su repositorio de GitHub.](https://github.com/LatinR/presentaciones-LatinR2021)

------------------------------------------------------------------------

# :three: **Manipulación de datos**

En esta sesión estuvimos revisando la librería \`tidyr\`, que es parte del megapaquete `Tidyverse`. Esta librería nos permite manipular y ajustar los datos a formatos que nos facilitan su revisión y posterior análisis.

### :tv:[ [Video](https://youtu.be/hveAdbE92G0) ]

### :computer: [ [Script](https://github.com/opensaludlab/ciencia_datos/blob/main/modulo2/Limpieza_datos.R) ]

### Lectura recomendada

1.  [Capítulo 12 - R para Ciencia de Datos](https://r4ds-en-espaniol.netlify.app/datos-ordenados.html)

2.  [Documentación oficial `tidyr`](https://tidyr.tidyverse.org/)

3.  [R para análisis científicos reproducibles](https://swcarpentry.github.io/r-novice-gapminder-es/14-tidyr/)

Nota: La funciones `gather` y `spread` tienen otras homólogas en `tidyr` que se llaman `pivot_longer` y `pivot_wider` que es bueno que conozcas también. Puedes ver la documentación de ellas [acá](https://tidyr.tidyverse.org/reference/pivot_longer.html) y [acá](https://tidyr.tidyverse.org/reference/pivot_wider.html).

------------------------------------------------------------------------

# :four: **Análisis exploratorio de datos**

En esta sesión estuvimos revisando el análisis exploratorio de datos o EDA por sus siglas en ingles (*Exploratory Data Analysis*), que es una de las etapas más relevantes al inicio de los proyectos de datos para comprender de qué van éstos y empezar a "hacerle" preguntas a los datos. Más adelante profundizaremos en ello.

### :tv:[ [Video](https://youtu.be/ep_HvRxefck) ]

### :computer: [ [Script](https://github.com/opensaludlab/ciencia_datos/blob/main/modulo2/Analisis_exploratorio_datos_EDA.R) ]

### :raised_hand_with_fingers_splayed: [ [Taller](https://youtu.be/iR-CYYSohnU) / [Script](https://github.com/opensaludlab/ciencia_datos/blob/main/modulo2/workshop_metricas.R) ]

### Lectura recomendada

Para complementar lo visto en la sesión, te recomiendamos mucho que leas el [Capítulo 7 del libro R para Ciencia de Datos](https://r4ds-en-espaniol.netlify.app/an%C3%A1lisis-exploratorio-de-datos-eda.html). Te darás cuenta de que varios de los scripts revisados están allí.

------------------------------------------------------------------------

:yellow_square: Revisa la [carpeta `Docs`](https://github.com/opensaludlab/ciencia_datos/tree/main/modulo2/Docs), en la cual se irán dejando documentos, papers y presentaciones complementarias interesantes para este módulo. Revísalo con frecuencia.

------------------------------------------------------------------------

# **Charla**

### [¿Cómo resolver un problema usando programación?](https://youtu.be/eDpibmA2TeI)

En esta charla está invitada Valentina Fernández. Ella es nutricionista y nos habla sobre su experiencia de usar programación para resolver un problema en su unidad en el hospital donde trabaja y que era evitar muchas acciones manuales y muchas horas de trabajo para generar algunos informes, por lo cual diseñó un script que le permite automatizar esas tareas de limpieza y recolección de datos.

------------------------------------------------------------------------

# :white_check_mark: Certificado

El Bootcamp no entrega certificado de finalización. Sin embargo, si llegaste hasta acá y realizaste los módulos 1 y 2 siguiendo todos los consejos y practicaste mucho, estás absolútamente capacitada/o para realizar el curso de **IBM Cognitive Class** sin mayores problemas.

:point_right: [**Ir al curso**](https://cognitiveclass.ai/courses/r-101) **y obtén el certificado**
