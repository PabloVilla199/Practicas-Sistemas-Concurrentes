with Casino; use Casino;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure Main is
   G : Generator;

   task type GenerarClientes;

   task body GenerarClientes is
      Nuevo_Cliente : Cliente;
      Id : Integer;
      Saldo : Integer;
      Edad : Integer;
      Vetado : Boolean;
   begin
      Id := Integer(Random(G)*40.0);
      Edad := Integer(Random(G)*38.0) + 5;
      Saldo := Integer(Random(G)*100.0);
      Vetado := False;

      Nuevo_Cliente.Id := Id;
      Nuevo_Cliente.Saldo := Saldo;
      Nuevo_Cliente.Edad := Edad;
      Nuevo_Cliente.Vetado := Vetado;

      Put_Line("Un nuevo cliente  Edad: " & Integer'Image(Edad) & " Saldo: " & Integer'Image(Saldo) & " Intenta acceder al casino");

      Acceso_Casino(Nuevo_Cliente);
      ControlDNI(Nuevo_Cliente);

      if not Nuevo_Cliente.Vetado then
         Juego(Nuevo_Cliente);
         Decision(Nuevo_Cliente);
      else
         Salida(Nuevo_Cliente);
      end if;
      Salida(Nuevo_Cliente);
   end GenerarClientes;


   tareas : array (1..5) of GenerarClientes;
begin
   null;
end Main;
