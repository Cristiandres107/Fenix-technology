<?php
$host = "localhost";
$usuario = "root";
$password = "";
$basededatos = "fenix_technology";

$conexion = new mysqli($host, $usuario, $password, $basededatos);

if ($conexion->connect_error) {
    die("Conexion fallida: " . $conexion->connect_error);
}

header("Content-Type: application/json");
$metodo = $_SERVER['REQUEST_METHOD'];

$path = isset($_SERVER['PATH_INFO']) ? $_SERVER['PATH_INFO'] : '/';
$buscarId = explode('/', $path);
$id = ($path !== '/') ? end($buscarId) : null;

// Funciones para manejar la tabla 'producto'
switch ($metodo) {
    case 'GET':
        consultaDatosProducto($conexion, $id);
        break;
    case 'POST':
        insertarDatosProducto($conexion);
        break;
    case 'PUT':
        actualizarDatosProducto($conexion, $id);
        break;
    case 'DELETE':
        borrarDatosProducto($conexion, $id);
        break;
    default:
        echo json_encode(array('error' => 'Metodo no permitido'));
        break;
}

// Funciones para manejar la tabla 'marca_producto'
switch ($metodo) {
    case 'GET':
        consultaDatosMarca($conexion, $id);
        break;
    case 'POST':
        insertarDatosMarca($conexion);
        break;
    case 'PUT':
        actualizarDatosMarca($conexion, $id);
        break;
    case 'DELETE':
        borrarDatosMarca($conexion, $id);
        break;
    default:
        // No necesitas un segundo switch para el mismo método
        break;
}

// Funciones para manejar la tabla 'envio'
switch ($metodo) {
    case 'GET':
        consultaDatosEnvio($conexion, $id);
        break;
    case 'POST':
        insertarDatosEnvio($conexion);
        break;
    case 'PUT':
        actualizarDatosEnvio($conexion, $id);
        break;
    case 'DELETE':
        borrarDatosEnvio($conexion, $id);
        break;
        default:
        // No necesitas un tercer switch para el mismo método
        echo json_encode(array('error' => 'Metodo no permitido'));
        break;
}

$conexion->close();

function consultaDatosProducto($conexion, $id)
{
    $sql = ($id == null) ? "SELECT * FROM producto" : "SELECT * FROM producto WHERE Id_producto=$id";
    $resultado = $conexion->query($sql);

    if ($resultado) {
        $datos = array();
        while ($fila = $resultado->fetch_assoc()) {
            $datos[] = $fila;
        }
        echo json_encode($datos);
    } else {
        echo json_encode(array('error' => 'Error en la consulta: ' . $conexion->error));
    }
}

function insertarDatosProducto($conexion)
{
    // Implementa la lógica para insertar datos basada en la tabla solicitada.

    // Ejemplo para la tabla "producto":
    $dato = json_decode(file_get_contents('php://input'), true);

    // Verifica si la clave 'Id_producto' está definida en $dato
    if (isset($dato['Id_producto'])) {
        $id_producto = intval($dato['Id_producto']);
        $modelo = $conexion->real_escape_string($dato['Modelo_producto']);
        $tipo = $conexion->real_escape_string($dato['Tipo_producto']);
        $color = $conexion->real_escape_string($dato['Color_producto']);
        $precio = floatval($dato['Precio_producto']);
        $talla = $conexion->real_escape_string($dato['Talla_disponible_producto']);
        $cantidad = intval($dato['Cantidad_disponible_producto']);
        // ... Continúa con el resto de campos según tu tabla.

        // Verifica si ya existe un producto con el mismo ID
        $id_existente = $conexion->query("SELECT Id_producto FROM producto WHERE Id_producto = $id_producto")->fetch_assoc();

        if ($id_existente) {
            echo json_encode(array('error' => 'Error al insertar datos: La clave primaria ya existe'));
        } else {
            $sql = "INSERT INTO producto (Id_producto, Modelo_producto, Tipo_producto, Color_producto, Precio_producto, Talla_disponible_producto, Cantidad_disponible_producto) VALUES ($id_producto, '$modelo', '$tipo', '$color', $precio, '$talla', $cantidad)";
            $resultado = $conexion->query($sql);

            if ($resultado) {
                $id_insertado = $conexion->insert_id;
                echo json_encode(array('id' => $id_insertado));
            } else {
                echo json_encode(array('error' => 'Error al insertar datos: ' . $conexion->error));
            }
        }
    } else {
        echo json_encode(array('error' => 'ID no proporcionado para insertar'));
    }
}

