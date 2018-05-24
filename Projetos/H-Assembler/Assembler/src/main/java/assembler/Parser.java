/**
 * Curso: Elementos de Sistemas
 * Arquivo: Parser.java
 */
package assembler;

import java.io.FileNotFoundException;
import java.util.Scanner;
import java.io.File;

/**
 * Encapsula o cÃƒÂ³digo de leitura. Carrega as instruÃƒÂ§ÃƒÂµes na linguagem assembly,
 * analisa, e oferece acesso as partes da instruÃƒÂ§ÃƒÂ£o  (campos e sÃƒÂ­mbolos).
 * AlÃƒÂ©m disso, remove todos os espaÃƒÂ§os em branco e comentÃƒÂ¡rios.
 */
public class Parser {
	Scanner scan;
	String line;

	/** Enumerator para os tipos de comandos do Assembler. */
	public enum CommandType {
		A_COMMAND,      // comandos LEA, que armazenam no registrador A
		C_COMMAND,      // comandos de calculos
		L_COMMAND       // comandos de Label (sÃƒÂ­mbolos)
	}
	/**
	 * Abre o arquivo de entrada NASM e se prepara para analisÃƒÂ¡-lo.
	 * @param file arquivo NASM que serÃƒÂ¡ feito o parser.
	 */
	public Parser(String file) {

		try {
			File data = new File(file);
			this.scan = new Scanner(data);
		}
		catch (FileNotFoundException e) {
			System.out.println("File not found - Error");
			e.printStackTrace(); // diz qual foi o erro que ocorreu
		}
	}

	/**
	 * Carrega uma instruÃƒÂ§ÃƒÂ£o e avanÃƒÂ§a seu apontador interno para o prÃƒÂ³xima
	 * linha do arquivo de entrada. Caso nÃƒÂ£o haja mais linhas no arquivo de
	 * entrada o mÃƒÂ©todo retorna "Falso", senÃƒÂ£o retorna "Verdadeiro".
	 * @return Verdadeiro se ainda hÃƒÂ¡ instruÃƒÂ§ÃƒÂµes, Falso se as instruÃƒÂ§ÃƒÂµes terminaram.
	 */
	public Boolean advance() {
        while(scan.hasNextLine()){
            String line = scan.nextLine();

            line = line.trim();

            if (!line.isEmpty() && line.charAt(0) != ';'  ) {
                line.replace("\t", "");
                line = line.replaceAll(" +", " ");
                int ind = line.length();
                for (int i = 0; i <line.length() ; i++) {
                    if (line.charAt(i) == ';'){
                        ind = i-1;

                    }

                }
//                System.out.println(line);
                this.line = line.substring(0,(ind));
                return true;
            }

            }
        return false;
        }

	/**
	 * Retorna o comando "intruÃƒÂ§ÃƒÂ£o" atual (sem o avanÃƒÂ§o)
	 * @return a instruÃƒÂ§ÃƒÂ£o atual para ser analilisada
	 */
	public String command() {
		return this.line;
	}

	/**
	 * Retorna o tipo da instruÃƒÂ§ÃƒÂ£o passada no argumento:
	 *  A_COMMAND para leaw, por exemplo leaw $1,%A
	 *  L_COMMAND para labels, por exemplo Xyz: , onde Xyz ÃƒÂ© um sÃƒÂ­mbolo.
	 *  C_COMMAND para todos os outros comandos
	 * @param  command instruÃƒÂ§ÃƒÂ£o a ser analisada.
	 * @return o tipo da instruÃƒÂ§ÃƒÂ£o.
	 */
	public CommandType commandType(String command) {
		try {
			if (command.endsWith(":")) {
				return CommandType.L_COMMAND;
			}
			else if (command.startsWith("lea")) {
				return CommandType.A_COMMAND;
			}
			else {
				return CommandType.C_COMMAND;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * Retorna o sÃƒÂ­mbolo ou valor numÃƒÂ©rico da instruÃƒÂ§ÃƒÂ£o passada no argumento.
	 * Deve ser chamado somente quando commandType() ÃƒÂ© A_COMMAND.
	 * @param  command instruÃƒÂ§ÃƒÂ£o a ser analisada.
	 * @return somente o sÃƒÂ­mbolo ou o valor nÃƒÂºmero da instruÃƒÂ§ÃƒÂ£o.
	 */
	public String symbol(String command) {
        String simb = "";
        Integer inde = 0;
        if(commandType(command) == CommandType.A_COMMAND){

            for (int i = 0; i <command.length() ; i++) {
                if(command.charAt(i)=='$'){
                    inde = i+1;
                }
            }
            String newcom= command.substring(inde,command.length());
            for (int i = 0; i <newcom.length() ; i++) {

                if(newcom.charAt(i)==' ' || newcom.charAt(i) == ','){
                    break;
                }
                simb+=newcom.charAt(i);

            }
        }
        return simb;
	}

	/**
	 * Retorna o sÃƒÂ­mbolo da instruÃƒÂ§ÃƒÂ£o passada no argumento.
	 * Deve ser chamado somente quando commandType() ÃƒÂ© L_COMMAND.
	 * @param  command instruÃƒÂ§ÃƒÂ£o a ser analisada.
	 * @return o sÃƒÂ­mbolo da instruÃƒÂ§ÃƒÂ£o (sem os dois pontos).
	 */
	public String label(String command) {
		String label = "";
		label = command.substring(0,command.length()-1);

		return label;
	}

	/**
	 * Separa os mnemÃƒÂ´nicos da instruÃƒÂ§ÃƒÂ£o fornecida em tokens em um vetor de Strings.
	 * Deve ser chamado somente quando CommandType () ÃƒÂ© C_COMMAND.
	 * @param  command instruÃƒÂ§ÃƒÂ£o a ser analisada.
	 * @return um vetor de string contento os tokens da instruÃƒÂ§ÃƒÂ£o (as partes do comando).
	 */
	//addw%S,%A,%D
	// movw %A %D -> ["movw", "%A", "%D"]
	public String[] instruction(String command) {
		String[] instruction = new String[3];
		command = command.replace(","," ").replace("  ", " ");
		instruction = command.split(" ");
		return instruction;
	}

}
