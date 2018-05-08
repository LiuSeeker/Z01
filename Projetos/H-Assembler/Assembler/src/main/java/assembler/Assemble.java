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
import java.util.*;

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
      Parser parse = new parser(inputFile);

      while (parse.advance()){
        if (parse.commandType(parse.command()) == Parser.CommandType.L_COMMAND){ //Verificando se é um comando L
          String add_to_table = parse.label(parse.command()); //Criando string para adicionar à tabela de símbolos
          table.addEntry(add_to_table, parse.instruction_index);
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
        Parser parse = new Parser(inputFile);  // abre o arquivo e aponta para o começo

        while (parse.advance()){
          String instrucao = "0";
          String instrucao_maquina = "";
          String binario = "";
          if (parse.commandType(parse.command()) == Parser.CommandType.A_COMMAND){
              if (table.contains(parser.symbol(parser.command()))){
                  binario = Code.toBinary(String.valueOf(table.getAddress(parse.symbol(parse.command()))));
                  instrucao_maquina = instrucao + binario;
                  outHACK.write(instrucao_maquina);
              }
              else{
                int i = 0;
                while (!table.containsValue(i)){
                  i++;
                }
              }
              else{
                instrucao = "1";
                binario = Code.comp(parse.instruction(parse.command()))+Code.dest(parse.instruction(parse.command()))+Code.jump(parse.instruction(parse.command()));
                instrucao_maquina = instrucao + binario;
                outHACK.write(instrucao_maquina);
              }
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
