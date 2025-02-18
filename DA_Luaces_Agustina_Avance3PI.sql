USE FastFoodDB;

--¿Cuál es el total de ventas (TotalCompra) a nivel global?

SELECT SUM(TotalCompra) Total_Ventas
FROM Ordenes;

--¿Cuál es el precio promedio de los productos dentro de cada categoría?

SELECT CategoriaID,
  CAST(AVG(Precio) AS DECIMAL(10,2)) 'Precio Promedio'
FROM Productos
GROUP BY CategoriaID
ORDER BY 'Precio promedio' DESC;


--¿Cuál es el valor de la orden mínima y máxima por cada sucursal?

SELECT SucursalID,
  MIN(TotalCompra) 'Minimo',
  MAX(TotalCompra) 'Maximo'
FROM Ordenes
GROUP BY SucursalID;

--¿Cuál es el mayor número de kilómetros recorridos para una entrega?

SELECT Top 1 OrdenID, SucursalID, MAX(KilometrosRecorrer) Maximo
FROM Ordenes
GROUP BY OrdenID, SucursalID
ORDER BY Maximo DESC;  

--¿Cuál es la cantidad promedio de productos por orden?

SELECT OrdenID,
  AVG(Cantidad) Promedio_Productos
FROM DetallesOrdenes
GROUP BY OrdenID;

SELECT OrdenID,
  SUM(Cantidad)/COUNT(OrdenID) Promedio_Productos
FROM DetallesOrdenes
GROUP BY OrdenID;

--¿Cómo se distribuye la Facturación Total del Negocio de acuerdo a los métodos de pago?

SELECT TipoPagoID,
  SUM(TotalCompra) Total_Facturacion
FROM Ordenes
GROUP BY TipoPagoID
ORDER BY Total_Facturacion DESC;


--¿Cual Sucursal tiene el ingreso promedio más alto?

SELECT TOP 1 SucursalID,
  CAST(AVG(TotalCompra) AS DECIMAL(10,2)) Promedio_Venta
FROM Ordenes
GROUP BY SucursalID
ORDER BY Promedio_Venta DESC;


--¿Cuáles son las sucursales que han generado ventas totales por encima de $ 1000?

SELECT SucursalID,
  SUM(TotalCompra) Total_Venta
FROM Ordenes
GROUP BY SucursalID
HAVING SUM(TotalCompra) > 1000
ORDER BY SUM(TotalCompra) DESC;


--¿Cómo se comparan las ventas promedio antes y después del 1 de julio de 2023?
SET DATEFORMAT ymd;

SELECT CAST(AVG(TotalCompra) AS DECIMAL(10,2)) Venta_Promedio
FROM Ordenes
WHERE FechaEntrega < '2023-07-01';


SELECT CAST(AVG(TotalCompra) AS DECIMAL(10,2)) Venta_Promedio
FROM Ordenes
WHERE FechaEntrega > '2023-07-01';


--¿Durante qué horario del día (mañana, tarde, noche) se registra la mayor cantidad de ventas, cuál es el ingreso promedio de estas ventas, y cuál ha sido el importe máximo alcanzado por una orden en dicha jornada?

SELECT HorarioVenta,
  COUNT(*) Cantidad_Ventas,
  CAST(AVG(TotalCompra) AS DECIMAL(10,2)) Venta_Promedio,
  MAX(TotalCompra)Venta_Maxima
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY Venta_Maxima;



