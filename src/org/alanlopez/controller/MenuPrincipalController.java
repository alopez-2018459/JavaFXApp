
package org.alanlopez.controller;

import java.io.PrintStream;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.layout.AnchorPane;

import org.alanlopez.system.Principal;





public class MenuPrincipalController<Stage> implements Initializable{




    private Principal escenarioPrincipal;

    
    @Override
    
    public void initialize(URL location, ResourceBundle resources) {
        
        
    }


    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
    public void ventanaProgramador(){
        escenarioPrincipal.ventanaProgramador();
    }
    

   
    
    

   
   
}
