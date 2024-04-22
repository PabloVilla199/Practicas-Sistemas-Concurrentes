package Almacen is
   CantidadesMax : Integer := 20;

   type Producto is record
      identificador : Integer;
      Peso : Integer;
   end record;

  type Producto_Array is array (0..CantidadesMax) of Producto;
   type Ubicacion is record
      Nombre : String(1..1);
      Peso_Actual : Integer := 0;
      Peso_Max : Integer := 500;
      Cantidad_Max : Integer := 20;
      Cantidad_Actual : Integer := 0;
      Productos : Producto_Array;
   end record;
   type ArrayAlamcen is array (1..3) of Ubicacion;
   protected type Almacen_Protegido is
      entry Recepcionar(Paquete : in Producto);
      entry Almacenar_A(Paquete : in Producto);
      entry Almacenar_B(Paquete : in Producto);
      entry Almacenar_C(Paquete : in Producto);
      procedure Retirar(Paquete : in Producto);

   private
      CantidadesMax : Integer := 20;
      GranAlmacen : ArrayAlamcen;
      ZonaComun : Producto_Array;
      contador: Integer := 0;

   end Almacen_Protegido;
   procedure Recepcionar_Package(Paquete : in Producto);
   procedure Almacenar_Package(Paquete : in Producto);
   procedure Retirar_Package(Paquete : in Producto);

end Almacen;
