/**
 * Curso: Elementos de Sistemas
 * Arquivo: SymbolTable.java
 */

package assembler;

import java.util.Hashtable;
import java.util.Set;

/**
 * Mantém uma tabela com a correspondência entre os rótulos simbólicos e endereços numéricos de memória.
 */
public class SymbolTable {

    /**
     * Cria a tabela de símbolos.
     */
	
	private Hashtable<String, Integer> tabela = new Hashtable<String, Integer>();
	
    public SymbolTable() {
    	
    	//Endereçando de R0-R15
    	tabela.put("R0", 0);
    	tabela.put("R1", 1);
    	tabela.put("R2", 2);
    	tabela.put("R3", 3);
    	tabela.put("R4", 4);
    	tabela.put("R5", 5);
    	tabela.put("R6", 6);
    	tabela.put("R7", 7);
    	tabela.put("R8", 8);
    	tabela.put("R9", 9);
    	tabela.put("R10", 10);
    	tabela.put("R11", 11);
    	tabela.put("R12", 12);
    	tabela.put("R13", 13);
    	tabela.put("R14", 14);
    	tabela.put("R15", 15);
    	
    	//Endereçando Restante da Tabela
    	tabela.put("SP", 0);
    	tabela.put("LCL", 1);
    	tabela.put("ARG", 2);
    	tabela.put("THIS", 3);
    	tabela.put("THAT", 4);
    	tabela.put("SCREEN", 16384);
    	tabela.put("LED", 21184);
    	tabela.put("SW", 21185);
    }

    /**
     * Insere uma entrada de um símbolo com seu endereço numérico na tabela de símbolos.
     * @param  symbol símbolo a ser armazenado na tabela de símbolos.
     * @param  address símbolo a ser armazenado na tabela de símbolos.
     */
    public void addEntry(String symbol, int address) {
    	tabela.put(symbol, address);
    }
    
    /**
     * Confere se o símbolo informado já foi inserido na tabela de símbolos.
     * @param  symbol símbolo a ser procurado na tabela de símbolos.
     * @return Verdadeiro se símbolo está na tabela de símbolos, Falso se não está na tabela de símbolos.
     */
    public Boolean contains(String symbol) {
    	boolean contem = false;
    	
    	Set<String> chaves = tabela.keySet();
        for(String chave: chaves){
            if (chave.equals(symbol)){
            	contem = true;
            }
        }
    	
    	return contem;
    }

    /**
     * Retorna o valor númerico associado a um símbolo já inserido na tabela de símbolos.
     * @param  symbol símbolo a ser procurado na tabela de símbolos.
     * @return valor numérico associado ao símbolo procurado.
     */
    public Integer getAddress(String symbol) {
    	return (int)(tabela.get(symbol));
    }

}
