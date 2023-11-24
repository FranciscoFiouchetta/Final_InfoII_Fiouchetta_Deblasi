class Puntuacion{
  
  int puntuacion;
  Serial Puerto;
 // BufferedWriter writer;

  Puntuacion(Serial puerto) {
    
    this.Puerto = puerto;
  } 
     /*try {
     writer = new BufferedWriter(new FileWriter("puntuaciones.txt", true));
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
    */
  void actualizarPuntuacion(int puntuacion) {
    
      for (int i = 8; i >= 0; i--) {
        vector[i + 1] = vector[i];
      }
      vector[0] = puntuacion;      
      
     // guardarEnArchivo(puntuacion);
  }
  }
 /* private void guardarEnArchivo(int puntuacion) {
    try {
      writer.write(Integer.toString(puntuacion));
      writer.newLine();
      writer.flush(); // Asegura que los datos se escriban en el archivo
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
  
  void cerrar() {
    try {
      writer.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
*/
}
