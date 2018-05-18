/**
 * Curso: Elementos de Sistemas
 * Arquivo: Assemble.java
 * Created by Luciano <lpsoares@insper.edu.br>
 * Date: 04/02/2017
 *
 * 2018 @ Rafael Corsi
 */

package assembler;

import java.io.*;

/**
 * Faz a geração do código gerenciando os demais módulos
 */
public class Assemble {
    private String inputFile;              // arquivo de entrada nasm
    File hackFile = null;                  // arquivo de saída hack
    private PrintWriter outHACK = null;    // grava saida do código de máquina em Hack
    boolean debug;                         // flag que especifica se mensagens de debug são impressas
    private SymbolTable table;             // tabela de símbolos (variáveis e marcadores)

    /**
     * Retorna o código binário do mnemônico para realizar uma operação de cálculo.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 7 bits) com código em linguagem de máquina para a instrução.
     */
    public Assemble(String inFile, String outFileHack, boolean debug) throws IOException {
        this.debug = debug;
        inputFile  = inFile;
        hackFile   = new File(outFileHack);                      // Cria arquivo de saída .hack
        outHACK    = new PrintWriter(new FileWriter(hackFile));  // Cria saída do print para o arquivo hackfile
        table      = new SymbolTable();                          // Cria e inicializa a tabela de simbolos

    }

    /**
     * primeiro passo para a construção da tabela de símbolos de marcadores (labels)
     * varre o código em busca de Símbolos novos Labels e Endereços de memórias
     * e atualiza a tabela de símbolos com os endereços.
     *
     * Dependencia : Parser, SymbolTable
     */
    public void fillSymbolTable() throws FileNotFoundException, IOException {
      Parser parse = new Parser(inputFile);
      String comando = parse.command();
      int linha = 0;
      int ram = 16;
      
      // 1o Loop
      while (parse.advance()){
        if (parse.commandType(comando) == Parser.CommandType.L_COMMAND){ //Verificando se é um comando Label
          String add_to_table = parse.label(comando); //Criando string para adicionar à tabela de símbolos
          table.addEntry(add_to_table, linha);
        }
        if (parse.commandType(comando) == Parser.CommandType.A_COMMAND || parse.commandType(comando) == Parser.CommandType.C_COMMAND){
			linha++;
			}
      }
      // 2o Loop -aqui pode ter erro
      while (parse.advance()){
          if (parse.commandType(comando) == Parser.CommandType.A_COMMAND){ 
        	  String symbol = parse.symbol(comando);
        	  if (!table.contains(symbol)){
					table.addEntry(symbol, ram);
					ram ++;
				}
          }
      }
    }
      
    /**
     * Segundo passo para a geração do código de máquina
     * Varre o código em busca de instruções do tipo A, C
     * gerando a linguagem de máquina a partir do parse das instruções.
     *
     * Dependencias : Parser, Code
     */
    public void generateMachineCode() throws FileNotFoundException, IOException{
        Parser parse = new Parser(inputFile);
        String instrucao = "0";
        String instrucao_maquina = "";
        String binario = "";

        while (parse.advance()){
        	String comando = parse.command();
        	String symbol = parse.symbol(comando);
        	String bin = Code.toBinary(symbol);
        	String[] mne = parse.instruction(comando);
        	
        	
        	if (parse.commandType(comando) == Parser.CommandType.A_COMMAND){
              if (table.contains(symbol)){
                  binario = Code.toBinary(String.valueOf(table.getAddress(symbol)));
                  instrucao_maquina = instrucao + binario;
                  }
              else{
            	  instrucao_maquina = instrucao + bin;
            	  }
              outHACK.write(instrucao_maquina);
              }
        	else if(parse.commandType(comando) == Parser.CommandType.C_COMMAND){
                instrucao = "1";
                binario = Code.comp(mne) + Code.dest(mne)+Code.jump(mne);
                instrucao_maquina = instrucao + binario;
                outHACK.write(instrucao_maquina);
              }
          }
    } 
    
    /**
     * Fecha arquivo de escrita
     */
    public void close() throws IOException {
        if(outHACK!=null) {
            outHACK.close();
        }
    }

    /**
     * Remove o arquivo de .hack se algum erro for encontrado
     */
    public void delete() {
        try{
            if(hackFile!=null) {
                hackFile.delete();
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

}
