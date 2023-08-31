Create database e_ecommerce;
use ecommerce;
create table client (
idclient int auto_increment primary key,
Fname varchar (10),
Lname varchar(10),
CPF char (11) not null,
Adress varchar (30),
constraint unique_cpf_client unique(CPF)
);

CREATE TABLE produtos (
  idprodutos INT AUTO_INCREMENT primary key,
  Fname VARCHAR(10),
  descricao TEXT NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  categoria varchar(20),
  constraint unique_cpf_client unique(CPF)
  );
  
CREATE TABLE fornecedores (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  cnpj VARCHAR(14) NOT NULL,
  inscricao_estadual VARCHAR(14) NOT NULL,
  email VARCHAR(255) NOT NULL,
  telefone VARCHAR(14) NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  cidade VARCHAR(255) NOT NULL,
  estado VARCHAR(255) NOT NULL,
  cep VARCHAR(10) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE pedidosUm (
  id INT NOT NULL AUTO_INCREMENT,
  cliente_id INT NOT NULL,
  produto_id INT NOT NULL,
  quantidade INT NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  data DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (cliente_id) REFERENCES clientes (id),
  FOREIGN KEY (produto_id) REFERENCES produtos (id)
);

CREATE TABLE category (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  descricao TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE vendedores (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  cpf VARCHAR(14) NOT NULL,
  matricula VARCHAR(10) NOT NULL,
  percentual_comissao DECIMAL(10,2) NOT NULL,
  data_admissao DATETIME NOT NULL,
  de_ferias BIT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE payment (
  id INT NOT NULL AUTO_INCREMENT,
  cliente_id INT NOT NULL,
  forma_pagamento VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (cliente_id) REFERENCES clientes (id)
);

CREATE TABLE delivery (
  id INT NOT NULL AUTO_INCREMENT,
  pedido_id INT NOT NULL,
  status VARCHAR(255) NOT NULL,
  codigo_rastreio VARCHAR(255),
  PRIMARY KEY (id),
  FOREIGN KEY (pedido_id) REFERENCES pedidos (id)
);

-- Quantos pedidos foram feitos por cada cliente?
SELECT cliente_id, COUNT(*) AS qtd_pedidos
FROM pedidos
GROUP BY cliente_id;

-- Algum vendedor também é fornecedor?
SELECT vendedores.id, vendedores.nome, fornecedores.id, fornecedores.nome
FROM vendedores
INNER JOIN fornecedores
ON vendedores.cpf = fornecedores.cnpj;

-- Relação de produtos fornecedores e estoques;
SELECT produtos.id, produtos.nome, fornecedores.id, fornecedores.nome, produtos.estoque
FROM produtos
INNER JOIN fornecedores
ON produtos.fornecedor_id = fornecedores.id;

-- Relação de nomes dos fornecedores e nomes dos produtos;
SELECT fornecedores.nome, produtos.nome
FROM fornecedores
INNER JOIN produtos
ON fornecedores.id = produtos.fornecedor_id;