function actualizarDatosProducto($conexion, $id)
{
    $dato = json_decode(file_get_contents('php://input'), true);

    // Verificar si el ID se proporciona
    if ($id !== null) {
        $id = $conexion->real_escape_string($id);

        // Verificar si los datos se proporcionan en el formato correcto
        if (isset($dato['Modelo_producto']) || isset($dato['Tipo_producto']) || isset($dato['Color_producto']) || isset($dato['Precio_producto']) || isset($dato['Talla_disponible_producto']) || isset($dato['Cantidad_disponible_producto'])) {
            // Puedes agregar aquí la verificación de otros campos según tu tabla

            // Obtener los datos actuales del producto
            $sqlConsulta = "SELECT * FROM producto WHERE Id_producto = $id";
            $resultadoConsulta = $conexion->query($sqlConsulta);

            if ($resultadoConsulta && $resultadoConsulta->num_rows > 0) {
                $datosActuales = $resultadoConsulta->fetch_assoc();

                // Obtener los datos proporcionados y completar con los actuales si no se proporcionan
                $modelo = isset($dato['Modelo_producto']) ? $conexion->real_escape_string($dato['Modelo_producto']) : $datosActuales['Modelo_producto'];
                $tipo = isset($dato['Tipo_producto']) ? $conexion->real_escape_string($dato['Tipo_producto']) : $datosActuales['Tipo_producto'];
                $color = isset($dato['Color_producto']) ? $conexion->real_escape_string($dato['Color_producto']) : $datosActuales['Color_producto'];
                $precio = isset($dato['Precio_producto']) ? floatval($dato['Precio_producto']) : $datosActuales['Precio_producto'];
                $talla = isset($dato['Talla_disponible_producto']) ? $conexion->real_escape_string($dato['Talla_disponible_producto']) : $datosActuales['Talla_disponible_producto'];
                $cantidad = isset($dato['Cantidad_disponible_producto']) ? intval($dato['Cantidad_disponible_producto']) : $datosActuales['Cantidad_disponible_producto'];

                // Puedes continuar con el resto de campos según tu tabla

                // Construir la consulta SQL de actualización
                $sql = "UPDATE producto SET Modelo_producto = '$modelo', Tipo_producto = '$tipo', Color_producto = '$color', Precio_producto = $precio, Talla_disponible_producto = '$talla', Cantidad_disponible_producto = $cantidad WHERE Id_producto = $id";

                // Ejecutar la consulta
                $resultado = $conexion->query($sql);

                // Verificar si la actualización fue exitosa
                if ($resultado) {
                    echo json_encode(array('mensaje' => 'Datos actualizados'));
                } else {
                    echo json_encode(array('error' => 'Error al actualizar datos: ' . $conexion->error));
                }
            } else {
                echo json_encode(array('error' => 'No se encontraron datos para el ID proporcionado'));
            }
        } else {
            echo json_encode(array('error' => 'Datos incompletos o incorrectos para actualizar'));
        }
    } else {
        echo json_encode(array('error' => 'ID no proporcionado para actualizar'));
    }
}

