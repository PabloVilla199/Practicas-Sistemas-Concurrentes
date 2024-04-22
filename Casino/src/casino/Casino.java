/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package casino;
import java.util.ArrayList;
import java.util.concurrent.Semaphore;

public class Casino {
    private static int papel = 20;
    private static boolean llamadaTecnico = false;
    private static final int NUM_SLOTS = 3;
    private static final int NUM_CAMAREROS = 3;
    private static Semaphore entrada = new Semaphore(15);
    private static Semaphore mtxDNI = new Semaphore(1);
    private static Semaphore[] slots = new Semaphore[NUM_SLOTS];
    private static Semaphore[] camareros = new Semaphore[NUM_CAMAREROS];
    private static Semaphore rule = new Semaphore(5);
    private static Semaphore mutexBanio = new Semaphore(1);
    private static Semaphore trabajador = new Semaphore(1);
    
       
    public static void main(String[] args) {
    Estadisticas estadisticas = new Estadisticas(0, 0, 0, 0, 0, 0, 0, 0, 0);

        for (int i = 0; i < NUM_SLOTS; i++) {
            slots[i] = new Semaphore(1);
        }
        for (int i = 0; i < NUM_CAMAREROS; i++) {
            camareros[i] = new Semaphore(1);
        }
        Tecnico t1 = new Tecnico();
        t1.start();
        
        ArrayList<Cliente> Clientes = new ArrayList();
        for (int i = 1; i <= 10; i++) {
            Cliente cliente = new Cliente("Cliente" + i, i*5, 250,0,estadisticas,true,0);
            cliente.start();
          Clientes.add(cliente);
        }
        for (Cliente cliente : Clientes) {
        try {
            cliente.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    estadisticas.imprimirEstadisticasGlobales();
    }
    static class Estadisticas {
    private int contadorClientesTotales;
    private int contadorBebidasTotales;
    private int contadorBebidaComidaTotales;
    private int contadorPapelRestanteTotales;
    private int contadorRepuestoTotales;
    private int contadorRuletaGanadaTotales;
    private int contadorRuletaPerdidaTotales;
    private int contadorSlotsPremioTotales;
    private int contadorSlotsSinPremioTotales;

        public Estadisticas(int contadorClientesTotales, int contadorBebidasTotales, int contadorBebidaComidaTotales, int contadorPapelRestanteTotales, int contadorRepuestoTotales, int contadorRuletaGanadaTotales, int contadorRuletaPerdidaTotales, int contadorSlotsPremioTotales, int contadorSlotsSinPremioTotales) {
            this.contadorClientesTotales = contadorClientesTotales;
            this.contadorBebidasTotales = contadorBebidasTotales;
            this.contadorBebidaComidaTotales = contadorBebidaComidaTotales;
            this.contadorPapelRestanteTotales = contadorPapelRestanteTotales;
            this.contadorRepuestoTotales = contadorRepuestoTotales;
            this.contadorRuletaGanadaTotales = contadorRuletaGanadaTotales;
            this.contadorRuletaPerdidaTotales = contadorRuletaPerdidaTotales;
            this.contadorSlotsPremioTotales = contadorSlotsPremioTotales;
            this.contadorSlotsSinPremioTotales = contadorSlotsSinPremioTotales;
        }

        public int getContadorClientesTotales() {
            return contadorClientesTotales;
        }

        public void setContadorClientesTotales(int contadorClientesTotales) {
            this.contadorClientesTotales = contadorClientesTotales;
        }

        public int getContadorBebidasTotales() {
            return contadorBebidasTotales;
        }

        public void setContadorBebidasTotales(int contadorBebidasTotales) {
            this.contadorBebidasTotales = contadorBebidasTotales;
        }

        public int getContadorBebidaComidaTotales() {
            return contadorBebidaComidaTotales;
        }

        public void setContadorBebidaComidaTotales(int contadorBebidaComidaTotales) {
            this.contadorBebidaComidaTotales = contadorBebidaComidaTotales;
        }

        public int getContadorPapelRestanteTotales() {
            return contadorPapelRestanteTotales;
        }

        public void setContadorPapelRestanteTotales(int contadorPapelRestanteTotales) {
            this.contadorPapelRestanteTotales = contadorPapelRestanteTotales;
        }

        public int getContadorRepuestoTotales() {
            return contadorRepuestoTotales;
        }

        public void setContadorRepuestoTotales(int contadorRepuestoTotales) {
            this.contadorRepuestoTotales = contadorRepuestoTotales;
        }

        public int getContadorRuletaGanadaTotales() {
            return contadorRuletaGanadaTotales;
        }

        public void setContadorRuletaGanadaTotales(int contadorRuletaGanadaTotales) {
            this.contadorRuletaGanadaTotales = contadorRuletaGanadaTotales;
        }

        public int getContadorRuletaPerdidaTotales() {
            return contadorRuletaPerdidaTotales;
        }

        public void setContadorRuletaPerdidaTotales(int contadorRuletaPerdidaTotales) {
            this.contadorRuletaPerdidaTotales = contadorRuletaPerdidaTotales;
        }

        public int getContadorSlotsPremioTotales() {
            return contadorSlotsPremioTotales;
        }

        public void setContadorSlotsPremioTotales(int contadorSlotsPremioTotales) {
            this.contadorSlotsPremioTotales = contadorSlotsPremioTotales;
        }

        public int getContadorSlotsSinPremioTotales() {
            return contadorSlotsSinPremioTotales;
        }

        public void setContadorSlotsSinPremioTotales(int contadorSlotsSinPremioTotales) {
            this.contadorSlotsSinPremioTotales = contadorSlotsSinPremioTotales;
        }
        
    public void imprimirEstadisticasGlobales() {
        System.out.println("Numero de clientes que han accedido al casino: " + contadorClientesTotales);
        System.out.println("Numero de bebidas servidas: " + contadorBebidasTotales +
                " Numero de bebidas y comida servidas: " + contadorBebidaComidaTotales);
        System.out.println("Papel restante: " + contadorPapelRestanteTotales +
                " Numero de repuesto de papel: " + contadorRepuestoTotales);
        System.out.println("Numero de aciertos en la ruleta: " + contadorRuletaGanadaTotales +
                " Numero de fallos en la ruleta: " + contadorRuletaPerdidaTotales);
        System.out.println("Numero de combinaciones premiadas en slots: " + contadorSlotsPremioTotales +
                " Numero de combinaciones no premiadas en slots: " + contadorSlotsSinPremioTotales);
    }
    
    public void incrementarContadorClientesTotales() {
        this.contadorClientesTotales++;
    }

    public void incrementarContadorBebidasTotales() {
        this.contadorBebidasTotales++;
    }

    public void incrementarContadorBebidaComidaTotales() {
        this.contadorBebidaComidaTotales++;
    }

    public void incrementarContadorPapelRestanteTotales() {
        this.contadorPapelRestanteTotales++;
    }

    public void incrementarContadorRepuestoTotales() {
        this.contadorRepuestoTotales++;
    }

    public void incrementarContadorRuletaGanadaTotales() {
        this.contadorRuletaGanadaTotales++;
    }

    public void incrementarContadorRuletaPerdidaTotales() {
        this.contadorRuletaPerdidaTotales++;
    }

    public void incrementarContadorSlotsPremioTotales() {
        this.contadorSlotsPremioTotales++;
    }

    public void incrementarContadorSlotsSinPremioTotales() {
        this.contadorSlotsSinPremioTotales++;
    }

    }


    static class Cliente extends Thread {
        private final String nombre;
        private final int edad;
        private int saldo;
        private int consumiciones;
        private Estadisticas estadisticas;
        private boolean estado;
        int salida;

        public Cliente(String nombre, int edad, int saldo, int consumiciones, Estadisticas estadisticas, boolean estado, int salida) {
            this.nombre = nombre;
            this.edad = edad;
            this.saldo = saldo;
            this.consumiciones = consumiciones;
            this.estadisticas = estadisticas;
            this.estado = estado;
            this.salida = salida;
        }
         
        @Override
        public void run() {
            try {
                    // procedure irse cuando condición saldo
                    entrada.acquire();
                    mtxDNI.acquire();
                    comprobarDni(edad,estadisticas,this.estado);
                    mtxDNI.release();
                    while (estado) {
                    // elección aleatoria
                    int salida;
                    int eleccion = (int) (Math.random() * 5) + 1;

                    switch (eleccion) {
                        case 1:
                            if(comprobarSaldo(this.saldo)){
                                for (int i = 0; i < NUM_CAMAREROS; i++) {
                                    if (camareros[i].tryAcquire()) {
                                        System.out.println(nombre + " se dirige a la barra...");
                                        System.out.println("El camarero"+ i +" te atendera enseguida");
                                        pedirBarra(nombre,this.saldo,estadisticas,this.estado);
                                        Thread.sleep(500);
                                        camareros[i].release();
                                        break;
                                    }
                                }
                            }
                            else{
                                this.estado = false;
                                System.out.println(nombre+" has perdido todo en el casino deberias volver con tu familia");
                                System.out.println(nombre+ " no tiene dinero se marcha");
                                entrada.release();
                                
                            
                            }
                            break;

                        case 2:
                            if(comprobarSaldo(this.saldo)){
                                for (int i = 0; i < NUM_SLOTS; i++) {
                                    if (slots[i].tryAcquire()) {
                                        System.out.println(nombre + " juega en el slot " + i + "...");
                                        jugarSlot(nombre,this.saldo,estadisticas);
                                        slots[i].release();
                                        break;
                                    }
                                }
                            }
                            else{
                                this.estado = false;
                                System.out.println(nombre+" has perdido todo en el casino deberias volver con tu familia");
                                System.out.println(nombre+ " no tiene dinero se marcha");
                                entrada.release();
                                
                                 
                            }
                            break;

                        case 3:
                             mutexBanio.tryAcquire();
                            
                            if(comprobarPapel()){
                                System.out.println(nombre + " va al baño...");
                                irBanio(estadisticas);
                                Thread.sleep(1000);
                               }
                               else {
                                if(!llamadaTecnico){
                                    System.out.println(nombre + " llama al técnico porque no hay papel.");
                                    llamadaTecnico = true;
                                    trabajador.acquire();
                                    estadisticas.incrementarContadorRepuestoTotales();
                                    estadisticas.contadorPapelRestanteTotales = papel;
                                }
                            }
                            mutexBanio.release();

                        case 4:
                            if(comprobarSaldo(this.saldo)){
                                rule.tryAcquire();
                                System.out.println(nombre + " juega en la ruleta...");
                                Thread.sleep(1000);
                                jugarRuleta(nombre,this.saldo,estadisticas);
                                Thread.sleep(1000);
                                rule.release();
                            }
                            else{
                              this.estado = false;
                              System.out.println(nombre+" has perdido todo en el casino deberias volver con tu familia");
                              System.out.println(nombre+ " no tiene dinero se marcha");
                              entrada.release();
                              
                            }
                            break;
                        
                        case 5:
                                if(this.salida == 10){
                                   this.estado = false;
                                   System.out.println(nombre + " ha molestado al personal entrando y saliendo todo el rato asi que es expulsado");
                                   entrada.release();
                                }else{
                                    this.salida++;
                                    System.out.println(nombre + " decide salir del casino, y ha salido " + this.salida + " veces, recuerde que si sale mas de 10 veces sera expulsado");
                                    entrada.release();
                                    
                                }
                                break;
                    }
                }
            
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        private void jugarRuleta(String nombre, int saldo, Estadisticas estadisticas){
            int num_elegido =  0;
            int apuesta = 0; 
            int num_aleatorio = 0;
            boolean salir_ruleta = false;
            int salir = 0;
            int premio = 0;
            int cuotaPremio = 20;
       
            // vector de numeros a los q se puede apostar
            while(!salir_ruleta){
                
                num_elegido = (int) (Math.random() * 20) + 1;
                num_aleatorio = (int) (Math.random() * 20) + 1;
                apuesta = (int) (Math.random() * ((this.saldo*20)/100)) + 1;
                premio = apuesta * cuotaPremio;
            
                System.out.println(nombre + " va a jugar a la ruleta con "+ this.saldo+ " €");
                System.out.println(nombre + " apuesta al " + num_elegido + " con " + apuesta + "€");
                System.out.println("El numero que ha salido en la ruleta ha sido " + num_aleatorio);
            
                if(num_aleatorio == num_elegido){
                    this.saldo = (this.saldo - apuesta) + premio;
                    System.out.println(nombre + " ha ganado y lleva un saldo de "+ this.saldo+ "€");
                    estadisticas.incrementarContadorRuletaGanadaTotales();
                    
                }
                 else{
                    this.saldo = this.saldo - apuesta;
                    System.out.println( nombre +" ha perdido y lleva un saldo de "+ this.saldo+ "€");
                    estadisticas.incrementarContadorRuletaPerdidaTotales();

                }
                salir = (int) (Math.random() * 5) + 1;
                
                if((salir  == 2) || ((this.saldo <= 0) || (this.saldo >= 1000))){
                    salir_ruleta = true;
                    System.out.println(nombre+" se va de la ruleta");
                    break;
                  
                }          
            }
        }
        private void comprobarDni(int edad,Estadisticas estadisticas,boolean estado) throws InterruptedException {
    
            System.out.println(nombre + " muestra su DNI y espera...");
            Thread.sleep(500); 
            if (edad <= 18) {
                System.out.println(nombre + " es menor de edad. Se ha llamado a la policía.");
                System.out.println("Menor de edad intentó acceder al casino. Llamada a la policía.");
                this.estado = false;
                mtxDNI.release();
                entrada.release();
                
            } 
            else {
                System.out.println(nombre + " tiene acceso al casino.");
                estadisticas.incrementarContadorClientesTotales();
            }
       }
 private void irBanio(Estadisticas estadisticas) throws InterruptedException {
    int eleccion = 0;

    synchronized (Casino.class) {
        if (papel > 0) {
            eleccion = (int) (Math.random() * 4);
            if (eleccion == 1) {
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                papel = papel - 2;
                System.out.println(nombre +" esta en  el baño queda  "+ papel+" papel");
            } else {
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                papel = papel - 1;
                System.out.println(nombre +" esta en el baño queda  "+ papel+" papel");
            }
        } 
    }
}

        private void jugarSlot(String nombre, int saldo, Estadisticas estadisticas){
           
            int combinacion = 0;
            int apuesta = 0; 
            int premio = 0;
            int cuotaPremio = 0;
            boolean salir_slot = false;
            int salir = 0;
            
            while(!salir_slot){
              combinacion = (int) (Math.random() * 20) + 1;
              apuesta = (int) (Math.random() * ((this.saldo*20)/100)) + 1;
              
              System.out.println(nombre + " va a jugar a las slot con un saldo de " + this.saldo + "€");
              System.out.println(nombre  + " va a jugar con apuestas de " + apuesta + "€");
              System.out.println("Ha tocado la combinacion " + combinacion);
               
              switch (combinacion) {
                    case 4:
                        cuotaPremio = 3;
                        premio = cuotaPremio * apuesta;
                        this.saldo = (this.saldo - apuesta) + premio;
                        System.out.println("La combinacion ganadora es la " + combinacion + " y el premio es de " + premio + "€");
                        estadisticas.incrementarContadorSlotsPremioTotales();
                        break;
                        
                    case 2:
                        cuotaPremio = 2;
                        premio = cuotaPremio * apuesta;
                        this.saldo = (this.saldo - apuesta) + premio;
                        System.out.println("La combinacion ganadora es la " + combinacion + " y el premio es de " + premio + "€");
                        estadisticas.incrementarContadorSlotsPremioTotales();
                        break;
                        
                    case 12:
                        cuotaPremio = 5;
                        premio = cuotaPremio * apuesta;
                        this.saldo = (this.saldo - apuesta) + premio;
                        System.out.println("La combinacion ganadora es la " + combinacion + " y el premio es de " + premio + "€");
                        estadisticas.incrementarContadorSlotsPremioTotales();
                        break;
                        
                    case 15:
                        cuotaPremio = 20;
                        premio = cuotaPremio * apuesta;
                        this.saldo = (this.saldo - apuesta) + premio;
                        System.out.println("La combinacion ganadora es la " + combinacion + " y el premio es de " + premio + "€");
                       estadisticas.incrementarContadorSlotsPremioTotales();
                        break;
                        
                    case 7:
                        cuotaPremio = 10;
                        premio = cuotaPremio * apuesta;
                        this.saldo = (this.saldo - apuesta) + premio;
                        System.out.println("La combinacion ganadora es la " + combinacion + " y el premio es de " + premio + "€");
                        estadisticas.incrementarContadorSlotsPremioTotales();
                        break;
                        
                    default:
                        this.saldo = this.saldo - apuesta;
                        System.out.println("La combinacion " + combinacion + " no tiene ningun premio");
                        estadisticas.incrementarContadorSlotsSinPremioTotales();
                        break;
              }
              salir = (int) (Math.random() * 5) + 1;
                
              if((salir  == 5)||(this.saldo <= 0 || this.saldo >= 1000)){
                    salir_slot = true;
                    System.out.println(nombre+"se marcha de la slot");
                    break;
              }
            }
        }
        private boolean comprobarSaldo( int saldo){
           if(this.saldo <= 0){
               return false;
           }
           return true;
        }
        private void pedirBarra(String nombre,int saldo,Estadisticas estadisticas, boolean estado) throws InterruptedException{
            int eleccion = 0;
            
            System.out.println(nombre+", El camarero te esta atendiendo");
            if(consumiciones == 3){
                System.out.println("Esta muy borracho ya no puedo servirle mas, abandone el casino");
                System.out.println(nombre + " es expulsado del casino por intentar beber mas de lo permitido");
                System.out.println("El camarero se marcha a servir a otro cliente");
                this.estado = false;
                entrada.release();
            }else{
            System.out.println("Tienes dos elecciones: 1 solo bebida 2€ 2 comida + bebida 5€");
            
            eleccion =  (int) (Math.random() * 2);
            if(eleccion == 1){
                System.out.println(nombre + " el camarero le servira solo una bebida");
                this.saldo = (this.saldo - 2);
                consumiciones++;
                estadisticas.incrementarContadorBebidasTotales();
            }
            else{
                System.out.println(nombre + " el camarero le servira bebida y comida");
                this.saldo = this.saldo - 5;
                consumiciones++;
                estadisticas.incrementarContadorBebidaComidaTotales();

            }
            System.out.println("El camarero se marcha a servir a otro cliente");
            System.out.println(nombre+" se toma su consumicion, le quedan " + this.saldo + "€ y lleva " + consumiciones + " consumiciones");
            }
        
        }
        private boolean comprobarPapel(){
            return (papel <= 0);
        }
        
       }
    static class Tecnico extends Thread {
    @Override
    public void run() {
        while ( entrada.availablePermits()!= 15) {
            try {
                // Esperar a ser llamado
                trabajador.acquire();
                
                // Rellenar papel
                System.out.println("El técnico está rellenando el papel...");
                Thread.sleep((long) (Math.random() * 2000) + 1000);

                // Entrar al baño para rellenar papel
                mutexBanio.acquire();
                papel = 7;  // Rellenar el papel
                mutexBanio.release();

                // Reiniciar la bandera de llamada al técnico
                llamadaTecnico = false;

             
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

        }
    }
    }
}