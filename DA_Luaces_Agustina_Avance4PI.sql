USE FastFoodDB;

--¿Cómo puedo obtener una lista de todos los productos junto con sus categorías?

SELECT P.Nombre Producto, C.Nombre Categoria
FROM Productos P
INNER JOIN Categorias C ON (P.CategoriaID = C.CategoriaID)

--¿Cómo puedo saber a qué sucursal está asignado cada empleado?

SELECT * FROM Empleados;
SELECT * FROM Sucursales;

SELECT E.Nombre Empleado, S.Nombre Sucursal
FROM Empleados E
INNER JOIN Sucursales S ON (E.SucursalID = S.SucursalID)

--¿Existen productos que no tienen una categoría asignada?

SELECT * FROM Productos;
SELECT * FROM Categorias;

SELECT *
FROM Productos P
LEFT JOIN Categorias C ON (P.CategoriaID = C.CategoriaID)
WHERE C.CategoriaID IS NULL;

--¿Cómo puedo obtener un detalle completo de las órdenes, incluyendo el Nombre del cliente, Nombre del empleado que tomó la orden, y Nombre del mensajero que la entregó?

SELECT O.OrdenID, C.Nombre Cliente, E.Nombre Empleado, M.Nombre Mensajero
FROM Ordenes O
LEFT JOIN Clientes C ON (O.ClienteID = C.ClienteID)
LEFT JOIN Empleados E ON (O.EmpleadoID = E.EmpleadoID)
LEFT JOIN Mensajeros M ON (O.MensajeroID = M.MensajeroID);


--¿Cuántos artículos correspondientes a cada Categoría de Productos se han vendido en cada sucursal?

SELECT S.Nombre Sucursal, C.Nombre CategoriaProducto, SUM(DO.Cantidad) ProductosVendidos
FROM Ordenes O
INNER JOIN DetallesOrdenes DO ON (O.OrdenID = DO.OrdenID)
INNER JOIN Sucursales S ON (O.SucursalID = S.SucursalID)
INNER JOIN Productos P ON (DO.ProductoID = P.ProductoID)
INNER JOIN Categorias C ON (P.CategoriaID = C.CategoriaID)
GROUP BY S.Nombre, C.Nombre
ORDER BY ProductosVendidos DESC;