function borrarDatosProducto($conexion, $id)
{
    if ($id !== null) {
        $id = $conexion->real_escape_string($id);

        // Desactivar temporáneamente las restricciones de clave externa
        $conexion->query('SET foreign_key_checks = 0');

        // Ahora, eliminar el producto sin verificar restricciones de clave externa
        $sqlProducto = "DELETE FROM producto WHERE Id_producto = $id";
        $resultadoProducto = $conexion->query($sqlProducto);

        // Restaurar las restricciones de clave externa
        $conexion->query('SET foreign_key_checks = 1');

        if ($resultadoProducto) {
            echo json_encode(array('mensaje' => 'Producto borrado'));
        } else {
            echo json_encode(array('error' => 'Error al borrar producto: ' . $conexion->error));
        }
    } else {
        echo json_encode(array('error' => 'ID no proporcionado para borrar'));
    }
}
// Conexión y funciones para la tabla 'marca_producto'
function verificarDatosParaActualizar($dato)
{
    return isset($dato['Modelo_producto']) || isset($dato['Tipo_producto']) || isset($dato['Color_producto']) || isset($dato['Precio_producto']) || isset($dato['Talla_disponible_producto']) || isset($dato['Cantidad_disponible_producto']);
}


function consultaDatosMarca($conexion, $id)
{
    $sql = ($id == null) ? "SELECT * FROM marca_producto" : "SELECT * FROM marca_producto WHERE Id_marca_producto=$id";
    $resultado = $conexion->query($sql);

    if ($resultado) {
        $datos = array();
        while ($fila = $resultado->fetch_assoc()) {
            $datos[] = $fila;
        }
        echo json_encode($datos);
    } else {
        echo json_encode(array('error' => 'Error en la consulta: ' . $conexion->error));
    }
}

function insertarDatosMarca($conexion)
{
    // Implementa la lógica para insertar datos basada en la tabla solicitada.

    // Ejemplo para la tabla "marca_producto":
    $dato = json_decode(file_get_contents('php://input'), true);

    // Verifica si las claves necesarias existen en el array $dato
    if (isset($dato['Id_marca_producto'], $dato['Nom_marca_producto'], $dato['Estado_marca_producto'])) {
        $id_existente = $conexion->query("SELECT Id_marca_producto FROM marca_producto WHERE Id_marca_producto = {$dato['Id_marca_producto']}")->fetch_assoc();

        if ($id_existente) {
            echo json_encode(array('error' => 'Error al insertar datos: La clave primaria ya existe'));
        } else {
            $nom = $conexion->real_escape_string($dato['Nom_marca_producto']);
            $estado = intval($dato['Estado_marca_producto']);

            $sql = "INSERT INTO marca_producto (Id_marca_producto, Nom_marca_producto, Estado_marca_producto) VALUES ({$dato['Id_marca_producto']}, '$nom', $estado)";
            $resultado = $conexion->query($sql);

            if ($resultado) {
                $id_insertado = $conexion->insert_id;
                echo json_encode(array('id' => $id_insertado));
            } else {
                echo json_encode(array('error' => 'Error al insertar datos: ' . $conexion->error . ' - ' . $sql));
            }
            
        }
    } else {
        echo json_encode(array('error' => 'Datos incompletos o incorrectos para insertar en marca_producto'));
    }
}


function actualizarDatosMarca($conexion, $id)
{
    $dato = json_decode(file_get_contents('php://input'), true);

    if ($id !== null) {
        $id = $conexion->real_escape_string($id);

        if (verificarDatosParaActualizarMarca($dato)) {
            $datosActuales = obtenerDatosActuales($conexion, 'marca_producto', $id);

            if ($datosActuales !== null) {
                $nom = isset($dato['Nom_marca_producto']) ? $conexion->real_escape_string($dato['Nom_marca_producto']) : $datosActuales['Nom_marca_producto'];
                $estado = isset($dato['Estado_marca_producto']) ? intval($dato['Estado_marca_producto']) : $datosActuales['Estado_marca_producto'];

                $sql = "UPDATE marca_producto SET Nom_marca_producto = '$nom', Estado_marca_producto = $estado WHERE Id_marca_producto = $id";

                $resultado = $conexion->query($sql);

                if ($resultado) {
                    echo json_encode(array('mensaje' => 'Datos actualizados'));
                } else {
                    echo json_encode(array('error' => 'Error al actualizar datos: ' . $conexion->error . ' - ' . $sql));
                }
            } else {
                echo json_encode(array('error' => 'No se encontraron datos para el ID proporcionado'));
            }
        } else {
            echo json_encode(array('error' => 'Datos incompletos o incorrectos para actualizar'));
        }
    } else {
        echo json_encode(array('error' => 'ID no proporcionado para actualizar'));
    }
}


