/**
 * Curso: Elementos de Sistemas
 * Arquivo: Parser.java
 */
package assembler;

import java.util.Scanner;

/**
 * Encapsula o cÃƒÂ³digo de leitura. Carrega as instruÃƒÂ§ÃƒÂµes na linguagem assembly,
 * analisa, e oferece acesso as partes da instruÃƒÂ§ÃƒÂ£o  (campos e sÃƒÂ­mbolos).
 * AlÃƒÂ©m disso, remove todos os espaÃƒÂ§os em branco e comentÃƒÂ¡rios.
 */
public class Parser {
	String file;
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
		this.file = file;

		try {
			scan = new Scanner(file);
		}
		catch (Exception e) {
			System.out.println("Arquivo nÃƒÂ£o encontrado - Error");
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
		if (scan.hasNextLine()) {
			String line = scan.nextLine();
			line = line.trim(); // remove espaÃƒÂ§os em branco
			while (scan.hasNextLine() && (line.equals("") || line.equals("\n") || line.startsWith(";"))) {
				line = scan.nextLine();
				line = line.trim();
			}
			return true;
		}
		else {
			return false;
		}
	}

	/**
	 * Retorna o comando "intruÃƒÂ§ÃƒÂ£o" atual (sem o avanÃƒÂ§o)
	 * @return a instruÃƒÂ§ÃƒÂ£o atual para ser analilisada
	 */
	public String command() {
		return line;
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
		String symbol = "";
		symbol = command.substring(command.indexOf("%") + 1);
		symbol = symbol.substring(0, symbol.indexOf(","));

		return symbol;
	}

	/**
	 * Retorna o sÃƒÂ­mbolo da instruÃƒÂ§ÃƒÂ£o passada no argumento.
	 * Deve ser chamado somente quando commandType() ÃƒÂ© L_COMMAND.
	 * @param  command instruÃƒÂ§ÃƒÂ£o a ser analisada.
	 * @return o sÃƒÂ­mbolo da instruÃƒÂ§ÃƒÂ£o (sem os dois pontos).
	 */
	public String label(String command) {
		String label = "";
		label = command.substring(0,-1);

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
		command = command.replace(","," ");
		instruction = command.split(" ");
		return instruction;
	}

}