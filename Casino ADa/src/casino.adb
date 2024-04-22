with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

package body Casino is
   G : Generator; 
   contador : Integer := 0;
   Frecuentador : Cliente;
   protected body Casino_Protegido is 
      
      entry Acceder_Casino(Frecuentador : in Cliente) when contador < CantidadMax is 
      begin 
         contador := contador + 1;
         Clientes(contador) := Frecuentador;
         Put_Line("Acaba de llegar el cliente con ID " & Integer'Image(Frecuentador.ID));
      end Acceder_Casino;
      
      entry Dar_Dni(Frecuentador : in Cliente) when contador > 0 is
      begin
         if contador > 0 then
            Put_Line("Mostrando el DNI del cliente con ID " & Integer'Image(Frecuentador.Id));
         end if;
      end Dar_Dni;

      entry Mostrar_Dni(Frecuentador : in Cliente) when contador > 0 is 
      begin 
         if Frecuentador.Edad > 18 then 
            Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " puede acceder al casino");
         else
            Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " no puede acceder al casino. Es menor de 18 años.");
            for I in Clientes'Range loop
         if Clientes(I).Id = Frecuentador.Id then
                  Clientes(I).Vetado := True;
                  exit;
            exit;
         end if;
      end loop;
   end if;
end Mostrar_Dni;
      
      entry Acceder_Slot(Frecuentador : in Cliente) when contador > 0 and not Frecuentador.Vetado is 
      begin
         if not Frecuentador.Vetado then 
          if contador > 0 then
            for I in Slots'Range loop
               if not Slots(I).Ocupado then
                  Slots(I).Ocupado := True;
                  Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " se ha sentado en la slot" & Integer'Image(I));
                  exit;
               end if;
            end loop;
           end if;
         end if;
         
      end Acceder_Slot;
      
     procedure Decision_Salida(Frecuentador : in Cliente) is 
   eleccion : Integer;
begin 
   eleccion := Integer(Random(G)*3.0);
   if eleccion = 1 then 
      for I in Clientes'Range loop
         if Clientes(I).Id = Frecuentador.Id then
            Clientes(I).Vetado := True;
            exit;
         end if;
      end loop;
   end if;
end Decision_Salida;


      entry Salir_Slot(Frecuentador : in Cliente; NumSlot : in Integer) when contador > 0 is
         Decision : Integer;
      begin
         if contador > 0 then
            for I in Slots'Range loop
               if Slots(I).Ocupado and Slots(I).Id = NumSlot then
                     Decision := Integer(Random(G)* 2.0);
                  begin
                     if Decision = 1 then
                        Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " decide seguir jugando en la slot" & Integer'Image(I));
                     else
                        Slots(I).Ocupado := False;
                        Put_Line("El cliente " & Integer'Image(Frecuentador.Id) & " deja la slot y la libera.");
                     end if;
                  end;
                  exit;
               end if;
            end loop;
         end if;
      end Salir_Slot;
      
      entry Acceder_Ruleta(Frecuentador : in Cliente) when contador > 0 and  not Frecuentador.Vetado  is 
      begin
         if not Frecuentador.Vetado then 
         if contador > 0 then
            for I in Ruleta'Range loop
               if not Ruleta(I).Ocupado then
                  Ruleta(I).Ocupado := True;
                  Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " se ha sentado en el asiento" & Integer'Image(I) & "de la ruleta");
                  exit;
               end if;
            end loop;
           end if;
         end if;
      end Acceder_Ruleta;
         
      entry Salir_Ruleta(Frecuentador : in Cliente; NumAsiento: in Integer) when contador > 0 is
         Decision : Integer;
      begin
         if contador > 0 then
            for I in Ruleta'Range loop
               if Ruleta(I).Ocupado and Ruleta(I).Id = NumAsiento then
                  Decision := Integer(Random(G)* 2.0);
                  begin
                     if Decision = 1 then
                       Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " decide seguir jugando en la ruleta");
                     else
                       Ruleta(I).Ocupado := False;
                       Put_Line("El cliente " & Integer'Image(Frecuentador.Id) & " deja la ruleta y la libera.");
                     end if;
                  end;
                  exit;
               end if;
            end loop;
         end if;
      end Salir_Ruleta;
         
      entry Salir(Frecuentador : in out Cliente) when Frecuentador.Vetado is
      begin
        if Frecuentador.Vetado then 
         for I in 1..contador loop 
            if Frecuentador.Id = Clientes(I).Id then 
               Clientes(I) := Clientes(contador - 1);
               contador := contador - 1;  
               Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " ha salido del casino.");
            end if;
         end loop;
        end if;
      end Salir;
      
procedure JugarRuleta(Frecuentador: in out Cliente) is
   num_elegido: Integer := 0;
   num_aleatorio: Integer := 0;
   cuotaPremio: Integer := 35;
   apuesta: Integer := 0;
   premio: Integer := 0;
   irse: Boolean := False;
