create DATABASE if not EXISTS nota_fiscal;

use notaFiscal;

create table if not EXISTS usuario(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
nome  VARCHAR(80) NOT NULL UNIQUE,
senha VARCHAR(256) NOT NULL
);

create table if not EXISTS notas(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
chave_acesso VARCHAR(44) NOT NULL,
codigo INTEGER NOT NULL,
descricao VARCHAR(140) NOT NULL,
valor DECIMAL,
id INTEGER REFERENCES usuario 
);

create table if not EXISTS fornecedor(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
CNPJ_CPF VARCHAR(14) NOT NULL,
nome_fornecedor VARCHAR(80)
);

create table if not EXISTS cliente(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
CNPJ_CPF VARCHAR(14) NOT NULL PRIMARY KEY,
nome_cliente VARCHAR(80)
);

create table if not EXISTS contato(
id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
CEP CHAR(8) NOT NULL,
nomeRua VARCHAR(80) NOT NULL,
bairro VARCHAR(32),
cidade VARCHAR(32),
numero VARCHAR(9) NOT NULL
complemento VARCHAR(64)
);

create table if not EXISTS email(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
enderecoEmail VARCHAR(64) NOT NULL,
id integer NULL REFERENCES contato
);

create table if not EXISTS telefone(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
numerotelefone VARCHAR(11) NOT NULL,
id integer NOT NULL REFERENCES contato
);