function borrarDatosMarca($conexion, $id)
{
    if ($id !== null) {
        $id = $conexion->real_escape_string($id);

        $conexion->query('SET foreign_key_checks = 0');

        $sqlProducto = "DELETE FROM marca_producto WHERE Id_marca_producto = $id";
        $resultadoProducto = $conexion->query($sqlProducto);

        $conexion->query('SET foreign_key_checks = 1');

        if ($resultadoProducto) {
            echo json_encode(array('mensaje' => 'Marca de producto borrada'));
        } else {
            echo json_encode(array('error' => 'Error al borrar marca de producto: ' . $conexion->error));
        }
    } else {
        echo json_encode(array('error' => 'ID no proporcionado para borrar'));
    }
}

function verificarDatosParaActualizarMarca($dato)
{
    return isset($dato['Id_marca_producto']) || isset($dato['Nom_marca_producto']) || isset($dato['Estado_marca_producto']);
}

function obtenerDatosActuales($conexion, $tabla, $id)
{
    $sqlConsulta = "SELECT * FROM $tabla WHERE Id_$tabla = $id";
    $resultadoConsulta = $conexion->query($sqlConsulta);

    if ($resultadoConsulta && $resultadoConsulta->num_rows > 0) {
        return $resultadoConsulta->fetch_assoc();
    } else {
        return null;
    }
}


// Conexión y funciones para la tabla 'envio'


function consultaDatosEnvio($conexion, $id)
{
    $sql = ($id == null) ? "SELECT * FROM envio" : "SELECT * FROM envio WHERE Id_envio=$id";
    $resultado = $conexion->query($sql);

    if ($resultado) {
        $datos = array();
        while ($fila = $resultado->fetch_assoc()) {
            $datos[] = $fila;
        }
        echo json_encode($datos);
    } else {
        echo json_encode(array('error' => 'Error en la consulta: ' . $conexion->error));
    }
}

function insertarDatosEnvio($conexion)
{
    $dato = json_decode(file_get_contents('php://input'), true);

    if (verificarDatosParaInsertar($dato, ['Id_envio', 'Pk_fk_id_pedido', 'Tipo_envio', 'Nom_transportadora', 'Ciudad_envio', 'Direccion_entrega', 'Valor_envio', 'Fecha_estimada_entrega_pedido'])) {
        $id_existente = $conexion->query("SELECT Id_envio FROM envio WHERE Id_envio = {$dato['Id_envio']}")->fetch_assoc();

        if ($id_existente) {
            echo json_encode(array('error' => 'Error al insertar datos: La clave primaria ya existe'));
        } else {
            $pk_fk_id_pedido = intval($dato['Pk_fk_id_pedido']);
            $tipo_envio = $conexion->real_escape_string($dato['Tipo_envio']);
            $nom_transportadora = $conexion->real_escape_string($dato['Nom_transportadora']);
            $ciudad_envio = $conexion->real_escape_string($dato['Ciudad_envio']);
            $direccion_entrega = $conexion->real_escape_string($dato['Direccion_entrega']);
            $valor_envio = intval($dato['Valor_envio']);
            $fecha_estimada_entrega_pedido = $conexion->real_escape_string($dato['Fecha_estimada_entrega_pedido']);

            $sql = "INSERT INTO envio (Id_envio, Pk_fk_id_pedido, Tipo_envio, Nom_transportadora, Ciudad_envio, Direccion_entrega, Valor_envio, Fecha_estimada_entrega_pedido) VALUES ({$dato['Id_envio']}, $pk_fk_id_pedido, '$tipo_envio', '$nom_transportadora', '$ciudad_envio', '$direccion_entrega', $valor_envio, '$fecha_estimada_entrega_pedido')";
            $resultado = $conexion->query($sql);

            if ($resultado) {
                $id_insertado = $conexion->insert_id;
                echo json_encode(array('id' => $id_insertado));
            } else {
                echo json_encode(array('error' => 'Error al insertar datos: ' . $conexion->error));
            }
        }
    } else {
        echo json_encode(array('error' => 'Datos incompletos o incorrectos para insertar en envio'));
    }
}