begin
   while not irse loop
      num_elegido := Integer(Random(G) * 6.0) + 1;
      num_aleatorio := Integer(Random(G) * 6.0) + 1;
      apuesta := Integer(Random(G) * 20.0) + 1;
      premio := apuesta * cuotaPremio;

      Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " va a jugar a la ruleta");

      Put_Line("El numero que ha salido en la ruleta ha sido el " & Integer'Image(num_aleatorio));

      if num_aleatorio = num_elegido then
         Frecuentador.Saldo := (Frecuentador.Saldo - apuesta) + premio;
         Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " ha ganado en la ruleta y su saldo actual es " & Integer'Image(Frecuentador.Saldo));
      else
         Frecuentador.Saldo := Frecuentador.Saldo - apuesta;
         Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " ha perdido en la ruleta y su saldo actual es " & Integer'Image(Frecuentador.Saldo));
      end if;

      if num_aleatorio = 1 then
         irse := True;
      end if;
   end loop;
end JugarRuleta;

procedure JugarSlots(Frecuentador: in out Cliente) is
   combinacion: Integer := 0;
   apuesta: Integer := 0;
   premio: Integer := 0;
   cuotaPremio: Integer := 0;
   salir: Boolean := False;
begin
   while not salir loop
      combinacion := Integer(Random(G) * 20.0);
      apuesta := Integer(Random(G) * 20.0);



      Put_Line("Ha tocado la combinacion " & Integer'Image(combinacion));

      case combinacion is
         when 4 =>
            cuotaPremio := 3;
            premio := cuotaPremio * apuesta;
            Frecuentador.Saldo := (Frecuentador.Saldo - apuesta) + premio;
            Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " ha ganado en la slot y su saldo actual es " & Integer'Image(Frecuentador.Saldo));


         when 2 =>
            cuotaPremio := 2;
            premio := cuotaPremio * apuesta;
            Frecuentador.Saldo := (Frecuentador.Saldo - apuesta) + premio;
            Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " ha ganado en la slot y su saldo actual es " & Integer'Image(Frecuentador.Saldo));

         when 12 =>
            cuotaPremio := 5;
            premio := cuotaPremio * apuesta;
            Frecuentador.Saldo := (Frecuentador.Saldo - apuesta) + premio;
            Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " ha ganado en la slot y su saldo actual es " & Integer'Image(Frecuentador.Saldo));

         when 15 =>
            cuotaPremio := 20;
            premio := cuotaPremio * apuesta;
            Frecuentador.Saldo := (Frecuentador.Saldo - apuesta) + premio;
            Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " ha ganado en la slot y su saldo actual es " & Integer'Image(Frecuentador.Saldo));

         when 7 =>
            cuotaPremio := 10;
            premio := cuotaPremio * apuesta;
            Frecuentador.Saldo := (Frecuentador.Saldo - apuesta) + premio;
            Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " ha ganado en la slot y su saldo actual es " & Integer'Image(Frecuentador.Saldo));

         when 5 =>
            salir := True;

         when others =>
            Frecuentador.Saldo := Frecuentador.Saldo - apuesta;
            Put_Line("El cliente" & Integer'Image(Frecuentador.Id) & " ha perdido en la slot y su saldo actual es " & Integer'Image(Frecuentador.Saldo));
      end case;
   end loop;
      end JugarSlots;
   function ComprobarSaldo(Frecuentador : in Cliente) return Boolean  is
   begin
      if Frecuentador.Saldo <= 0 then
         return false;
      end if;
         return true;
   end ComprobarSaldo;
     
   end Casino_Protegido;
   
   Casino1 : Casino_Protegido;
   NumAsiento :Integer;
   NumSlot : Integer;   
   Procedure Acceso_Casino(Frecuentador : in Cliente) is 
   begin  
      Casino1.Acceder_Casino(Frecuentador);
   end Acceso_Casino;
   
   Procedure ControlDNI(Frecuentador : in Cliente) is 
   begin 
      Casino1.Dar_Dni(Frecuentador);
      Casino1.Mostrar_Dni(Frecuentador);
   end ControlDNI;
   
   Procedure Juego(Frecuentador : in Cliente) is 
      eleccion : Integer;
       Frecuent : Cliente;

       begin 
       Frecuent := Frecuentador;
      eleccion := Integer(Random(G)*2.0);
      if Frecuentador.Saldo > 0  then
      case eleccion is 
         when 1 =>
            Casino1.Acceder_Ruleta(Frecuentador);
            Casino1.JugarRuleta(Frecuent);
            Casino1.Salir_Ruleta(Frecuentador,NumAsiento); 
         when 2 =>
            Casino1.Acceder_Slot(Frecuentador);
            Casino1.JugarSlots(Frecuent);
            Casino1.Salir_Slot(Frecuentador,NumSlot);
         when others =>
            null;
         end case;
      else
         Casino.Salida(Frecuent);
      end if;
   end Juego;
   
   Procedure Decision(Frecuentador : in Cliente) is 
   begin 
      Casino1.Decision_Salida(Frecuentador);
   end Decision;
   
   Procedure Salida(Frecuentador : in out  Cliente) is 
   begin 
      Casino1.Salir(Frecuentador);
      
   end Salida;

   
end Casino;
