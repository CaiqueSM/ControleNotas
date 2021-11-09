create DATABASE if not EXISTS notafiscal;

use notafiscal;

create table if not EXISTS usuario(
id INTEGER AUTO_INCREMENT,
nome  VARCHAR(80) NOT NULL,
senha VARCHAR(256) NOT NULL,
PRIMARY KEY(id)
);

create table if not EXISTS fornecedor(
id INTEGER NOT NULL,
CNPJ VARCHAR(14),
CPF VARCHAR(11),
nome VARCHAR(80) NOT NULL,
PRIMARY KEY(id)
);

create table if not EXISTS cliente(
id INTEGER NOT NULL,
CNPJ VARCHAR(14),
CPF VARCHAR(11),
nome VARCHAR(80) NOT NULL,
PRIMARY KEY(id)
);

create table if not EXISTS notas(
id INTEGER NOT NULL,
chaveacesso VARCHAR(44) NOT NULL,
codigo INTEGER NOT NULL,
descricao VARCHAR(140) NOT NULL,
valor DECIMAL,
PRIMARY KEY(id),
FOREIGN KEY(id) REFERENCES usuario(id) ON DELETE cascade,
FOREIGN KEY(id) REFERENCES cliente(id) ON DELETE cascade,
FOREIGN KEY(id) REFERENCES fornecedor(id) ON DELETE cascade
);

create table if not EXISTS contato(
id integer AUTO_INCREMENT,
CEP VARCHAR(9) NOT NULL,
rua VARCHAR(80) NOT NULL,
bairro VARCHAR(32),
cidade VARCHAR(32),
numero VARCHAR(9) NOT NULL,
complemento VARCHAR(64),
PRIMARY KEY(id),
FOREIGN KEY(id) REFERENCES cliente(id) ON DELETE cascade,
FOREIGN KEY(id) REFERENCES fornecedor(id) ON DELETE cascade 
);

create table if not EXISTS email(
id INTEGER AUTO_INCREMENT,
email VARCHAR(64) NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(id) REFERENCES contato(id) ON DELETE cascade
);

create table if not EXISTS telefone(
id INTEGER AUTO_INCREMENT,
telefone VARCHAR(14) NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(id) REFERENCES contato(id) ON DELETE cascade
);

use notafiscal;
insert into usuario(nome, senha) values('root', 'root'); 
insert into usuario(nome, senha) values('jeihcio', '123456'); 