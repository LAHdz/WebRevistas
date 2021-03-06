package com.ashdz.webrevistas.DAO.Etiqueta;

import com.ashdz.webrevistas.DAO.CRUD;
import com.ashdz.webrevistas.model.Etiqueta;
import java.sql.ResultSet;

/**
 *
 * @author asael
 */
public interface EtiquetaDAO extends CRUD<Etiqueta>{
    public ResultSet getResultSetEtiqueta();
    public void createEtiqueta(String e);
    public ResultSet getResultSetRev(String s, String email);
    public ResultSet getResultSetRev2(String s, String email);
    public String getEtiquetasByRev(int id);
}
