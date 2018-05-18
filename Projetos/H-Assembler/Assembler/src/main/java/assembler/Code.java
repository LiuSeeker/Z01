/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */

package assembler;

/**
 * Traduz mnemônicos da linguagem assembly para códigos binários da arquitetura Z0.
 */
public class Code {

    /**
     * Retorna o código binário do(s) registrador(es) que vão receber o valor da instrução.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 4 bits) com código em linguagem de máquina para a instrução.
     */
    public static String dest(String[] mnemnonic) {
    	String d_a = "0"; // destino a
    	String d_s = "0"; // destino s
    	String d_d = "0"; // destino d
    	String d_m = "0"; // destino da memória
    	int tamanho = mnemnonic.length;
    	
    	if (mnemnonic[0].equals("movw")){
	    	for (int i=2;i < tamanho; i++){
	    		if (mnemnonic[i].equals("%A")){
	    			d_a = "1";
	    		}else if (mnemnonic[i].equals("%S")){
					d_s = "1";
	    		}else if (mnemnonic[i].equals("%D")){
					d_d = "1";
	    		}else if (mnemnonic[i].equals("(%A)")){
					d_m = "1";}
	    	}
    	}else if (!mnemnonic[0].equals("movw")){
    		if (mnemnonic[tamanho -1].equals("%A")){
    			d_a = "1";}
    		else if (mnemnonic[tamanho-1].equals("%S")){
				d_s = "1";}
    		else if (mnemnonic[tamanho-1].equals("%D")){
				d_d = "1";}
    		else if (mnemnonic[tamanho-1].equals("(%A)")){
				d_m = "1";}
    	}  	
    	String resultado = d_a + d_s + d_d + d_m;
    	return resultado;
    }
    
