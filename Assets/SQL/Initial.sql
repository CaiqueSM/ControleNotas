create DATABASE if not EXISTS notafiscal;

use notafiscal;

create table if not EXISTS usuario(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
nome  VARCHAR(80) NOT NULL,
senha VARCHAR(256) NOT NULL
);

create table if not EXISTS notas(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
chaveacesso VARCHAR(44) NOT NULL,
codigo INTEGER NOT NULL,
descricao VARCHAR(140) NOT NULL,
valor DECIMAL,
idusuario INTEGER REFERENCES usuario 
);

create table if not EXISTS fornecedor(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
CNPJ VARCHAR(14),
CPF VARCHAR(11),
nome VARCHAR(80)
);

create table if not EXISTS cliente(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
CNPJ VARCHAR(14),
CPF VARCHAR(11),
nome VARCHAR(80)
);

create table if not EXISTS contato(
id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
CEP VARCHAR(8) NOT NULL,
nomeRua VARCHAR(80) NOT NULL,
bairro VARCHAR(32),
cidade VARCHAR(32),
numero VARCHAR(9) NOT NULL,
complemento VARCHAR(64)
);

create table if not EXISTS email(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
email VARCHAR(64) NOT NULL,
idcontato integer NULL REFERENCES contato
);

create table if not EXISTS telefone(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
telefone VARCHAR(11) NOT NULL,
idcontato integer NOT NULL REFERENCES contato
);

use notafiscal;
insert into usuario(nome, senha) values('root', 'root'); 