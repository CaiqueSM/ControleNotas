create DATABASE if not EXISTS nota_fiscal;

use nota_fiscal;

create table if not EXISTS usuario(
id_usuario INTEGER PRIMARY KEY AUTO_INCREMENT,
nome_usuario VARCHAR(80) NOT NULL UNIQUE,
senha VARCHAR(256) NOT NULL
);

create table if not EXISTS notas(
chave_acesso CHAR(44) NOT NULL PRIMARY KEY,
codigo INTEGER NOT NULL,
descricao VARCHAR(140) NOT NULL,
valor DECIMAL,
id_usuario INTEGER REFERENCES usuario 
);

create table if not EXISTS fornecedor(
CNPJ_CPF CHAR(14) NOT NULL PRIMARY KEY,
nome_fornecedor VARCHAR(80)
);

create table if not EXISTS cliente(
CNPJ_CPF CHAR(14) NOT NULL PRIMARY KEY,
nome_cliente VARCHAR(80)
);

create table if not EXISTS contato(
id_contato integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
CEP CHAR(8) NOT NULL,
nome_rua VARCHAR(80),
bairro VARCHAR(32),
cidade VARCHAR(32),
numero VARCHAR(9) NOT NULL
);

create table if not EXISTS email(
endereco_email VARCHAR(64) NOT NULL PRIMARY KEY,
id_contato integer NULL REFERENCES contato
);

create table if not EXISTS telefone(
numero_telefone VARCHAR(11) NOT NULL PRIMARY KEY,
id_contato integer NOT NULL REFERENCES contato
);

use nota_fiscal;
insert into usuario(nome_usuario, senha) values('caique2', '12345');
select * from usuario;
drop table usuario;


