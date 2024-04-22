/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package practica3_ada;

import java.util.concurrent.Semaphore;


/**
 *
 * @author Alvaro
 */
public class Practica3_ada {
    static final int Num_Atracciones = 3;
    static final int Capacidad = 5;
    static Semaphore Vendedor = new Semaphore(1);
    static Semaphore[] Operador = new Semaphore[Num_Atracciones];
    static Semaphore[] Atracciones = new Semaphore[Num_Atracciones];
    static Semaphore Salir = new Semaphore(1);
    
    public static void main(String[] args) {
        for(int i = 0; i < Num_Atracciones;i++){
            Operador[i] = new Semaphore(1);
            Atracciones[i] = new Semaphore(Capacidad);     
        }
        Pasajeros pasajero1 = new Pasajeros("Juan");
        Pasajeros pasajero2 = new Pasajeros("Pablo");
        Pasajeros pasajero3 = new Pasajeros("David");
        Pasajeros pasajero4 = new Pasajeros("Jose");
        Pasajeros pasajero5 = new Pasajeros("Javi");
        
        pasajero1.start();
        pasajero2.start();
        pasajero3.start();
        pasajero4.start();
        pasajero5.start();
}
    static class Pasajeros extends Thread{
        private final String nombre;
    public Pasajeros(String nombre){
        this.nombre = nombre;  
        }
        @Override
    public void run(){
        System.out.println("El pasajero " + nombre + " ha llegado al parque");
        System.out.println(" ");
        int tEspera = (int) (Math.random() * 3000) + 2000;
        boolean salir = false;
            try {
                while(!salir){
                      Vendedor.acquire();
                      int elegirAtraccion = (int) (Math.random() * Num_Atracciones);
                      System.out.println("El pasajero " + nombre + " ha elegido la atraccion " + elegirAtraccion);
                      System.out.println(" ");
                      Vendedor.release();
                      Operador[elegirAtraccion].acquire();
                      Atracciones[elegirAtraccion].acquire();
                      System.out.println("El pasajero " + nombre + " va a subir a la atracción");
                      System.out.println(" ");
                      Operador[elegirAtraccion].release();
                      System.out.println("El pasajero " + nombre + " esta viajando en la atraccion " + elegirAtraccion);
                      System.out.println(" ");
                      Thread.sleep(tEspera);
                      Operador[elegirAtraccion].acquire();
                      System.out.println("El viaje ha terminado y el pasajero " + nombre + " esta bajando de la atraccion " + elegirAtraccion);
                       System.out.println(" ");
                      Operador[elegirAtraccion].release();
                      Atracciones[elegirAtraccion].release();
                      int salirParque = (int) (Math.random() * 3) + 1; 
                      if(salirParque == 1){
                        salir = true;
                      }else{
                          salir = false;
                      }
                      if (salir) {
                        Salir.acquire();
                          System.out.println(" ");
                        System.out.println("El pasajero " + nombre + " ha abandonado el parque");
                          System.out.println(" ");
                        Salir.release();
                      }
                }
            } catch (InterruptedException ex) {
                ex.printStackTrace();
            }
    }
    }
}