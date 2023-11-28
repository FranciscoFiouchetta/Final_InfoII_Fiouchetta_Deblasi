import java.io.FileWriter;

class Puntuacion{
  
  int puntuacion;
  Serial Puerto;

  Puntuacion(Serial puerto) {
    
    this.Puerto = puerto;
  } 
  void actualizarPuntuacion(int puntuacion) {
    
    try{
      FileWriter fw = new FileWriter("C:/Users/admin/OneDrive/Escritorio/proyecto final/puntuaciones.txt");
      
      for (int i = 8; i >= 0; i--) {
        vector[i+1] = vector[i];
      }
      vector[0] = puntuacion;
      
      for (int i = 0; i < 10; i++) {
        fw.write(Integer.toString(vector[i]));
        fw.write("\n");
      }
      
      fw.close();
      
    }catch (IOException e){
      println("Error");
    }
      
  }
}