    public static String res_comp(String[] mnemnonic){
    	String a = "0";
    	String b = "0";
    	
    	if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%D")||
    			mnemnonic[1].equals("%D") && mnemnonic[2].equals("%A")){
    			a = "0";
    			b = "0";
    		}else if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%S")||
    				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("%A")){
    			a = "0";
    			b = "1";
    		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%D")||
    				  mnemnonic[1].equals("%D") && mnemnonic[2].equals("(%A)")){
    			a = "1";
    			b = "0";
    		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%S")||
    				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("(%A)")){
    			a = "1";
    			b = "1";
    		}
    	
    	return a+b;
    }
    
    /**
     * Retorna o código binário do mnemônico para realizar uma operação de cálculo.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 8 bits) com código em linguagem de máquina para a instrução.
     */
    public static String comp(String[] mnemnonic) {
    	String a = "0";
    	String b = "0";
    	String c = "000000";
    
    	if (mnemnonic[0].equals("movw")){ //------------------------------------------------------
    		if (mnemnonic[1].equals("%A")){
    			a = "0";
    			b = "0";
    			c = "110000";
    		}else if (mnemnonic[1].equals("%D")){
    			a = "0";
    			b = "0";
    			c = "001100";
    		}else if (mnemnonic[1].equals("%S")){
    			a = "0";
    			b = "1";
    			c = "001100";
    		}else if (mnemnonic[1].equals("(%A)")){
    			a = "1";
    			b = "0";
    			c = "110000";
    		}
    		
    	}else if (mnemnonic[0].equals("addw")){ //------------------------------------------------------
    		c = "000010";
    		if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%D")||
    			mnemnonic[1].equals("%D") && mnemnonic[2].equals("%A")){
    			a = "0";
    			b = "0";
    		}else if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%S")||
    				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("%A")){
    			a = "0";
    			b = "1";
    		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%D")||
    				  mnemnonic[1].equals("%D") && mnemnonic[2].equals("(%A)")){
    			a = "1";
    			b = "0";
    		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%S")||
    				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("(%A)")){
    			a = "1";
    			b = "1";
    		}
    		
    	}else if (mnemnonic[0].equals("subw")){ //------------------------------------------------------
    		c = "010011";
    		String i0 = "$0";
    		String i1 = "$1";
    		String i2 = "$-1";
    		if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%D")||
    			mnemnonic[1].equals("%D") && mnemnonic[2].equals("%A")){
    			a = "0";
    			b = "0";
    		}else if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%S")||
    				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("%A")){
    			a = "0";
    			b = "1";
    		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%D")||
    				  mnemnonic[1].equals("%D") && mnemnonic[2].equals("(%A)")){
    			a = "1";
    			b = "0";
    		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%S")||
    				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("(%A)")){
    			a = "1";
    			b = "1";
    			
    		}else if ((mnemnonic[2].equals(i0)||mnemnonic[2].equals(i1)||mnemnonic[2].equals(i2)) && mnemnonic [1].equals("(%A)")){
    			a = "1";
    			b = "0";
    			c = "110010";
    			
    		}else if ((mnemnonic[2].equals(i0)||mnemnonic[2].equals(i1)||mnemnonic[2].equals(i2)) && mnemnonic [1].equals("%A")){
    			a = "0";
    			b = "0";
    			c = "110010";
    			
    		}else if ((mnemnonic[2].equals(i0)||mnemnonic[2].equals(i1)||mnemnonic[2].equals(i2)) && mnemnonic [1].equals("%D")){
    			a = "0";
    			b = "0";
    			c = "000010";
    			
    		}else if ((mnemnonic[2].equals(i0)||mnemnonic[2].equals(i1)||mnemnonic[2].equals(i2)) && mnemnonic [1].equals("%S")){
    			a = "0";
    			b = "1";
    			c = "000010";
    		}
    		
    	}else if (mnemnonic[0].equals("rsubw")){ //------------------------------------------------------
    		c = "000111";
    		if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%D")||
    			mnemnonic[1].equals("%D") && mnemnonic[2].equals("%A")){
    			a = "0";
    			b = "0";
    		}else if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%S")||
    				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("%A")){
    			a = "0";
    			b = "1";
    		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%D")||
    				  mnemnonic[1].equals("%D") && mnemnonic[2].equals("(%A)")){
    			a = "1";
    			b = "0";
    		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%S")||
    				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("(%A)")){
    			a = "1";
    			b = "1";
    		}
    		
    	}else if (mnemnonic[0].equals("decw")){ //------------------------------------------------------
    		if(mnemnonic[1].equals("%A")){
    			a = "0";
    			b = "0";
    			c = "110010";
    			
    		}else if(mnemnonic[1].equals("%D")){
    			a = "0";
    			b = "0";
    			c = "001110";
    		}else if(mnemnonic[1].equals("%S")){
    			a = "0";
    			b = "1";
    			c = "001110";
    		}else if(mnemnonic[1].equals("(%A)")){
    			a = "1";
    			b = "0";
    			c = "110010";
    		}
    		
    	}else if (mnemnonic[0].equals("incw")){ //------------------------------------------------------
    		if(mnemnonic[1].equals("%A")){
    			a = "0";
    			b = "0";
    			c = "110111";
    			
    		}else if(mnemnonic[1].equals("%D")){
    			a = "0";
    			b = "0";
    			c = "011111";
    			
    		}else if(mnemnonic[1].equals("%S")){
    			a = "0";
    			b = "1";
    			c = "011111";
    			
    		}else if(mnemnonic[1].equals("(%A)")){
    			a = "1";
    			b = "0";
    			c = "110111";
    		}
    		
    	}else if (mnemnonic[0].equals("notw")){ //------------------------------------------------------
    		if(mnemnonic[1].equals("%A")){
    			a = "0";
    			b = "0";
    			c = "110001";
    			
    		}else if(mnemnonic[1].equals("%D")){
    			a = "0";
    			b = "0";
    			c = "001101";
    			
    		}else if(mnemnonic[1].equals("%S")){
    			a = "0";
    			b = "1";
    			c = "001101";
    			
    		}else if(mnemnonic[1].equals("(%A)")){
    			a = "1";
    			b = "0";
    			c = "110001";
    		}
    		
    	}else if (mnemnonic[0].equals("negw")){ //------------------------------------------------------
    		if(mnemnonic[1].equals("%A")){
    			a = "0";
    			b = "0";
    			c = "110011";
    			
    		}else if(mnemnonic[1].equals("%D")){
    			a = "0";
    			b = "0";
    			c = "001111";
    			
    		}else if(mnemnonic[1].equals("%S")){
    			a = "0";
    			b = "1";
    			c = "001111";
    			
    		}else if(mnemnonic[1].equals("(%A)")){
    			a = "1";
    			b = "0";
    			c = "110011";
    		}
    		
    	}else if (mnemnonic[0].equals("andw")){ //------------------------------------------------------
    		c = "000000";
    		if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%D")||
    			mnemnonic[1].equals("%D") && mnemnonic[2].equals("%A")){
    			a = "0";
    			b = "0";
    		}else if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%S")||
    				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("%A")){
    			a = "0";
    			b = "1";
    		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%D")||
    				  mnemnonic[1].equals("%D") && mnemnonic[2].equals("(%A)")){
    			a = "1";
    			b = "0";
    		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%S")||
    				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("(%A)")){
    			a = "1";
    			b = "1";
    		}
    		
    	}else if (mnemnonic[0].equals("orw")){ //------------------------------------------------------
    		c = "010101";
    		if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%D")||
        			mnemnonic[1].equals("%D") && mnemnonic[2].equals("%A")){
        			a = "0";
        			b = "0";
        		}else if (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%S")||
        				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("%A")){
        			a = "0";
        			b = "1";
        		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%D")||
        				  mnemnonic[1].equals("%D") && mnemnonic[2].equals("(%A)")){
        			a = "1";
        			b = "0";
        		}else if (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%S")||
        				  mnemnonic[1].equals("%S") && mnemnonic[2].equals("(%A)")){
        			a = "1";
        			b = "1";
        		}	
    	}else if (mnemnonic[0].equals("jmp") || mnemnonic[0].equals("je") ||
    			  mnemnonic[0].equals("jne") || mnemnonic[0].equals("jg") ||
    			  mnemnonic[0].equals("jge") || mnemnonic[0].equals("jl") ||
    			  mnemnonic[0].equals("jle")){ //------------------------------------------------------
    		if(mnemnonic[1].equals("%A")){
    			a = "0";
    			b = "0";
    			c = "110000";
    			
    		}else if(mnemnonic[1].equals("%D")){
    			a = "0";
    			b = "0";
    			c = "001100";
    			
    		}else if(mnemnonic[1].equals("%S")){
    			a = "0";
    			b = "1";
    			c = "001100";
    			
    		}else if(mnemnonic[1].equals("(%A)")){
    			a = "1";
    			b = "0";
    			c = "110000";
    		}
    	}
    	
    	String resposta = a + b + c;
    	return resposta;
    }

    /**
     * Retorna o código binário do mnemônico para realizar uma operação de jump (salto).
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 3 bits) com código em linguagem de máquina para a instrução.
     */
    public static String jump(String[] mnemnonic) {
    	String j2 = "0";
    	String j1 = "0";
    	String j0 = "0";
    	
    	if (mnemnonic[0].equals("jmp")){
    		j2 = "1";
    		j1 = "1";
    		j0 = "1";
    	}
    	else if (mnemnonic[0].equals("je")){
    		j2 = "0";
    		j1 = "1";
    		j0 = "0";
    	}
    	else if (mnemnonic[0].equals("jne")){
    		j2 = "1";
    		j1 = "0";
    		j0 = "1";
    	}
    	else if (mnemnonic[0].equals("jg")){
    		j2 = "0";
    		j1 = "0";
    		j0 = "1";
    	}
    	else if (mnemnonic[0].equals("jge")){
    		j2 = "0";
    		j1 = "1";
    		j0 = "1";
    	}
    	else if (mnemnonic[0].equals("jl")){
    		j2 = "1";
    		j1 = "0";
    		j0 = "0";
    	}
    	else if (mnemnonic[0].equals("jle")){
    		j2 = "1";
    		j1 = "1";
    		j0 = "0";
    	}
    	else {
    		j2 = "0";
    		j1 = "0";
    		j0 = "0";
    	}
    	
    	return j2 + j1 + j0;
    }

    /**
     * Retorna o código binário de um valor decimal armazenado numa String.
     * @param  symbol valor numérico decimal armazenado em uma String.
     * @return Valor em binário (String de 15 bits) representado com 0s e 1s.
     */

    public static String toBinary(String symbol) {
    	
    	int valor = Integer.parseInt(symbol); 	/* Converte a string symbol para um inteiro */
    	String binario = Integer.toBinaryString(valor); /* Função toBinaryString transforma o valor inteiro para binario */
    	int tamanho_binario = binario.length(); /* Inteiro com o tamanho da string binario */
    	if (tamanho_binario < 15) { 			/* Condicional que verifica se o tamanho do binario é menor que 15 */
    		for (int i = 0; i < (15-tamanho_binario); i++) {
    			binario = "0" + binario; 		/* Completa o binario com os valores de 0 até ficar com 15 caracteres */
    		}
    	}
    	return binario;
    }
    
}
