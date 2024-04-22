with Almacen; use Almacen;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure Main is
   G : Generator;
   task type CrearProductos;

   task body CrearProductos is
   Nuevo_Producto : Almacen.Producto;
   peso : Integer;
   Tipo : Integer;

   begin
         peso := Integer(Random(G) * 10.0) + 20;
         Tipo := Integer(Random(G) * 2.0) + 1;
         Nuevo_Producto.identificador := Tipo;
         Nuevo_Producto.Peso := peso;

      Put_Line("Nuevo producto generado: Tipo " & Integer'Image(Tipo) & ", Peso " & Integer'Image(Peso));

      Recepcionar_Package(Nuevo_Producto);
      delay(Duration((Random(G) + 0.5) * 0.1));

      Almacenar_Package(Nuevo_Producto);
      delay(Duration((Random(G) + 0.5) * 0.1));

      Retirar_Package(Nuevo_Producto);

   end CrearProductos;

   tareas : array(1..40) of CrearProductos;

begin
  null;
end Main;