function actualizarDatosEnvio($conexion, $id)
{
    $dato = json_decode(file_get_contents('php://input'), true);

    if ($id !== null) {
        $id = $conexion->real_escape_string($id);

        if (verificarDatosParaActualizarEnvio($dato)) {
            $datosActuales = obtenerDatosActuales($conexion, 'envio', $id);

            $pk_fk_id_pedido = isset($dato['Pk_fk_id_pedido']) ? intval($dato['Pk_fk_id_pedido']) : $datosActuales['Pk_fk_id_pedido'];
            $tipo_envio = isset($dato['Tipo_envio']) ? $conexion->real_escape_string($dato['Tipo_envio']) : $datosActuales['Tipo_envio'];
            $nom_transportadora = isset($dato['Nom_transportadora']) ? $conexion->real_escape_string($dato['Nom_transportadora']) : $datosActuales['Nom_transportadora'];
            $ciudad_envio = isset($dato['Ciudad_envio']) ? $conexion->real_escape_string($dato['Ciudad_envio']) : $datosActuales['Ciudad_envio'];
            $direccion_entrega = isset($dato['Direccion_entrega']) ? $conexion->real_escape_string($dato['Direccion_entrega']) : $datosActuales['Direccion_entrega'];
            $valor_envio = isset($dato['Valor_envio']) ? intval($dato['Valor_envio']) : $datosActuales['Valor_envio'];
            $fecha_estimada_entrega_pedido = isset($dato['Fecha_estimada_entrega_pedido']) ? $conexion->real_escape_string($dato['Fecha_estimada_entrega_pedido']) : $datosActuales['Fecha_estimada_entrega_pedido'];

            $sql = "UPDATE envio SET Pk_fk_id_pedido = $pk_fk_id_pedido, Tipo_envio = '$tipo_envio', Nom_transportadora = '$nom_transportadora', Ciudad_envio = '$ciudad_envio', Direccion_entrega = '$direccion_entrega', Valor_envio = $valor_envio, Fecha_estimada_entrega_pedido = '$fecha_estimada_entrega_pedido' WHERE Id_envio = $id";

            $resultado = $conexion->query($sql);

            if ($resultado) {
                echo json_encode(array('mensaje' => 'Datos de envío actualizados'));
            } else {
                echo json_encode(array('error' => 'Error al actualizar datos de envío: ' . $conexion->error));
            }
        } else {
            echo json_encode(array('error' => 'Datos incompletos o incorrectos para actualizar envío'));
        }
    } else {
        echo json_encode(array('error' => 'ID no proporcionado para actualizar envío'));
    }
}

function borrarDatosEnvio($conexion, $id)
{
    if ($id !== null) {
        $id = $conexion->real_escape_string($id);

        $conexion->query('SET foreign_key_checks = 0');

        $sqlProducto = "DELETE FROM envio WHERE Id_envio = $id";
        $resultadoProducto = $conexion->query($sqlProducto);

        $conexion->query('SET foreign_key_checks = 1');

        if ($resultadoProducto) {
            echo json_encode(array('mensaje' => 'Envío borrado'));
        } else {
            echo json_encode(array('error' => 'Error al borrar envío: ' . $conexion->error));
        }
    } else {
        echo json_encode(array('error' => 'ID no proporcionado para borrar'));
    }
}

function verificarDatosParaInsertar($dato, $claves)
{
    foreach ($claves as $clave) {
        if (!isset($dato[$clave])) {
            return false;
        }
    }
    return true;
}

function verificarDatosParaActualizarEnvio($dato)
{
    return isset($dato['Pk_fk_id_pedido']) || isset($dato['Tipo_envio']) || isset($dato['Nom_transportadora']) || isset($dato['Ciudad_envio']) || isset($dato['Direccion_entrega']) || isset($dato['Valor_envio']) || isset($dato['Fecha_estimada_entrega_pedido']);
}
?>


