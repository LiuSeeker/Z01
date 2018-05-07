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
    	
    	if (mnemnonic[0] == "movw" ){
	    	for (int i=2;i < tamanho; i++){
	    		if (mnemnonic[i] == "%A"){
	    			d_a = "1";
	    		}else if (mnemnonic[i] == "%S"){
					d_s = "1";
	    		}else if (mnemnonic[i] == "%D"){
					d_d = "1";
	    		}else if (mnemnonic[i] == "(%A)"){
					d_m = "1";}
	    	}
    	}else if (mnemnonic[0] == "subw" || mnemnonic[0] == "rsubw" || mnemnonic[0] == "addw" || 
    			 mnemnonic[0] == "incw" || mnemnonic[0] == "decw" || mnemnonic[0] == "notw" || 
    			 mnemnonic[0] == "negw" || mnemnonic[0] == "orw" || mnemnonic[0] == "andw"){
    		if (mnemnonic[mnemnonic.length -1] == "%A"){
    			d_a = "1";}
    		else if (mnemnonic[tamanho-1] == "%S"){
				d_s = "1";}
    		else if (mnemnonic[tamanho-1] == "%D"){
				d_d = "1";}
    		else if (mnemnonic[tamanho-1] == "(%A)"){
				d_m = "1";}
    	}  	
    	String resultado = d_a + d_s + d_d + d_m;
    	return resultado;
    }
    
    public static String res_comp(String[] mnemnonic){
    	String a = "0";
    	String b = "0";
    	
    	if (mnemnonic[1] == "%A" && mnemnonic[2]=="%D"||
    			mnemnonic[1] == "%D" && mnemnonic[2]=="%A"){
    			a = "0";
    			b = "0";
    		}else if (mnemnonic[1] == "%A" && mnemnonic[2]=="%S"||
    				  mnemnonic[1] == "%S" && mnemnonic[2]=="%A"){
    			a = "0";
    			b = "1";
    		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%D"||
    				  mnemnonic[1] == "%D" && mnemnonic[2]=="(%A)"){
    			a = "1";
    			b = "0";
    		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%S"||
    				  mnemnonic[1] == "%S" && mnemnonic[2]=="(%A)"){
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
    
    	if (mnemnonic[0] == "movw"){ //------------------------------------------------------
    		if (mnemnonic[1] == "%A"){
    			a = "0";
    			b = "0";
    			c = "110000";
    		}else if (mnemnonic[1] == "%D"){
    			a = "0";
    			b = "0";
    			c = "001100";
    		}else if (mnemnonic[1] == "%S"){
    			a = "0";
    			b = "1";
    			c = "001100";
    		}else if (mnemnonic[1] == "(%A)"){
    			a = "1";
    			b = "0";
    			c = "110000";
    		}
    		
    	}else if (mnemnonic[0] == "addw"){ //------------------------------------------------------
    		c = "000010";
    		if (mnemnonic[1] == "%A" && mnemnonic[2]=="%D"||
    			mnemnonic[1] == "%D" && mnemnonic[2]=="%A"){
    			a = "0";
    			b = "0";
    		}else if (mnemnonic[1] == "%A" && mnemnonic[2]=="%S"||
    				  mnemnonic[1] == "%S" && mnemnonic[2]=="%A"){
    			a = "0";
    			b = "1";
    		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%D"||
    				  mnemnonic[1] == "%D" && mnemnonic[2]=="(%A)"){
    			a = "1";
    			b = "0";
    		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%S"||
    				  mnemnonic[1] == "%S" && mnemnonic[2]=="(%A)"){
    			a = "1";
    			b = "1";
    		}
    		
    	}else if (mnemnonic[0] == "subw"){ //------------------------------------------------------
    		c = "010011";
    		String i0 = "$0";
    		String i1 = "$1";
    		String i2 = "$-1";
    		if (mnemnonic[1] == "%A" && mnemnonic[2]=="%D"||
    			mnemnonic[1] == "%D" && mnemnonic[2]=="%A"){
    			a = "0";
    			b = "0";
    		}else if (mnemnonic[1] == "%A" && mnemnonic[2]=="%S"||
    				  mnemnonic[1] == "%S" && mnemnonic[2]=="%A"){
    			a = "0";
    			b = "1";
    		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%D"||
    				  mnemnonic[1] == "%D" && mnemnonic[2]=="(%A)"){
    			a = "1";
    			b = "0";
    		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%S"||
    				  mnemnonic[1] == "%S" && mnemnonic[2]=="(%A)"){
    			a = "1";
    			b = "1";
    			
    		}else if ((mnemnonic[2]==i0||mnemnonic[2]==i1||mnemnonic[2]==i2) && mnemnonic [1] == "(%A)"){
    			a = "1";
    			b = "0";
    			c = "110010";
    			
    		}else if ((mnemnonic[2]==i0||mnemnonic[2]==i1||mnemnonic[2]==i2) && mnemnonic [1] == "%A"){
    			a = "0";
    			b = "0";
    			c = "110010";
    			
    		}else if ((mnemnonic[2]==i0||mnemnonic[2]==i1||mnemnonic[2]==i2) && mnemnonic [1] == "%D"){
    			a = "0";
    			b = "0";
    			c = "000010";
    			
    		}else if ((mnemnonic[2]==i0||mnemnonic[2]==i1||mnemnonic[2]==i2) && mnemnonic [1] == "%S"){
    			a = "0";
    			b = "1";
    			c = "000010";
    		}
    		
    	}else if (mnemnonic[0] == "rsubw"){ //------------------------------------------------------
    		c = "000111";
    		if (mnemnonic[1] == "%A" && mnemnonic[2]=="%D"||
    			mnemnonic[1] == "%D" && mnemnonic[2]=="%A"){
    			a = "0";
    			b = "0";
    		}else if (mnemnonic[1] == "%A" && mnemnonic[2]=="%S"||
    				  mnemnonic[1] == "%S" && mnemnonic[2]=="%A"){
    			a = "0";
    			b = "1";
    		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%D"||
    				  mnemnonic[1] == "%D" && mnemnonic[2]=="(%A)"){
    			a = "1";
    			b = "0";
    		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%S"||
    				  mnemnonic[1] == "%S" && mnemnonic[2]=="(%A)"){
    			a = "1";
    			b = "1";
    		}
    		
    	}else if (mnemnonic[0] == "decw"){ //------------------------------------------------------
    		if(mnemnonic[1] == "%A"){
    			a = "0";
    			b = "0";
    			c = "110010";
    			
    		}else if(mnemnonic[1] == "%D"){
    			a = "0";
    			b = "0";
    			c = "001110";
    		}else if(mnemnonic[1] == "%S"){
    			a = "0";
    			b = "1";
    			c = "001110";
    		}else if(mnemnonic[1] == "(%A)"){
    			a = "1";
    			b = "0";
    			c = "110010";
    		}
    		
    	}else if (mnemnonic[0] == "incw"){ //------------------------------------------------------
    		if(mnemnonic[1] == "%A"){
    			a = "0";
    			b = "0";
    			c = "110111";
    			
    		}else if(mnemnonic[1] == "%D"){
    			a = "0";
    			b = "0";
    			c = "011111";
    			
    		}else if(mnemnonic[1] == "%S"){
    			a = "0";
    			b = "1";
    			c = "011111";
    			
    		}else if(mnemnonic[1] == "(%A)"){
    			a = "1";
    			b = "0";
    			c = "110111";
    		}
    		
    	}else if (mnemnonic[0] == "notw"){ //------------------------------------------------------
    		if(mnemnonic[1] == "%A"){
    			a = "0";
    			b = "0";
    			c = "110001";
    			
    		}else if(mnemnonic[1] == "%D"){
    			a = "0";
    			b = "0";
    			c = "001101";
    			
    		}else if(mnemnonic[1] == "%S"){
    			a = "0";
    			b = "1";
    			c = "001101";
    			
    		}else if(mnemnonic[1] == "(%A)"){
    			a = "1";
    			b = "0";
    			c = "110001";
    		}
    		
    	}else if (mnemnonic[0] == "negw"){ //------------------------------------------------------
    		if(mnemnonic[1] == "%A"){
    			a = "0";
    			b = "0";
    			c = "110011";
    			
    		}else if(mnemnonic[1] == "%D"){
    			a = "0";
    			b = "0";
    			c = "001111";
    			
    		}else if(mnemnonic[1] == "%S"){
    			a = "0";
    			b = "1";
    			c = "001111";
    			
    		}else if(mnemnonic[1] == "(%A)"){
    			a = "1";
    			b = "0";
    			c = "110011";
    		}
    		
    	}else if (mnemnonic[0] == "andw"){ //------------------------------------------------------
    		c = "000000";
    		if (mnemnonic[1] == "%A" && mnemnonic[2]=="%D"||
    			mnemnonic[1] == "%D" && mnemnonic[2]=="%A"){
    			a = "0";
    			b = "0";
    		}else if (mnemnonic[1] == "%A" && mnemnonic[2]=="%S"||
    				  mnemnonic[1] == "%S" && mnemnonic[2]=="%A"){
    			a = "0";
    			b = "1";
    		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%D"||
    				  mnemnonic[1] == "%D" && mnemnonic[2]=="(%A)"){
    			a = "1";
    			b = "0";
    		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%S"||
    				  mnemnonic[1] == "%S" && mnemnonic[2]=="(%A)"){
    			a = "1";
    			b = "1";
    		}
    		
    	}else if (mnemnonic[0] == "orw"){ //------------------------------------------------------
    		c = "010101";
    		if (mnemnonic[1] == "%A" && mnemnonic[2]=="%D"||
        			mnemnonic[1] == "%D" && mnemnonic[2]=="%A"){
        			a = "0";
        			b = "0";
        		}else if (mnemnonic[1] == "%A" && mnemnonic[2]=="%S"||
        				  mnemnonic[1] == "%S" && mnemnonic[2]=="%A"){
        			a = "0";
        			b = "1";
        		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%D"||
        				  mnemnonic[1] == "%D" && mnemnonic[2]=="(%A)"){
        			a = "1";
        			b = "0";
        		}else if (mnemnonic[1] == "(%A)" && mnemnonic[2]=="%S"||
        				  mnemnonic[1] == "%S" && mnemnonic[2]=="(%A)"){
        			a = "1";
        			b = "1";
        		}	
    	}else if (mnemnonic[0] == "jmp" || mnemnonic[0] == "je" ||
    			  mnemnonic[0] == "jne" || mnemnonic[0] == "jg" ||
    			  mnemnonic[0] == "jge" || mnemnonic[0] == "jl" ||
    			  mnemnonic[0] == "jle"){ //------------------------------------------------------
    		if(mnemnonic[1] == "%A"){
    			a = "0";
    			b = "0";
    			c = "110000";
    			
    		}else if(mnemnonic[1] == "%D"){
    			a = "0";
    			b = "0";
    			c = "001100";
    			
    		}else if(mnemnonic[1] == "%S"){
    			a = "0";
    			b = "1";
    			c = "001100";
    			
    		}else if(mnemnonic[1] == "(%A)"){
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
    	
    	if (mnemnonic[0] == "jmp"){
    		j2 = "1";
    		j1 = "1";
    		j0 = "1";
    	}
    	else if (mnemnonic[0] == "je"){
    		j2 = "0";
    		j1 = "1";
    		j0 = "0";
    	}
    	else if (mnemnonic[0] == "jne"){
    		j2 = "1";
    		j1 = "0";
    		j0 = "1";
    	}
    	else if (mnemnonic[0] == "jg"){
    		j2 = "0";
    		j1 = "0";
    		j0 = "1";
    	}
    	else if (mnemnonic[0] == "jge"){
    		j2 = "0";
    		j1 = "1";
    		j0 = "1";
    	}
    	else if (mnemnonic[0] == "jl"){
    		j2 = "1";
    		j1 = "0";
    		j0 = "0";
    	}
    	else if (mnemnonic[0] == "jle"){
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
