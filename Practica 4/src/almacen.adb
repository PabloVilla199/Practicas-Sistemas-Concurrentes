with Ada.Text_IO; use Ada.Text_IO;

package body Almacen is
   protected body Almacen_Protegido is

      entry Recepcionar(Paquete : in Producto) when contador < CantidadesMax is
      begin
         begin
            contador := contador + 1;
            ZonaComun(contador) := Paquete;
	    Put_Line("Se ha recepcionado producto. Tipo: " & Integer'Image(Paquete.identificador) & " Peso: " & Integer'Image(Paquete.peso));
      end;
      end Recepcionar;

      entry Almacenar_A(Paquete : in Producto) when GranAlmacen(1).Peso_Actual < GranAlmacen(1).Peso_Max and then GranAlmacen(1).Cantidad_Actual < GranAlmacen(1).Cantidad_Max is
      begin
         declare
            p : Producto;
         begin
            for i in 1..contador loop
               if ZonaComun(i) = Paquete then
                  p := ZonaComun(i);
                  GranAlmacen(1).Peso_Actual := ZonaComun(i).Peso + GranAlmacen(1).Peso_Actual;
                  GranAlmacen(1).Productos(GranAlmacen(1).Cantidad_Actual) := p;
                  GranAlmacen(1).Cantidad_Actual := GranAlmacen(1).Cantidad_Actual + 1;

                  ZonaComun(i) := ZonaComun(contador -1);
                  contador := contador - 1;
                  Put_Line("Se ha almacenado un producto de tipo " & Integer'Image(Paquete.identificador) & " Cant total: " & Integer'Image(GranAlmacen(1).Cantidad_Actual) & " Peso total: " & Integer'Image(GranAlmacen(1).Peso_Actual));

               end if;
            end loop;
         end;

      end Almacenar_A;

      entry Almacenar_B(Paquete : in Producto) when GranAlmacen(2).Peso_Actual < GranAlmacen(2).Peso_Max and then GranAlmacen(2).Cantidad_Actual < GranAlmacen(2).Cantidad_Max is
      begin
         declare
            p : Producto;
         begin
            for i in 1..contador loop
               if ZonaComun(i) = Paquete then
                  p := ZonaComun(i);
                  GranAlmacen(2).Peso_Actual := ZonaComun(i).Peso + GranAlmacen(2).Peso_Actual;
                  GranAlmacen(2).Productos(GranAlmacen(2).Cantidad_Actual):= p;
                  GranAlmacen(2).Cantidad_Actual := GranAlmacen(2).Cantidad_Actual + 1;

                  ZonaComun(i) := ZonaComun(contador -1);
                  contador := contador - 1;
                  Put_Line("Se ha almacenado un producto de tipo " & Integer'Image(Paquete.identificador) & " Cant total: " & Integer'Image(GranAlmacen(2).Cantidad_Actual) & " Peso total: " & Integer'Image(GranAlmacen(2).Peso_Actual));

               end if;
            end loop;
         end;

      end Almacenar_B;

      entry Almacenar_C(Paquete : in Producto) when GranAlmacen(3).Peso_Actual < GranAlmacen(3).Peso_Max and then GranAlmacen(3).Cantidad_Actual < GranAlmacen(3).Cantidad_Max is
      begin
         declare
            p : Producto;
         begin
            for i in 1..contador loop
               if ZonaComun(i) = Paquete then
                  p := ZonaComun(i);
                  GranAlmacen(3).Peso_Actual := ZonaComun(i).Peso + GranAlmacen(3).Peso_Actual;
                  GranAlmacen(3).Productos(GranAlmacen(3).Cantidad_Actual):= p;
                  GranAlmacen(3).Cantidad_Actual := GranAlmacen(3).Cantidad_Actual + 1;

                  ZonaComun(i) := ZonaComun(contador -1);
                  contador := contador - 1;
                  Put_Line("Se ha almacenado un producto de tipo " & Integer'Image(Paquete.identificador) & " Cant total: " & Integer'Image(GranAlmacen(3).Cantidad_Actual) & " Peso total: " & Integer'Image(GranAlmacen(3).Peso_Actual));

               end if;
            end loop;
         end;
      end Almacenar_C;

      procedure Retirar(Paquete : in Producto) is
       begin
         declare
            p : Producto;
             eleccion : Integer := Paquete.identificador;
         begin
            case Paquete.identificador is
               when 1 =>
                  for i in 1..GranAlmacen(1).Cantidad_Actual loop
                     if(GranAlmacen(1).Productos(i) = Paquete) then

                        GranAlmacen(1).Productos(i) := GranAlmacen(1).Productos(GranAlmacen(1).Cantidad_Actual - 1);
                        GranAlmacen(1).Cantidad_Actual := GranAlmacen(1).Cantidad_Actual - 1;
                        GranAlmacen(2).Peso_Actual := GranAlmacen(1).Peso_Actual - Paquete.Peso;
                        Put_Line("Producto retirado de tipo " & Integer'Image(Paquete.identificador) & " Cant total: " & Integer'Image(GranAlmacen(1).Cantidad_Actual) & " Peso total: " & Integer'Image(GranAlmacen(1).Peso_Actual));


                     end if;
                  end loop;
                when 2 =>
                   for i in 1..GranAlmacen(2).Cantidad_Actual loop
                     if(GranAlmacen(2).Productos(i) = Paquete) then

                        GranAlmacen(2).Productos(i) := GranAlmacen(2).Productos(GranAlmacen(2).Cantidad_Actual - 1);
                        GranAlmacen(2).Cantidad_Actual := GranAlmacen(2).Cantidad_Actual - 1;
                        GranAlmacen(2).Peso_Actual := GranAlmacen(2).Peso_Actual - Paquete.Peso;
                        Put_Line("Producto retirado de tipo " & Integer'Image(Paquete.identificador) & " Cant total: " & Integer'Image(GranAlmacen(2).Cantidad_Actual) & " Peso total: " & Integer'Image(GranAlmacen(2).Peso_Actual));

                     end if;
                  end loop;

                when 3 =>
                  for i in 1..GranAlmacen(3).Cantidad_Actual loop
                     if(GranAlmacen(3).Productos(i) = Paquete) then
                        GranAlmacen(3).Productos(i) := GranAlmacen(3).Productos(GranAlmacen(3).Cantidad_Actual - 1);
                        GranAlmacen(3).Cantidad_Actual := GranAlmacen(3).Cantidad_Actual - 1;
                        GranAlmacen(3).Peso_Actual := GranAlmacen(3).Peso_Actual - Paquete.Peso;
                        Put_Line("Producto retirado de tipo " & Integer'Image(Paquete.identificador) & " Cant total: " & Integer'Image(GranAlmacen(3).Cantidad_Actual) & " Peso total: " & Integer'Image(GranAlmacen(3).Peso_Actual));

                     end if;
                  end loop;
                when others =>
                    null;
              end case;
         end;
     end Retirar;
end Almacen_Protegido;
   almacen1 : Almacen_Protegido;

   procedure Recepcionar_Package(Paquete : in Producto) is
   begin
      almacen1.Recepcionar(Paquete);
   end Recepcionar_Package;

   procedure Almacenar_Package(Paquete : in Producto) is
     begin
         declare
     eleccion : Integer := Paquete.identificador;
   begin
      case Paquete.identificador  is
         when 1 =>
            almacen1.Almacenar_A(Paquete);
         when 2 =>
            almacen1.Almacenar_B(Paquete);
         when 3 =>
            almacen1.Almacenar_C(Paquete);
         when others =>
         null;
      end case;
   end;
  end Almacenar_Package;

   procedure Retirar_Package(Paquete : in Producto) is
   begin
      almacen1.Retirar(Paquete);
end Retirar_Package;
end Almacen;
