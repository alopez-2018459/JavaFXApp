/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.alanlopez.system;

import java.io.IOException;
import java.io.InputStream;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;  
import javafx.stage.Stage;
import org.alanlopez.controller.MenuPrincipalController;
import org.alanlopez.controller.ProgramadorController;

/**
 *
 * @author informatica
 */
public class Principal extends Application {
    private final String PAQUETE_VISTA = "/org/alanlopez/view/";
    private Stage escenarioPrincipal;
    private Scene escena;
    // private Scene escena;

    @Override
    public void start(Stage escenarioPrincipal) throws Exception {
        this.escenarioPrincipal = escenarioPrincipal;
        this.escenarioPrincipal.setTitle("Smile Care");
        escenarioPrincipal.getIcons().add(new Image("/org/alanlopez/image/topicon.png"));
        // Parent root =
        // FXMLLoader.load(getClass().getResource("/org/alanlopez/view/ProgramadorView.fxml"));
        // Scene escena = new Scene(root);
        // escenarioPrincipal.setScene(escena);
        menuPrincipal();
        escenarioPrincipal.show();
    }

    public void menuPrincipal() {
        try {
            MenuPrincipalController ventanaMenu = (MenuPrincipalController) cambiarEscena("MenuPrincipalView.fxml", 1082, 627);
            ventanaMenu.setEscenarioPrincipal(this);
        } catch (Exception e) { 
            e.printStackTrace();
        }
    }

    public void ventanaProgramador() {
        try {
            ProgramadorController venProgramador = (ProgramadorController) cambiarEscena("ProgramadorView.fxml", 527, 580);
            venProgramador.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
    }

    public Initializable cambiarEscena(String fxml, int ancho, int alto) throws IOException {

        Initializable resultado = null;
        FXMLLoader cargadorFXML = new FXMLLoader();
        InputStream archivo = Principal.class.getResourceAsStream(PAQUETE_VISTA + fxml);
        cargadorFXML.setBuilderFactory(new JavaFXBuilderFactory());
        cargadorFXML.setLocation(Principal.class.getResource(PAQUETE_VISTA + fxml));
        escena = new Scene((AnchorPane) cargadorFXML.load(archivo), ancho, alto);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();
        resultado = (Initializable) cargadorFXML.getController();
        return resultado;

    }

}
