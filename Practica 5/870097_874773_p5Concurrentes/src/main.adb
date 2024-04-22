with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Numerics.Float_Random;
use  Ada.Numerics.Float_Random;
with Ada.Numerics.Discrete_Random;

procedure Main is
   MaxPasajerosAvion : constant Integer := 30;
   MaxPasajerosSeguridad : constant Integer := 5;
   type estadoVuelo is (Aterrizaje,Despegue);

   -- Generador de numeros aleatorios

   G : Generator;

   -- Tareas
    task type Pasajero is
      entry escogerVuelo(ID : Integer; TerminalID : in Integer; exitoso : out Boolean);
   end Pasajero;

   task type controlSeguridad is
      entry realizarControl(VueloID : in Integer; pasajerosVuelo : in out Integer);
      entry entrarControl(exito : out Boolean);
   end controlSeguridad;


   task type Terminal is
      entry asignarTerminal(TerminalID: out Integer; exitoso : out Boolean);
      entry liberarTerminal(TerminalID: in out Integer);
      entry inicializarTerminal(ID_Terminal : in Integer);
   end Terminal;


   task type Vuelo;

   task type Pista is
      entry asignarPistas(PistaID: out Integer; exitoso : out Boolean);
      entry liberarPistas(PistaID: in out Integer);
      entry inicializarPistas(ID_Pista : in Integer);
   end Pista;

   task generadorVuelos;


   task iniciarPistas;

   task iniciarVuelos is
      entry inicializarVuelo(ID : out Integer; estado : out estadoVuelo);
   end iniciarVuelos;

   task iniciarTerminal;

   type pistaArray is array(1..3) of Pista;
   type pasajerosArray is array(1..400) of Pasajero;
   type punteroVuelo is access Vuelo;
   type terminalArray is array(1..3) of Terminal;
   type controlesArray is array(1..3) of controlSeguridad;

   terminales : terminalArray;
   pistas : pistaArray;
   arrayPasajeros : pasajerosArray;
   controles : controlesArray;
   nuevoVuelo : punteroVuelo;

   numVuelos : Integer := 0;
   numTerminales : Integer := 0;
   numPistas : Integer := 0;
   pasajerosAtendidos : Integer := 1;


   task body iniciarPistas is
   begin
      for I in 1..pistas'Length loop
         numPistas := numPistas + 1;
         pistas(I).inicializarPistas(I);
      end loop;
   end iniciarPistas;

   task body iniciarTerminal is
   begin
      for I in 1..terminales'Length loop
         numTerminales := numTerminales + 1;
         terminales(I).inicializarTerminal(I);
      end loop;
   end iniciarTerminal;

   task body generadorVuelos is
   begin
      loop
         nuevoVuelo := new Vuelo;
         delay(Duration(Random(G) + 8.00));
      end loop;
   end generadorVuelos;

   task body Pasajero is
      exitoPasajero : Boolean := False;
      vueloID : Integer := -1;
      IdTerminal : Integer;
   begin
      loop
         accept escogerVuelo (ID : in Integer; TerminalID : in Integer; exitoso : out Boolean) do
            vueloID := ID;
            IdTerminal := TerminalID;
            exitoso := True;
         end escogerVuelo;

         exit when vueloID /= -1;
      end loop;


      loop
         controles(IdTerminal).entrarControl(exitoPasajero);
         exit when exitoPasajero = True;
      end loop;

   end Pasajero;

   task body controlSeguridad is
      pasajeros : Integer := 0;
   begin
      loop
         select
            when pasajeros > 0 =>
               accept realizarControl(VueloID : in Integer; pasajerosVuelo : in out Integer)  do
                  Put_Line("Pasan " & Integer'Image(pasajeros) & " personas el control del vuelo " & Integer'Image(VueloID) );
                  pasajerosVuelo := pasajerosVuelo + pasajeros;
                  pasajeros := 0;
               end realizarControl;
         or
            when pasajeros < MaxPasajerosSeguridad =>
               accept entrarControl (exito : out Boolean) do
                  pasajeros := pasajeros + 1;
                  exito := True;
               end entrarControl;
         end select;
      end loop;
   end controlSeguridad;

    task body Pista is
         disponible : Boolean := True;
         ID : Integer;
   begin
      loop
         select
            accept inicializarPistas (ID_Pista : in Integer) do
               ID := ID_Pista;
            end inicializarPistas;
         or
            accept asignarPistas(PistaID: out Integer; exitoso : out Boolean) do

               if disponible then

                  PistaID := ID;
                  disponible := False;
                  exitoso := True;
               end if;
            end asignarPistas;

         or
            accept liberarPistas (PistaID : in out Integer) do
               disponible := True;
               PistaID := -1;
            end liberarPistas;

         end select;
      end loop;
   end Pista;

   task body iniciarVuelos is
   begin
      loop
      accept inicializarVuelo (ID : out Integer; estado : out estadoVuelo) do
         numVuelos := numVuelos + 1;
            ID := numVuelos;

            if Integer(Random(G)*2.0) /= 1 then
               estado := Aterrizaje;
            else
               estado := Despegue;
            end if;
            Put_Line("Estado del vuelo: " & estado'Image);
        end inicializarVuelo;
       end loop;
    end iniciarVuelos;

   task body Vuelo is
      ID : Integer;
      estado : estadoVuelo;

      terminal_ID : Integer := -1;
      PistaID : Integer := -1;
      exitoso : Boolean := False;
      pasajeros : Integer := 0;
      pasajerosAvion : Integer := 0;
      i : Integer := 1;

      procedure Buscar_pista(PistaID : in out Integer) is
         exitoso : Boolean := False;
         i : Integer := 1;
      begin
         while exitoso /= True loop
            pistas(i).asignarPistas(PistaID , exitoso);

            if i = pistas'Length then
               i := 1;
            else
               i := i + 1;
            end if;
         end loop;
      end Buscar_pista;

      procedure Buscar_Terminal(terminal_ID : in out Integer) is
         exitoso : Boolean := False;
         i : Integer := 1;

      begin
         loop
            terminales(i).asignarTerminal(terminal_ID, exitoso);

            if exitoso then
               exit;
            end if;

            if i = terminales'Length then
               i := 1;
            else
               i := i + 1;
            end if;
         end loop;
      end Buscar_Terminal;


         Procedure Retardo(tiempo : in Float) is
      begin
         delay(Duration(Random(G) + tiempo));
            end Retardo;
begin
      iniciarVuelos.inicializarVuelo(ID,estado);
      if estado = Aterrizaje then

         Buscar_pista(PistaID);
         Put_Line("Vuelo " & Integer'Image(ID) & " se le ha asignado la pista " & Integer'Image(PistaID) & " para aterrizar");
         Retardo(5.0);

         Buscar_Terminal(terminal_ID);
         pistas(PistaID).liberarPistas(PistaID);

         Put_Line("Los pasajeros del vuelo " & Integer'Image(ID) & " han desembarcado en la terminal " & Integer'Image(terminal_ID));
         Retardo(2.0);

         Put_Line("Se limpia la terminal " & Integer'Image(terminal_ID));
         Retardo(15.0);
         terminales(terminal_ID).liberarTerminal(terminal_ID);

     else
         Buscar_Terminal(terminal_ID);
         Put_Line("Vuelo " & Integer'Image(ID) & " va a despegar y se le ha asignado la terminal " & Integer'Image(terminal_ID) & " para embarcar a sus pasajeros");
         Retardo(5.0);

         for I in pasajerosAtendidos .. pasajerosArray'Length loop
            arrayPasajeros(I).escogerVuelo(ID, terminal_ID, exitoso);

            if exitoso = True then
               pasajeros := pasajeros + 1;
               exitoso := False;
            end if;
            exit when pasajeros = MaxPasajerosAvion;
         end loop;

         pasajerosAtendidos := pasajerosAtendidos + pasajeros;

         Put_Line("Han llegado " & Integer'Image(pasajeros) & " pasajeros 30 min antes a la sala de espera  del vuelo " & Integer'Image(ID));
         Retardo(1.0);
         while pasajerosAvion /= pasajeros loop
            controles(terminal_ID).realizarControl(ID, pasajerosAvion);
         end loop;

         Put_Line("Todos los pasajeros han subido al vuelo " & Integer'Image(ID));

         Buscar_pista(PistaID);
         terminales(terminal_ID).liberarTerminal(terminal_ID);

         Put_Line("Vuelo " & Integer'Image(ID) & " despegara en la pista " & Integer'Image(PistaID));
         Retardo(8.0);
         pistas(PistaID).liberarPistas(PistaID);
     end if;
  end Vuelo;
 task body Terminal is
      ID : Integer := -1;
      disponible : Boolean := True;
      capacidad: Integer := MaxPasajerosAvion;
   begin
      loop
         select

            accept inicializarTerminal (ID_Terminal : in Integer) do
               ID := ID_Terminal;
            end inicializarTerminal;
         or

            accept asignarTerminal (TerminalID : out Integer; exitoso : out Boolean) do

               if disponible and then ID /= -1 then

                  TerminalID := ID;
                  disponible := False;
                  exitoso := True;
               end if;
            end asignarTerminal;

         or
            accept liberarTerminal (TerminalID : in out Integer) do
               disponible := True;
               TerminalID := -1;
            end liberarTerminal;

         end select;
      end loop;
   end Terminal;

begin
  null;
   end Main;
