USE FastFoodDB;

--�Cu�l es el total de ventas (TotalCompra) a nivel global?

SELECT SUM(TotalCompra) Total_Ventas
FROM Ordenes;

--�Cu�l es el precio promedio de los productos dentro de cada categor�a?

SELECT CategoriaID,
  CAST(AVG(Precio) AS DECIMAL(10,2)) 'Precio Promedio'
FROM Productos
GROUP BY CategoriaID
ORDER BY 'Precio promedio' DESC;


--�Cu�l es el valor de la orden m�nima y m�xima por cada sucursal?

SELECT SucursalID,
  MIN(TotalCompra) 'Minimo',
  MAX(TotalCompra) 'Maximo'
FROM Ordenes
GROUP BY SucursalID;

--�Cu�l es el mayor n�mero de kil�metros recorridos para una entrega?

SELECT Top 1 OrdenID, SucursalID, MAX(KilometrosRecorrer) Maximo
FROM Ordenes
GROUP BY OrdenID, SucursalID
ORDER BY Maximo DESC;  

--�Cu�l es la cantidad promedio de productos por orden?

SELECT OrdenID,
  AVG(Cantidad) Promedio_Productos
FROM DetallesOrdenes
GROUP BY OrdenID;

SELECT OrdenID,
  SUM(Cantidad)/COUNT(OrdenID) Promedio_Productos
FROM DetallesOrdenes
GROUP BY OrdenID;

--�C�mo se distribuye la Facturaci�n Total del Negocio de acuerdo a los m�todos de pago?

SELECT TipoPagoID,
  SUM(TotalCompra) Total_Facturacion
FROM Ordenes
GROUP BY TipoPagoID
ORDER BY Total_Facturacion DESC;


--�Cual Sucursal tiene el ingreso promedio m�s alto?

SELECT TOP 1 SucursalID,
  CAST(AVG(TotalCompra) AS DECIMAL(10,2)) Promedio_Venta
FROM Ordenes
GROUP BY SucursalID
ORDER BY Promedio_Venta DESC;


--�Cu�les son las sucursales que han generado ventas totales por encima de $ 1000?

SELECT SucursalID,
  SUM(TotalCompra) Total_Venta
FROM Ordenes
GROUP BY SucursalID
HAVING SUM(TotalCompra) > 1000
ORDER BY SUM(TotalCompra) DESC;


--�C�mo se comparan las ventas promedio antes y despu�s del 1 de julio de 2023?
SET DATEFORMAT ymd;

SELECT CAST(AVG(TotalCompra) AS DECIMAL(10,2)) Venta_Promedio
FROM Ordenes
WHERE FechaEntrega < '2023-07-01';


SELECT CAST(AVG(TotalCompra) AS DECIMAL(10,2)) Venta_Promedio
FROM Ordenes
WHERE FechaEntrega > '2023-07-01';


--�Durante qu� horario del d�a (ma�ana, tarde, noche) se registra la mayor cantidad de ventas, cu�l es el ingreso promedio de estas ventas, y cu�l ha sido el importe m�ximo alcanzado por una orden en dicha jornada?

SELECT HorarioVenta,
  COUNT(*) Cantidad_Ventas,
  CAST(AVG(TotalCompra) AS DECIMAL(10,2)) Venta_Promedio,
  MAX(TotalCompra)Venta_Maxima
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY Venta_Maxima;



