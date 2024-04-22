with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.R
with Almacen; use Almacen;

package body Almacen is
   protected body Almacen_Protected is
      entry Recepcionar(Paquete : in Producto; ZonaComun : in out Ubicacion) when ZonaComun.Peso_Actual + Paquete.Peso <= ZonaComun.Peso_Max and ZonaComun.Cantidad_Actual + 1 <= ZonaComun.Cantidad_Max is
      begin
         ZonaComun.Peso_Actual := ZonaComun.Peso_Actual + Paquete.Peso;
         ZonaComun.Cantidad_Actual := ZonaComun.Cantidad_Actual + 1;
         ZonaComun.Productos(ZonaComun.Cantidad_Actual) := Paquete;
      end Recepcionar;

      entry Almacenar(UbicacionEspecifica : in out Ubicacion; ZonaComun : in out Ubicacion) when UbicacionEspecifica.Peso_Actual + ZonaComun.Productos(UbicacionEspecifica.Cantidad_Actual).Peso <= UbicacionEspecifica.Peso_Max and UbicacionEspecifica.Cantidad_Actual + 1 <= UbicacionEspecifica.Cantidad_Max is
      begin
         declare
            random : Integer := Integer'Image(Random(UbicacionEspecifica.Cantidad_Actual) + 1);
            p : Producto;
         begin
            for i in 1..ZonaComun.Cantidad_Actual loop
               if ZonaComun.Productos(i) = ZonaComun.Productos(random) then
                  p := ZonaComun.Productos(i);
                  ZonaComun.Peso_Actual := ZonaComun.Peso_Actual - p.Peso;
                  ZonaComun.Productos(i) :=  ZonaComun.Productos(ZonaComun.Cantidad_Actual);
                  ZonaComun.Cantidad_Actual := ZonaComun.Cantidad_Actual - 1;

                  UbicacionEspecifica.Cantidad_Actual := UbicacionEspecifica.Cantidad_Actual + 1;
                  UbicacionEspecifica.Productos(UbicacionEspecifica.Cantidad_Actual) := p;
                  UbicacionEspecifica.Peso_Actual := UbicacionEspecifica.Peso_Actual + p.Peso;
               end if;
            end loop;
         end;
      end Almacenar;

      entry Retirar(UbicacionEspecifica : in out Ubicacion) when UbicacionEspecifica.Cantidad_Actual > 0 is
      begin
         declare
            random : Integer := Integer'Image(Random(UbicacionEspecifica.Cantidad_Actual) + 1);
            p : Producto;
         begin
            if UbicacionEspecifica.Cantidad_Actual > 0 then
               for i in 1..UbicacionEspecifica.Cantidad_Actual loop
                  if UbicacionEspecifica.Productos(random) = UbicacionEspecifica.Productos(UbicacionEspecifica.Cantidad_Actual) then
                     p := UbicacionEspecifica.Productos(random);
                     UbicacionEspecifica.Productos(random) := UbicacionEspecifica.Productos(UbicacionEspecifica.Cantidad_Actual);
                     UbicacionEspecifica.Cantidad_Actual := UbicacionEspecifica.Cantidad_Actual - 1;
                     UbicacionEspecifica.Peso_Actual := UbicacionEspecifica.Peso_Actual - p.Peso;
                  end if;
               end loop;
            end if;
         end;
      end Retirar;
   end Almacen_Protected;
end Almacen;
