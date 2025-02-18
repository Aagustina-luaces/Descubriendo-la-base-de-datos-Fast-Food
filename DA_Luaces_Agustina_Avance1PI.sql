USE FastFoodDB;

SELECT name, database_id, create_date
FROM sys.databases
WHERE name = 'FastFoodDB';

--Categorias
CREATE TABLE Categorias (
  CategoriaID INT PRIMARY KEY IDENTITY,
  Nombre VARCHAR(100) NOT NULL
); 


--Productos
CREATE TABLE Productos (
  ProductoID INT PRIMARY KEY IDENTITY,
  Nombre VARCHAR(100) NOT NULL,
  CategoriaID INT,
  Precio DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);


--Sucursales
CREATE TABLE Sucursales (
  SucursalID INT PRIMARY KEY IDENTITY,
  Nombre VARCHAR(100) NOT NULL,
  Direccion VARCHAR(100)
);

--Empleados
CREATE TABLE Empleados (
  EmpleadoID INT PRIMARY KEY IDENTITY,
  Nombre VARCHAR(100) NOT NULL,
  Posicion VARCHAR(100) NOT NULL, 
  Departamento VARCHAR(100) NOT NULL,
  Rol VARCHAR(100) NOT NULL,
  SucursalID INT,
  FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID)
);

--Clientes
CREATE TABLE Clientes (
  ClienteID INT PRIMARY KEY IDENTITY,
  Nombre VARCHAR(100) NOT NULL,
  Direccion VARCHAR(100) NOT NULL,
);

--Origen Orden
CREATE TABLE OrigenesOrden (
  OrigenID INT PRIMARY KEY IDENTITY,
  Descripcion VARCHAR(100) NOT NULL
);

--Tipos Pago
CREATE TABLE TiposPago (
  TipoPagoID INT PRIMARY KEY IDENTITY,
  Descripcion VARCHAR(100) NOT NULL
);


--Mensajeros
CREATE TABLE Mensajeros (
  MensajeroID INT PRIMARY KEY IDENTITY,
  Nombre VARCHAR(100) NOT NULL,
  EsExterno BIT NOT NULL
);


--Ordenes
CREATE TABLE Ordenes (
  OrdenID INT PRIMARY KEY IDENTITY,
  ClienteID INT,
  EmpleadoID INT,
  SucursalID INT,
  MensajeroID INT,
  TipoPagoID INT,
  OrigenID INT,
  HorarioVenta VARCHAR(50) NOT NULL,
  TotalCompra DECIMAL(10,2) NOT NULL,
  KilometrosRecorrer DECIMAL(10,2), --EN CASO DE ENTREGA A DOMICILIO
  FechaDespacho DATETIME, --EN CASO DE ENTREGA A DOMICILIO
  FechaEntrega DATETIME, --EN CASO DE ENTREGA A DOMICILIO
  FechaOrdenTomada DATETIME,
  FechaOrdenLista DATETIME NOT NULL,
  FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
  FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID),
  FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID),
  FOREIGN KEY (MensajeroID) REFERENCES Mensajeros(MensajeroID),
  FOREIGN KEY (TipoPagoID) REFERENCES TiposPago(TipoPagoID),
  FOREIGN KEY (OrigenID) REFERENCES OrigenesOrden(OrigenID),
);


--Detalles Ordenes
CREATE TABLE DetallesOrdenes (
  OrdenID INT,
  ProductoID INT,
  Cantidad INT,
  Precio DECIMAL(10,2),
  PRIMARY KEY (OrdenID,ProductoID),
  FOREIGN KEY (OrdenID) REFERENCES Ordenes(OrdenID),
  FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)

);