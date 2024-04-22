package Casino is

   CantidadMax : Integer := 20;
   
   type Cliente is record 
      Id : Integer;
      Saldo : Integer;
      Edad : Integer;
      Vetado : Boolean := False;
   end record;
   type ClientesArray is array (0..CantidadMax) of  Cliente;
   
   type Slot is record 
      Id : Integer;
      Ocupado : Boolean;
   end record; 
   type SlotsArray is array (1..3) of Slot;
   
   type Asiento_Ruleta is record
      ID : Integer;
      Ocupado : Boolean;
   end record;
   type RuletaArray is array (1..5) of Asiento_Ruleta;
   
      
      
      
      protected type Casino_Protegido is 
      entry Acceder_Casino(Frecuentador : in Cliente);
      entry Dar_Dni(Frecuentador : in Cliente);
      entry Acceder_Slot(Frecuentador : in Cliente);
      entry Salir_Slot(Frecuentador : in Cliente; NumSlot : in Integer);
      entry Mostrar_Dni(Frecuentador : in Cliente);
      entry Acceder_Ruleta(Frecuentador : in Cliente);
      entry Salir_Ruleta(Frecuentador : in Cliente; NumAsiento: in Integer);
      procedure Decision_Salida(Frecuentador : in Cliente);
      entry Salir(Frecuentador : in out Cliente);
      procedure JugarRuleta(Frecuentador : in out Cliente);
      procedure JugarSlots(Frecuentador : in out  Cliente);
      function ComprobarSaldo(Frecuentador : in Cliente) return Boolean;
      
   private 
      CantidadMax : Integer := 20;
      Clientes : ClientesArray;
      Slots : SlotsArray;
      Ruleta : RuletaArray;
   end Casino_Protegido; 
   
     Procedure Acceso_Casino(Frecuentador : in Cliente); 
     Procedure ControlDNI(Frecuentador : in Cliente);
     Procedure Juego(Frecuentador : in Cliente); 
     Procedure Decision (Frecuentador : in Cliente);
     Procedure Salida(Frecuentador : in out  Cliente);
end Casino;
