# Bash bible
 1. [Variáveis](#variáveis)
 2. [Estruturas de controle no bash](#estruturas-de-controle-no-bash)
 3. [Funções](#funções)
 4. [Parâmetros e argumentos: Manipulação de linha de comando](#parâmetros-e-argumentos)
 5. [Opções de linha de comando](#opções-de-linha-de-comando)
 6. [Expressões regulares](#expressões-regulares)
 7. [Arrays](#arrays)
 8. [Subshells e Processamento em Segundo Plano](#subshells-e-processamento-em-segundo-plano)
 9. [Processamento de Texto](#processamento-de-texto)
 10. [ Redirecionamento de arquivos](#redirecionamento-de-arquivos)
 11. [Depuração de scripts](#depuração-de-scripts)
 12. [AWK](#awk)
 13. [SED](#sed)
 14. [GREP](#grep)



# Variáveis 

Sintaxe:
```bash
nome="joão"
idade=25
echo $nome $idade
```

1. Substituição de comandos
```bash
data=$(date +%Y-%m-%d)
echo $data
```

&ensp;&ensp;&ensp;&ensp;Neste exemplo, usamos o comando `date` para obter a data atual no formato "YYYY-MM-DD" e atribuímos o resultado à variável `data` usando a sintaxe `$(comando)`. Em seguida, imprimimos o valor da variável `data`, que mostrará a data atual.
&ensp;&ensp;&ensp;&ensp;É importante observar que as variáveis no Bash são tipadas dinamicamente, o que significa que você não precisa especificar o tipo de dado ao declará-las. Elas podem armazenar valores de diferentes tipos (strings, números, etc.) e podem até mesmo ser reatribuídas a um tipo diferente.

## Estruturas de controle no bash

1. **Condicional if/Else**
```bash
valor=10 
if [ $valor -gt 10 ]; then  
	echo  "O valor é maior que 10."  
elif [ $valor -eq 10 ]; then  
	echo  "O valor é igual a 10."  
else  
	echo  "O valor é menor que 10."  
fi
```

Operadores de comparação numérica:

-   `-eq`: Igual a (equal to)
-   `-ne`: Diferente de (not equal to)
-   `-gt`: Maior que (greater than)
-   `-lt`: Menor que (less than)
-   `-ge`: Maior ou igual a (greater than or equal to)
-   `-le`: Menor ou igual a (less than or equal to)

Operadores de comparação de strings:

-   `=`: Igual a
-   `!=`: Diferente de
-   `-z`: Vazio (a string está vazia)
-   `-n`: Não vazio (a string não está vazia)

Operadores lógicos:

-   `-a` ou `&&`: E lógico (and)
-   `-o` ou `||`: OU lógico (or)
-   `!`: NÃO lógico (not)

Outros parâmetros:

-   `-f`: Arquivo regular (verifica se o caminho fornecido é um arquivo regular)
-   `-d`: Diretório (verifica se o caminho fornecido é um diretório)
-   `-e`: Existência (verifica se o caminho fornecido existe)
-   `-s`: Tamanho (verifica se o arquivo tem tamanho maior que zero)

2. loops (For)
```bash
for i in {1..5}; do
    echo "Valor: $i"
done
```

3. loops (while)
```bash
contador=1
while [ $contador -le 5 ]; do
    echo "Contador: $contador"
    contador=$((contador + 1))
done
```
3 Case statements
```bash
fruta="banana"
case $fruta in
    "maçã")
        echo "Você escolheu uma maçã."
        ;;
    "laranja")
        echo "Você escolheu uma laranja."
        ;;
    "banana")
        echo "Você escolheu uma banana."
        ;;
    *)
        echo "Fruta desconhecida."
        ;;
esac
```


# Funções
1. Definindo funções
	```bash	
	minha_funcao() {
	    echo "Olá, esta é minha função!"
	    echo "Realizando alguma tarefa..."
	}
	```
2. Chamando função
	Para chamar uma função, basta usar seu nome sem por parênteses. Aqui está um exemplo:
	```bash
	minha_funcao
	```
3. Passando argumentos para uma função
```bash
	saudacao() {
        nome=$1
        echo "Olá, $nome!"
    }
    
   saudacao "João"
```

4. Retornando valores
```bash
soma() {
    a=$1
    b=$2
    return $((a + b))
}

resultado=$(soma 10 5)
echo "A soma é: $resultado"
```

# Parâmetros e argumentos

1.  Acessando argumentos: Dentro de um script Bash, você pode acessar os argumentos usando as variáveis especiais `$1`, `$2`, `$3` e assim por diante. Cada variável representa um argumento na ordem em que foi passado. Aqui está um exemplo:

    ```bash
    # Script: meu_script.sh
    echo "O primeiro argumento é: $1"
    echo "O segundo argumento é: $2"
    ```
    
    Ao executar o script com `./meu_script.sh argumento1 argumento2`, os valores de `argumento1` e `argumento2` serão exibidos.
    
2.  Número de argumentos: 
    ```bash
    # Script: meu_script.sh
    echo "Número de argumentos: $#"
    ``` 

    
3.  Argumentos em massa: É possível acessar todos os argumentos passados para o script usando a variável especial `$@` ou `$*`. Aqui está um exemplo:
    
	```bash    
	# Script: meu_script.sh
	    for argumento in "$@"; do
	        echo "Argumento: $argumento"
	    done
	```
    Ao executar o script com `./meu_script.sh argumento1 argumento2`, cada argumento será exibido em linhas separadas.
    

4.  Parâmetros padrão: Você pode definir valores padrão para os argumentos caso nenhum argumento seja fornecido na linha de comando. Aqui está um exemplo:

	```bash    
    # Script: meu_script.sh
    parametro=${1:-"valor_padrao"}
    echo "O valor do parâmetro é: $parametro"
	```
    
    Se nenhum argumento for passado ao executar o script, o valor padrão "valor_padrao" será usado.
    

# Opções de linha de comando


1. No Bash, uma forma comum de lidar com opções de linha de comando é usando a estrutura `getopts`. O `getopts` é um comando interno do Bash que ajuda a analisar e validar as opções e seus argumentos correspondentes. Aqui está um exemplo básico de uso do `getopts`:
```bash
while getopts ":a:b:c" opt; do
  case $opt in
    a)
      echo "Opção -a fornecida com argumento: $OPTARG"
      ;;
    b)
      echo "Opção -b fornecida com argumento: $OPTARG"
      ;;
    c)
      echo "Opção -c fornecida"
      ;;
    \?)
      echo "Opção inválida: -$OPTARG"
      ;;
  esac
done
```

Neste exemplo, o script está configurado para aceitar três opções: `-a`, `-b` e `-c`. A opção `-a` requer um argumento, enquanto as opções `-b` e `-c` não requerem argumentos adicionais. O `getopts` é usado para percorrer cada opção e realizar ações específicas com base na opção encontrada.

Ao executar o script com opções de linha de comando, você pode fornecer os argumentos correspondentes. Por exemplo:
	
```bash
  $ ./meu_script.sh -a argumentoA -b argumentoB -c
```
A saída seria:
```bash
Opção -a fornecida com argumento: argumentoA
Opção -b fornecida com argumento: argumentoB
Opção -c fornecida
```
Além disso, é comum usar a opção `:` no início da string de opções no `getopts` para tratar erros ou opções inválidas.

# Expressões regulares


1.  Padrões básicos:
    
    -   `.` (ponto): Correspondente a qualquer caractere único.
    -   `^` (circunflexo): Correspondente ao início da linha.
    -   `$` (cifrão): Correspondente ao final da linha.
    -   `[ ]` (colchetes): Correspondente a qualquer caractere dentro dos colchetes. Por exemplo, `[aeiou]` corresponde a qualquer vogal.
    -   `[^ ]` (colchetes invertidos): Correspondente a qualquer caractere que não esteja dentro dos colchetes. Por exemplo, `[^0-9]` corresponde a qualquer caractere que não seja um dígito.
    -   `*` (asterisco): Correspondente a zero ou mais ocorrências do caractere anterior.
    -   `+` (sinal de mais): Correspondente a uma ou mais ocorrências do caractere anterior.
    -   `?` (ponto de interrogação): Correspondente a zero ou uma ocorrência do caractere anterior.
    -   `()` (parênteses): Agrupamento de caracteres para aplicar operadores ou capturar correspondências.
2.  Metacaracteres:
    
    -   `\` (barra invertida): Usado para escapar metacaracteres. Por exemplo, `\.` corresponde ao caractere ponto literal.
    -   `|` (pipe): Usado para especificar alternativas. Por exemplo, `foo|bar` corresponde a "foo" ou "bar".
    -   `^` (circunflexo) dentro de `[ ]`: Usado para negar uma classe de caracteres. Por exemplo, `[^0-9]` corresponde a qualquer caractere que não seja um dígito.
3.  Quantificadores:
    
    -   `{n}`: Correspondente a exatamente n ocorrências do caractere anterior.
    -   `{n,}`: Correspondente a no mínimo n ocorrências do caractere anterior.
    -   `{n,m}`: Correspondente a pelo menos n e no máximo m ocorrências do caractere anterior.
4.  Correspondência e busca:
    
    -   `grep`: Comando usado para buscar padrões em arquivos ou saída de comandos. Por exemplo, `grep 'pattern' arquivo.txt`.
    -   `sed`: Comando usado para manipular e substituir texto usando expressões regulares. Por exemplo, `sed 's/pattern/replacement/g' arquivo.txt`.
    -   `awk`: Ferramenta poderosa para processamento de texto que suporta expressões regulares. Por exemplo, `awk '/pattern/ {print $1}' arquivo.txt`.


# Arrays
1.  Declaração de um array:
    
    -   Para declarar um array, use a seguinte sintaxe:
    ```bash
	frutas=("maçã" "banana" "laranja")
    ``` 
2.  Acessando elementos do array:

	```bash
	echo ${nome_do_array[índice]}
    ```
3.  Tamanho do array:
    
    -   Para obter o tamanho (número de elementos) do array, use a seguinte sintaxe:

	    ```bash
	    ${#frutas[@]} # exibe 3
	    ```
       
4.  Iteração sobre os elementos do array:
    -   Existem várias formas de iterar sobre os elementos de um array:
        -   Usando um loop `for`:
            
		    ```bash      
		    for elemento in "${nome_do_array[@]}"; do
		      # Faça algo com cada elemento
		      echo $elemento
		    done
		    ```
   
       -   Usando um loop `for` com base no índice:
            
		    ```bash      
		    for ((i=0; i<${#nome_do_array[@]}; i++)); do
		      # Faça algo com cada elemento usando o índice
		      echo ${nome_do_array[i]}
		    done
		    ```
            
       -   Usando um loop `while` com base no índice:
			
			```bash    
			i=0
			while [ $i -lt ${#nome_do_array[@]} ]; do
				# Faça algo com cada elemento usando o índice
				echo ${nome_do_array[i]}
				i=$((i+1))
			done
			```
            
5.  Operações com arrays:
    -   Adicionar elementos:
	    ```bash
	    frutas+=("morango")
		```            
           
    -   Remover elementos:
        -   Para remover um elemento do array, use o comando `unset` com o índice do elemento:
        
	    ```bash            
	       unset frutas[1]  # remove o elemento "banana"
	    ```     
           
    -   Copiar arrays:
	    ```bash
	       novas_frutas=("${frutas[@]}")
	    ```

# Subshells e Processamento em Segundo Plano

1.  Subshells:
    
    -   Um subshell é um shell secundário que é criado dentro do shell principal. Ele é útil quando você deseja executar comandos em um ambiente isolado ou quando precisa agrupar um conjunto de comandos relacionados.
    -   Para criar um subshell, você pode usar parênteses `( )`. Os comandos dentro dos parênteses serão executados em um subshell separado.
	    -   Exemplo
		    ```bash
		        (comando1; comando2; comando3)
		    ```
        
    -   O subshell cria um novo ambiente de execução, incluindo suas próprias variáveis, diretórios de trabalho, etc. Quando o subshell termina, quaisquer alterações feitas dentro dele não afetam o shell principal.
2.  Processamento em Segundo Plano:
    
    -   O processamento em segundo plano permite que você execute um comando ou script em segundo plano, liberando o terminal para executar outras tarefas simultaneamente.
    -   Para executar um comando em segundo plano, basta adicionar o caractere `&` no final do comando.
	    -   Exemplo:
		    ```bash 
			    comando1 &
			``` 
        
    -   O comando será executado em segundo plano, e o prompt do terminal ficará disponível para inserir novos comandos.
    -   Você também pode enviar um comando em execução para segundo plano pressionando `Ctrl + Z` e depois digitando o comando `bg`. Isso moverá o comando atualmente em execução para segundo plano.
    -   Para trazer um comando em segundo plano de volta para primeiro plano, use o comando `fg`.
3.  Gerenciamento de Processos em Segundo Plano:
    
    -   O Bash oferece algumas opções para gerenciar processos em segundo plano:
        -   `jobs`: O comando `jobs` lista os processos em segundo plano sendo executados pelo shell atual. Ele fornece o número de identificação do trabalho (job ID) e o estado atual de cada processo.
        -   `kill`: O comando `kill` permite enviar sinais para um processo. Você pode usar o job ID ou o número de identificação do processo (PID) para identificar o processo que deseja interromper.
        -   Exemplo:
            
	```bash
    #Enviar o sinal SIGTERM para um processo em segundo plano pelo job ID
    kill %job_id       
    # Enviar o sinal SIGTERM para um processo em segundo plano pelo PID
    kill pid
	```
            
4.  Exemplo de uso combinado:
    
    -   Você pode combinar subshells e processamento em segundo plano para criar tarefas mais complexas e controlar a execução de comandos.
    -   Exemplo:
		```bash
	     (comando1; comando2; comando3) &
	    ```
        
        Isso executará os comandos dentro do subshell em segundo plano.

Processamento em segundo plano pode ser útil para executar tarefas que não requerem interação imediata do usuário ou que exigem um longo tempo de execução. No entanto, é importante ter cuidado ao gerenciar processos em segundo plano para evitar problemas de recursos ou execução inesperada

# Processamento de Texto

1.  Concatenação de strings:
    
    -   Para concatenar duas ou mais strings, você pode usar o operador de concatenação `+` ou simplesmente juntá-las sem nenhum operador.
    -   Exemplo:
	    ```bash
        str1="Olá"
        str2="Mundo"
        concat=$str1$str2
        echo $concat  # exibe "OláMundo"
	    ```
        
2.  Substituição de strings:
    
    -   Para substituir uma parte de uma string por outra, você pode usar a substituição de padrões.
    -   Exemplo:
		```bash
        str="Hello, World!"
        novo_str=${str/Hello/Hi}
        echo $novo_str  # exibe "Hi, World!"
		```
        
3.  Extração de substrings:
    
    -   Para extrair uma parte específica de uma string, você pode usar a sintaxe de substituição de padrões combinada com índices.
    -   Exemplo:
      
		```bash
        str="Hello, World!"
        substring=${str:7:5}
        echo $substring  # exibe "World"
		```
        
4.  Separação de strings:
    
    -   Para separar uma string em substrings com base em um delimitador, você pode usar o comando `IFS` (Internal Field Separator) e o comando `read`.
    -   Exemplo:    
		```bash
	    str="Maçã,Laranja,Banana"
	    IFS=',' read -ra palavras <<< "$str"
	    echo ${palavras[1]}  # exibe "Laranja"
	    ```
	   - Entendendo esse código
		   -  `str="Maçã,Laranja,Banana"`: Nesta linha, estamos definindo 	a variável `str` com uma string que contém várias palavras separadas por vírgula.
    
			-  `IFS=','`: `IFS` (Internal Field Separator) é uma variável especial do Bash que define o separador de campo interno. Aqui, estamos definindo `IFS` como a vírgula (`,`). Isso significa que o Bash usará a vírgula como o separador para dividir a string em campos separados.
    
			- `read -ra palavras <<< "$str"`: O comando `read` é usado para ler uma entrada do usuário ou de uma variável. Neste caso, estamos usando `read` para ler a string contida na variável `str`. 
				- A opção `-a` indica que queremos armazenar os campos em um array (`palavras`), em vez de atribuí-los a variáveis separadas. 
				- O operador de redirecionamento `<<<` é usado para fornecer a string como entrada para o comando `read`.
				- O uso do parâmetro `-r` é comum quando você deseja ler uma linha de texto que contém caracteres de escape, como barras invertidas, sem que eles sejam interpretados
			-  O operador `<<<` é conhecido como herestring (também chamado de here-string) no Bash. Ele é usado para redirecionar uma string como entrada para um comando.
    
			-  `echo ${palavras[1]}`: Aqui, estamos imprimindo o segundo elemento do array `palavras`. No Bash, os arrays são indexados a partir de 0, portanto, `${palavras[1]}` se refere ao segundo elemento do array. Neste caso, será exibido "Laranja".
			
        
5.  Transformação de caixa:
    
    -   O Bash oferece várias opções para transformar a caixa (maiúsculas ou minúsculas) de uma string.
    -   Exemplo:
  
		```bash
	      str="Texto de Exemplo"
	      echo ${str^^}  # exibe "TEXTO DE EXEMPLO" (caixa alta)
	      echo ${str,,}  # exibe "texto de exemplo" (caixa baixa)
	    ```
        
6.  Substituição global:
    
    -   Para substituir todas as ocorrências de uma substring em uma string, você pode usar a substituição de padrões com a opção `/g`.
    -   Exemplo:
        ```bash
        str="Hello, Hello, World!"
        novo_str=${str//Hello/Hi}
        echo $novo_str  # exibe "Hi, Hi, World!"
    ```

# Redirecionamento de arquivos
1.  Redirecionamento de Saída para um Arquivo (`>`):
    
    O operador `>` é usado para redirecionar a saída de um comando para um arquivo. Se o arquivo não existir, ele será criado. Se o arquivo existir, seu conteúdo será substituído pelo novo resultado.
    Exemplo:
    ```bash
	echo "Hello, World!" > arquivo.txt
    ```
    
2.  Redirecionamento de Saída para um Arquivo (concatenação - `>>`):
    O operador `>>` é usado para redirecionar a saída de um comando e anexá-la a um arquivo existente, ao invés de substituir o conteúdo do arquivo.
    Exemplo:
    ```bash
    echo "Novo conteúdo" >> arquivo.txt
    ```
    
3.  Redirecionamento de Entrada a partir de um Arquivo (`<`):
        O operador `<` é usado para redirecionar a entrada de um comando a partir de um arquivo. Isso permite que o comando leia dados do arquivo como entrada, em vez de receber entrada do teclado.
    Exemplo:
	   ```bash
	   while read linha; do
	      echo "Linha: $linha"
	   done < arquivo.txt
	   ```
    
4.  Redirecionamento de Entrada a partir de um Arquivo e Saida para um Arquivo (`<` e `>`):
    
    É possível combinar o redirecionamento de entrada e saída em um único comando. Dessa forma, a entrada é lida a partir de um arquivo e a saída é redirecionada para outro arquivo.
    Exemplo:
    ```bash
	grep "palavra-chave" < entrada.txt > saida.txt
    ```    
5.  Redirecionamento de Saída de Erro para um Arquivo (`2>`):
    
    O operador `2>` é usado para redirecionar a saída de erro de um comando para um arquivo específico. Isso permite que os erros gerados sejam armazenados em um arquivo separado para posterior análise.
    Exemplo:
	   ```bash
	comando_inexistente 2> erros.txt
	   ```
    
6.  Redirecionamento de Saída de Erro para a Saída Padrão (`2>&1`):
    
    O operador `2>&1` é usado para redirecionar a saída de erro para a saída padrão. Dessa forma, os erros são exibidos junto com a saída normal do comando.
    Exemplo:
    ```bash
    comando_inexistente 2>&1
    ```
# Depuração de scripts
1.  Ativar o Modo de Depuração:
    
    Para depurar um script Bash, você pode ativar o modo de depuração adicionando o comando `set -x` no início do script. Isso exibirá cada comando executado pelo script, juntamente com suas variáveis e expansões.
    Exemplo:
   
    
    ```bash
    #!/bin/bash
    set -x
    
    variavel=10
    echo "O valor da variável é: $variavel"
    ```
2.  Exibir Mensagens de Depuração:
    Você pode inserir mensagens de depuração no script usando o comando `echo` ou `printf`. Isso permite que você verifique o valor das variáveis ou imprima mensagens informativas durante a execução do script.
    Exemplo:  
    ```bash
    #!/bin/bash
    
    variavel=10
    echo "Início da execução do script."
    echo "O valor da variável é: $variavel"
    ```
    
3.  Tratamento de Erros:
    
    É importante tratar erros e exceções em seus scripts para garantir um comportamento adequado. Você pode usar comandos como `if`, `else` e `fi` para verificar condições e lidar com erros de forma apropriada.
    
    Exemplo:
    ```bash
    #!/bin/bash
    
    if [ $# -eq 0 ]; then
      echo "Erro: Nenhum argumento fornecido."
      exit 1
    fi
    
    arquivo=$1
    if [ -f "$arquivo" ]; then
      echo "Arquivo encontrado: $arquivo"
    else
      echo "Arquivo não encontrado: $arquivo"
    fi 
    ```
4.  Uso de `set -e`:
    
    O comando `set -e` faz com que o script seja encerrado imediatamente se ocorrer um erro em qualquer comando. Isso ajuda a identificar problemas rapidamente e evita a execução de comandos subsequentes que possam depender do resultado incorreto.
    Exemplo:  
    ```bash
    #!/bin/bash
    set -e
    
    comando1
    comando2
    comando3
    ```
    
5.  Uso de `set -u`:
    
    O comando `set -u` faz com que o script retorne um erro se uma variável não for definida. Isso é útil para garantir que todas as variáveis necessárias sejam inicializadas corretamente antes de serem usadas.    
    Exemplo:
    ```bash
    #!/bin/bash
    set -u
    
    variavel=
    echo $variavel  # Isso retornará um erro, pois a variável não está definida.
    ```
# AWK

O AWK é uma linguagem de programação e uma ferramenta de manipulação de texto que permite a busca, filtragem, extração e processamento de dados em formato de texto. Ele é especialmente útil para processar dados estruturados em colunas, como arquivos CSV ou de log.

Vamos explorar os principais conceitos e recursos do AWK, juntamente com exemplos de código.

1.  Estrutura básica do comando AWK:
    
    -   O comando AWK é executado da seguinte forma: `awk 'program' arquivo(s)`.
    -   O programa AWK consiste em uma série de padrões e ações.
    -   Um padrão especifica quais linhas devem ser processadas e uma ação determina o que fazer com essas linhas.
2.  Padrões no AWK:
    
    -   Padrões são expressões que determinam quais linhas serão processadas.
    -   Padrões podem ser expressões regulares, valores numéricos, condições lógicas, etc.
    -   Exemplo: `{pattern} {action}`.
3.  Ações no AWK:
    
    -   As ações determinam o que fazer com as linhas que correspondem aos padrões.
    -   As ações podem ser comandos de impressão, atribuições de variáveis, estruturas de controle, etc.
    -   Exemplo: `{pattern} {action}`.
4.  Variáveis pré-definidas do AWK:
    
    -   O AWK fornece várias variáveis pré-definidas que podem ser usadas nas ações.
    -   Exemplos: `$0` (linha completa), `$1` (primeiro campo), `NF` (número de campos), `NR` (número de registro), entre outras.
5.  Funções no AWK:
    
    -   O AWK possui várias funções integradas que podem ser usadas para manipular dados.
    -   Exemplos: `length()` (retorna o comprimento de uma string), `split()` (divide uma string em um array), `tolower()` (converte uma string em minúsculas), etc.

Exemplo básico para ilustrar o uso do AWK:

```bash
# Exemplo: Imprimir o segundo campo de um arquivo CSV
awk -F ',' '{print $2}' arquivo.csv
```

Neste exemplo, usamos o AWK para processar um arquivo CSV e imprimir o segundo campo de cada linha. O parâmetro `-F ','` define a vírgula como o delimitador de campo.


Mais exemplos de como usaro awk
-  Imprimir todas as linhas do arquivo

	```bash
	awk '{print}' arquivo.txt
	```
<br>
Nesse exemplo, o padrão está ausente, então todas as linhas do arquivo serão processadas. A ação simplesmente imprime cada linha.
  
  - Imprimir linhas que contêm a palavra "gato"
	```bash
	awk '/gato/ {print}' arquivo.txt
	```
<br>
Nesse caso, o padrão é a expressão regular `/gato/`, que corresponde a todas as linhas que contêm a palavra "gato". A ação de impressão será executada somente para essas linhas.

-  Imprimir o segundo campo das linhas que começam com "Nome:"
	```bash
	awk '/^Nome:/ {print $2}' arquivo.txt
	```
Aqui, o padrão é a expressão regular `/^Nome:/`, que corresponde a linhas que começam com a palavra "Nome:". A ação de impressão `$2` imprime o segundo campo dessas linhas.

-  Calcular a soma dos números em um arquivo

	```bash
	awk '{soma += $1} END {print soma}' arquivo.txt
	```
Neste exemplo, não há um padrão específico, então todas as linhas serão processadas. A ação `{soma += $1}` acumula a soma dos valores do primeiro campo. A ação `END {print soma}` é executada no final do processamento e imprime o valor final da soma.

-  Converter texto para maiúsculas

```bash
awk '{print toupper($0)}' arquivo.txt
```
Neste caso, a ação `{print toupper($0)}` é aplicada a todas as linhas do arquivo. A função `toupper()` é usada para converter o texto para maiúsculas. `$0` representa a linha completa.


-  Contar o número de linhas em um arquivo

```bash
awk 'END {print NR}' arquivo.txt 
```

Neste exemplo, a ação `END {print NR}` é executada no final do processamento e imprime o número total de linhas no arquivo.

-  Filtrar linhas com base em um valor mínimo

```bash
awk '$1 > 50 {print}' arquivo.txt
```
Aqui, o padrão `$1 > 50` verifica se o valor do primeiro campo é maior que 50. A ação de impressão será executada apenas para as linhas que atendem a esse critério.

- Calcular a média de valores em um arquivo

```bash
awk '{soma += $1; count++} END {print soma/count}' arquivo.txt
```
Neste exemplo, a ação `{soma += $1; count++}` acumula a soma dos valores do primeiro campo e conta o número de valores. A ação `END {print soma/count}` calcula e imprime a média dos valores.

-  Imprimir linhas invertidas
- 
```bash
awk '{linhas[NR] = $0} END {for (i = NR; i >= 1; i--) print linhas[i]}' arquivo.txt
``` 

Aqui, usamos um array `linhas` para armazenar as linhas do arquivo na ordem inversa. A ação `END {for (i = NR; i >= 1; i--) print linhas[i]}` percorre o array e imprime as linhas na ordem inversa.

-  Filtrar e formatar dados em um arquivo CSV

```bash
awk -F ',' '$3 == "ativo" {printf "%-10s %-15s %-10s\n", $1, $2, $4}' arquivo.csv
```

Neste exemplo, usamos `-F ','` para definir a vírgula como o delimitador de campo. O padrão `$3 == "ativo"` verifica se o terceiro campo é igual a "ativo". A ação `printf` formata e imprime os campos 1, 2 e 4 com largura fixa.

# SED

**Introdução ao `sed`:** 

O `sed` é uma ferramenta de linha de comando para edição de fluxo de texto. Ele permite realizar várias operações de manipulação de texto, como substituição, exclusão, inserção e impressão. O `sed` funciona lendo o texto linha por linha, aplicando um conjunto de comandos definidos pelo usuário e gerando a saída modificada.

**Sintaxe básica:** 
A sintaxe básica do comando `sed` é a seguinte:
```bash
sed [opções] 'comando' arquivo
```

-   As opções são modificadores que podem ser usados para alterar o comportamento padrão do `sed`.
-   O comando é uma sequência de ações ou transformações que serão aplicadas às linhas do arquivo.
-   O arquivo é o nome do arquivo que será processado pelo `sed`. Se nenhum arquivo for especificado, o `sed` lerá a entrada padrão.

Alguns comandos
-   `d`: O comando `d` é usado para excluir linhas do arquivo. Quando uma linha corresponde a um padrão específico, ela é excluída do arquivo.
    
-   `s`: O comando `s` é usado para substituir texto em uma linha. Ele substitui a primeira ocorrência de um padrão por um texto especificado.
    
-   `g`: O modificador `g` (global) é usado em conjunto com o comando `s` para substituir todas as ocorrências do padrão em vez de apenas a primeira. Sem o modificador `g`, apenas a primeira ocorrência seria substituída.
    
-   `N`: O comando `N` é usado para ler a próxima linha de entrada e anexá-la à linha atual, separada por um caractere de nova linha. Isso permite que você trabalhe com pares de linhas consecutivas.

Alguns Parâmetros do sed
-   `-n`: Suprime a impressão padrão. Apenas as linhas modificadas ou especificadas serão impressas.
-   `-e <script>`: Especifica um script sed para ser executado.
-   `-f <arquivo>`: Especifica um arquivo contendo um script sed para ser executado.
-   `-i`: Modifica o arquivo de entrada diretamente (operação "in-place").
-   `-r` ou `-E`: Ativa o uso de expressões regulares estendidas em vez de expressões regulares básicas.
-   `-s`: Suprime erros silenciosamente durante a execução do script.
-   `-u`: Desativa o buffering da saída.
-   `-z`: Considera a entrada como texto nulo-delimitado em vez de nova linha-delimitada.
-   `-r <recurso>`: Lê o script sed a partir de um URL ou recurso.
-   `-h` ou `--help`: Exibe a ajuda e informações sobre as opções do comando `sed`.


**Exemplos de uso do `sed`:** 
 Alguns exemplos de uso do `sed` para ilustrar suas funcionalidades:

-  Substituir uma palavra em um arquivo:
	```bash
	sed 's/antigo/novo/' arquivo.txt
	```

	Este comando substitui a primeira ocorrência da palavra "antigo" pela palavra "novo" em cada linha do arquivo `arquivo.txt`.

-  Substituir todas as ocorrências de uma palavra em um arquivo:
	```bash
	sed 's/antigo/novo/g' arquivo.txt
	```

	Ao adicionar a opção `g` no final do comando de substituição, todas as ocorrências da palavra "antigo" serão substituídas pela palavra "novo" em cada linha do arquivo.

-  Excluir linhas que correspondem a um padrão:
	```bash
	sed '/padrao/d' arquivo.txt
	```

	Este comando exclui todas as linhas do arquivo `arquivo.txt` que correspondem ao padrão especificado.

-  Inserir uma linha antes de uma correspondência:
	```bash
	sed '/padrao/i Nova linha' arquivo.txt
	```
	Este comando insere a string "Nova linha" antes de cada linha que corresponde ao padrão especificado no arquivo `arquivo.txt`.

-  Imprimir apenas linhas específicas:
	```bash
	sed -n '2,5p' arquivo.txt
	```

	Com a opção `-n`, o `sed` suprime a impressão padrão das linhas. Neste exemplo, apenas as linhas de 2 a 5 serão impressas.

-  Remover linhas em branco de um arquivo:
	```bash
	sed '/^\s*$/d' arquivo.txt
	```

	Este comando remove todas as linhas em branco (que contêm apenas espaços em branco) do arquivo `arquivo.txt`.

-  Adicionar um número de linha no início de cada linha:
	```bash
	sed = arquivo.txt | sed 'N;s/\n/ /'
	``` 

	Este comando adiciona um número de linha no início de cada linha do arquivo `arquivo.txt`, seguido de um espaço.

-  Substituir a primeira ocorrência de uma palavra em cada linha e imprimir apenas as linhas modificadas:
	```bash
	sed 's/antigo/novo/1p' arquivo.txt
	```

	Neste exemplo, o comando substitui a primeira ocorrência da palavra "antigo" pela palavra "novo" em cada linha do arquivo `arquivo.txt` e imprime apenas as linhas modificadas.

-  Remover a primeira palavra de cada linha:
	```bash
	sed 's/^\S*\s*//' arquivo.txt
	```

	Este comando remove a primeira palavra de cada linha do arquivo `arquivo.txt`.

-  Substituir um bloco de texto entre duas linhas delimitadoras:
	```bash
	sed '/inicio/,/fim/s/antigo/novo/g' arquivo.txt
	```

	Este comando substitui todas as ocorrências da palavra "antigo" pelo "novo" dentro do bloco de texto entre as linhas que contêm "inicio" e "fim" no arquivo `arquivo.txt`.

-  Inserir uma linha após uma correspondência:
	```bash
	sed '/padrao/a Nova linha' arquivo.txt
	```

	Este comando insere a string "Nova linha" após cada linha que corresponde ao padrão especificado no arquivo `arquivo.txt`.

-  Excluir linhas duplicadas consecutivas:
	```bash
	sed '$!N; /^\(.*\)\n\1$/!P; D' arquivo.txt
	```
	Este comando remove linhas duplicadas consecutivas no arquivo `arquivo.txt`.
	

-  Substituir um caractere por outro em uma posição específica:
	```bash
	sed 's/\(.\{3\}\)./\1X/' arquivo.txt
	```

	Neste exemplo, o comando substitui o caractere na posição 4 de cada linha do arquivo `arquivo.txt` por "X".

- Remover todas as tags HTML de um arquivo:

	```bash
	sed 's/<[^>]\+>//g' arquivo.html
	```

	Este comando remove todas as tags HTML do arquivo `arquivo.html`, deixando apenas o texto.

-  Adicionar um cabeçalho no início de um arquivo:
	```bash
	sed '1i Cabeçalho' arquivo.txt
	```

Este comando insere a string "Cabeçalho" como a primeira linha do arquivo `arquivo.txt`.
