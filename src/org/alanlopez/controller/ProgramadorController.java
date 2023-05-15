package org.alanlopez.controller;


import java.util.ResourceBundle;
import java.net.URL;
import javafx.fxml.Initializable;
import org.alanlopez.system.Principal;

public class ProgramadorController implements Initializable {
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
    
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
    }
    
    


    

    

   
}
