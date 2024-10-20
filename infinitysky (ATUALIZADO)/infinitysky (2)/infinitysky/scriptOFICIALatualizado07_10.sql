Create Database bdInfinity; -- creation the database of Infinity Sky enterprise
USE bdInfinity; -- using database --

-- TABELAS --

-- PAÍS --
Create table Pais_tbl(
	id_pais int primary key auto_increment,
    nome_pais varchar(50) not null,
    clima_pais varchar(50) not null,
    comidas_tip varchar(50) not null,
    moeda_pais varchar(20) not null,
    descricao_pais varchar(800) not null
);

-- PLANO --
-- alteração na tabela plano (novo campo parcela e qtd) --
Create table Plano_tbl(
    id_plano int primary key auto_increment,
    nome_plano varchar (100) not null,
    hospedagem_plano varchar(100) not null,
    curso_plano varchar(100) not null,
    instituicao_plano varchar(150) not null,
    periodo_plano varchar(20) not null,
    descricao_plano varchar(800) not null,
    image_plano varchar(255),
    id_pais int not null,
    valor decimal(8,2) NOT NULL,
    parcela_plano varchar (100) not null,
    qtd_plano int,
    constraint Fk_id_pais foreign key (id_pais) references Pais_tbl(id_pais)
);

-- TELEFONE --
create table Telefone_tbl(
	id_telefone int primary key auto_increment,
	telefone_cliente varchar(11) not null
);

-- CLIENTE --
-- tabela cliente oficial com fk na telefone --
create table Cliente_tbl(
	id_cliente int primary key auto_increment,
    nome_cliente varchar(100) not null,
    email_cliente varchar(150) not null,
    senha_cliente varchar(50) not null,
    cpf_cliente varchar(11) not null,
    id_telefone int not null,
    data_nascimento date not null,
    constraint FK_id_telefone_cliente foreign key (id_telefone) references Telefone_tbl(id_telefone),
    constraint UC_cpf_cliente unique (cpf_cliente)
);


-- CARRINHO --
create table Carrinho_tbl(
	id_carrinho int primary key auto_increment,
    itens_carrinho int not null,
    valor_total_carrinho decimal(8,2) not null,
    id_plano int not null,
    id_cliente int not null,
    constraint FK_id_plano_carrinho foreign key (id_plano) references Plano_tbl(id_plano),
    constraint FK_id_cliente_carrinho foreign key (id_cliente) references Cliente_tbl(id_cliente)
);

-- FAVORITOS --
create table Favorito_tbl(
	id_favorito int primary key auto_increment,
    status_favorito varchar(10) not null,
    id_plano int not null,
    id_cliente int not null,
    constraint FK_id_plano_favorito foreign key (id_plano) references Plano_tbl(id_plano),
    constraint FK_id_cliente_favorito foreign key (id_cliente) references Cliente_tbl(id_cliente)
);

-- PAGAMENTO --
create table Pagamento_tbl(
	id_pagamento int primary key auto_increment,
    forma_pagamento varchar(10) not null,
    status_pagamentos varchar(10) not null,
    hora_pagamento time not null,
    valor_pagamento decimal(8,2) not null,
    id_carrinho int not null,
    constraint FK_id_carrinho_pag foreign key (id_carrinho) references Carrinho_tbl(id_carrinho)
);

-- NOTA FISCAL --
create table NF_tbl(
	id_nf int primary key auto_increment,
    valor_nf decimal (8,2),
    data_emissao date not null,
    hora_emissao time not null,
    id_pagamento int not null,
    constraint FK_id_pagamento_nf foreign key (id_pagamento) references Pagamento_tbl(id_pagamento)
);

-- INSERTS NAS TABELAS (PAÍSES E PLANOS) --

-- inserts dos 13 países parceiros da InfinitySky --
INSERT INTO Pais_tbl (id_pais, nome_pais, clima_pais, comidas_tip, moeda_pais, descricao_pais)
VALUES 
(DEFAULT, 'Canadá', 'Temperado, Ártico', 'Poutine; Maple Syrup; Tourtière', 'Dólar Canadense', 'O Canadá é o segundo maior país do mundo, com paisagens diversas como montanhas, florestas e lagos. É conhecido por sua multiculturalidade, cidades como Toronto, Vancouver e Montreal, e seu alto padrão de vida.'),
(DEFAULT, 'Portugal', 'Mediterrâneo', 'Bacalhau; Pastel de Nata; Sardinhas', 'Euro', 'Portugal é um país no sul da Europa conhecido por suas praias, cidades históricas como Lisboa e Porto, e pela sua rica herança cultural e culinária.'),
(DEFAULT, 'EUA', 'Variado', 'Hambúrguer; Hot Dog; BBQ', 'Dólar Americano', 'Os Estados Unidos são uma das maiores economias e destinos turísticos do mundo, com cidades icônicas como Nova York, Los Angeles e Chicago, além de grande diversidade cultural e geográfica.'),
(DEFAULT, 'Argentina', 'Temperado', 'Churrasco; Empanada; Alfajor', 'Peso Argentino', 'A Argentina é famosa por sua cultura vibrante, com destaque para o tango e a paixão pelo futebol. É um dos maiores países da América do Sul, com atrações como Buenos Aires, as Cataratas do Iguaçu e a Patagônia.'),
(DEFAULT, 'Itália', 'Mediterrâneo', 'Pizza; Lasanha; Spaghetti', 'Euro', 'A Itália é um país localizado no sul da Europa, famoso por sua rica história, arte e cultura, com cidades icônicas como Roma, Florença e Veneza. É um destino popular para turismo, oferecendo uma mistura de patrimônio histórico e belezas naturais.'),
(DEFAULT, 'Espanha', 'Mediterrâneo', 'Paella; Gazpacho; Tortilla', 'Euro', 'A Espanha é conhecida por suas cidades vibrantes como Madrid e Barcelona, seu clima variado, culinária de renome mundial e sua cultura rica, repleta de festas tradicionais.'),
(DEFAULT, 'Alemanha', 'Temperado', 'Salsicha; Chucrute; Pretzel', 'Euro', 'A Alemanha é uma potência econômica da Europa, com cidades históricas como Berlim, Munique e Frankfurt. Conhecida por sua eficiência e tecnologia, também oferece uma rica herança cultural e paisagens belíssimas.'),
(DEFAULT, 'Austrália', 'Tropical', 'Vegemite; Pavlova; Carneiro Assado', 'Dólar Australiano', 'A Austrália é um continente e país no hemisfério sul, conhecido por suas praias, florestas e desertos, além de sua vida selvagem única. As principais cidades incluem Sydney, Melbourne e Brisbane.'),
(DEFAULT, 'Inglaterra', 'Temperado', 'Fish and Chips; Roast Beef; Shepherd\'s Pie', 'Libra Esterlina', 'Inglaterra é parte do Reino Unido, famosa por sua história rica, instituições renomadas como a Universidade de Oxford, e cidades como Londres e Manchester.'),
(DEFAULT, 'França', 'Mediterrâneo, Oceânico', 'Croissant; Baguette; Ratatouille', 'Euro', 'A França é um dos destinos turísticos mais populares do mundo, conhecida por sua história, arte e culinária. Paris, a capital, é um centro global de cultura e moda.'),
(DEFAULT, 'Irlanda', 'Oceânico', 'Irish Stew; Soda Bread; Boxty', 'Euro', 'A Irlanda é conhecida por sua paisagem verdejante, cidades históricas como Dublin e Cork, e sua cultura vibrante, marcada pela música tradicional e literatura.'),
(DEFAULT, 'Japão', 'Subtropical, Temperado', 'Sushi; Ramen; Tempura', 'Iene', 'O Japão é uma nação insular no leste da Ásia, famosa por sua tecnologia avançada, cultura tradicional e cidades vibrantes como Tóquio, Kyoto e Osaka.'),
(DEFAULT, 'Coreia do Sul', 'Subtropical', 'Kimchi; Bibimbap; Bulgogi', 'Won', 'A Coreia do Sul é um país altamente desenvolvido, conhecido por sua indústria tecnológica, música pop (K-pop) e cultura rica. Cidades como Seul e Busan são grandes centros culturais e econômicos.');

-- inserts dos planos desses países --
-- inserts do canadá --
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES 
('Vancouver - 6 Meses', 'Homestay', 'Inglês', 'ILAC Vancouver', '6 meses', 'Curso intensivo de inglês em Vancouver na ILAC, uma das escolas mais renomadas do Canadá.', 'Imagens/planocanada1.png', 1, 12000.00, 'Em até 12x de R$1000.00', 5),
('Toronto - 4 Meses', 'Residência Estudantil', 'Inglês', 'EC Toronto', '4 meses', 'Estudo intensivo de inglês na EC Toronto, localizada no coração da cidade.', 'Imagens/planocanada2.png', 1, 15000.00, 'Em até 12x de R$1250.00', 6),
('Montreal - 8 Meses', 'Homestay', 'Inglês e Francês', 'LSC Montreal', '8 meses', 'Curso bilíngue de inglês e francês em Montreal, oferecido pela LSC.', 'Imagens/planocanada3.png', 1, 18000.00, 'Em até 12x de R$1500.00', 7);
				
-- Portugal --
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES 
('Lisboa - 6 Meses', 'Homestay', 'Português', 'Lusa Language School', '6 meses', 'Curso intensivo de português em Lisboa, na Lusa Language School.', 'Imagens/planolusa1.png', 2, 10000.00, 'Em até 12x de R$833.33', 1),
('Porto - 3 Meses', 'Residência Estudantil', 'Português', 'Fast Forward Language Institute', '3 meses', 'Estudo intensivo de português em Porto.', 'Imagens/planolusa2.png', 2, 8000.00, 'Em até 12x de R$666.67', 1),
('Lisboa - 1 Ano', 'Homestay', 'Português', 'CIAL Centro de Línguas', '1 ano', 'Curso avançado de português em Lisboa, oferecido pelo CIAL Centro de Línguas.', 'Imagens/planolusa3.png', 2, 20000.00, 'Em até 12x de R$1666.67', 1);
				
-- Estados Unidos --
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES 
('Nova York - 6 Meses', 'Residência Estudantil', 'Inglês', 'Kaplan International NY', '6 meses', 'Curso de inglês em Nova York, oferecido pela Kaplan International.', 'Imagens/planoestadosunidos1.png', 3, 18000.00, 'Em até 12x de R$1500.00', 1),
('Los Angeles - 4 Meses', 'Homestay', 'Inglês', 'EC Los Angeles', '4 meses', 'Curso intensivo de inglês na EC Los Angeles.', 'Imagens/planoestadosunidos2.png', 3, 16000.00, 'Em até 12x de R$1333.33', 1),
('Miami - 1 Ano', 'Homestay', 'Inglês', 'ELS Language Centers Miami', '1 ano', 'Estudo de inglês de longa duração no ELS Language Centers, em Miami.', 'Imagens/planoestadosunidos3.png', 3, 30000.00, 'Em até 12x de R$2500.00', 1);

-- Argentina --
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES 
('Buenos Aires - 6 Meses', 'Homestay', 'Espanhol', 'Academia Buenos Aires', '6 meses', 'Curso intensivo de espanhol em Buenos Aires, oferecido pela Academia Buenos Aires.', 'Imagens/planoargentina1.png', 4, 10000.00, 'Em até 12x de R$833.33', 1),
('Córdoba - 3 Meses', 'Residência Estudantil', 'Espanhol', 'Set Idiomas Córdoba', '3 meses', 'Curso de espanhol em Córdoba, uma das cidades mais vibrantes da Argentina.', 'Imagens/planoargentina2.png', 4, 8000.00, 'Em até 12x de R$666.67', 1),
('Mendoza - 1 Ano', 'Homestay', 'Espanhol', 'Intercultural Mendoza', '1 ano', 'Curso avançado de espanhol em Mendoza, cidade conhecida por seus vinhos e montanhas.', 'Imagens/planoargentina3.png', 4, 15000.00, 'Em até 12x de R$1250.00', 1);

-- Italia --
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES 
('Roma - 6 Meses', 'Homestay', 'Italiano', 'Scuola Leonardo da Vinci', '6 meses', 'Curso intensivo de italiano em Roma, oferecido pela Scuola Leonardo da Vinci.', 'Imagens/planoitalia1.png', 5, 12000.00, 'Em até 12x de R$1000.00', 1),
('Florença - 4 Meses', 'Residência Estudantil', 'Italiano', 'Centro Fiorenza', '4 meses', 'Curso intensivo de italiano em Florença, cidade do Renascimento.', 'Imagens/planoitalia2.png', 5, 10000.00, 'Em até 12x de R$833.33', 1),
('Milão - 1 Ano', 'Homestay', 'Italiano', 'Scuola Italiana Milano', '1 ano', 'Curso de italiano de longa duração em Milão, centro da moda e design.', 'Imagens/planoitalia3.png', 5, 18000.00, 'Em até 12x de R$1500.00', 1);

-- Espanha-- 
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES 
('Barcelona - 6 Meses', 'Homestay', 'Espanhol', 'Don Quijote Barcelona', '6 meses', 'Curso intensivo de espanhol em Barcelona, oferecido pela Don Quijote.', 'Imagens/planoespanha1.png', 6, 11000.00, 'Em até 12x de R$916.67', 1),
('Madri - 3 Meses', 'Residência Estudantil', 'Espanhol', 'Enforex Madrid', '3 meses', 'Curso intensivo de espanhol em Madri, a capital da Espanha.', 'Imagens/planoespanha2.png', 6, 9000.00, 'Em até 12x de R$750.00', 1),
('Sevilha - 1 Ano', 'Homestay', 'Espanhol', 'Clic International House', '1 ano', 'Curso avançado de espanhol em Sevilha, cidade histórica da Andaluzia.', 'Imagens/planoespanha3.png', 6, 20000.00, 'Em até 12x de R$1666.67', 1);

-- Alemanha -- 
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES 
('Berlim - 6 Meses', 'Homestay', 'Alemão', 'Goethe-Institut Berlim', '6 meses', 'Curso intensivo de alemão no Goethe-Institut em Berlim.', 'Imagens/planoalemanha1.png', 7, 15000.00, 'Em até 12x de R$1250.00', 1),
('Munique - 4 Meses', 'Residência Estudantil', 'Alemão', 'DID Deutsch-Institut Munique', '4 meses', 'Curso de alemão em Munique, centro cultural da Baviera.', 'Imagens/planoalemanha2.png', 7, 12000.00, 'Em até 12x de R$1000.00', 1),
('Frankfurt - 1 Ano', 'Homestay', 'Alemão', 'Sprachcaffe Frankfurt', '1 ano', 'Curso avançado de alemão em Frankfurt, cidade financeira da Alemanha.', 'Imagens/planoalemanha3.png', 7, 22000.00, 'Em até 12x de R$1833.33', 1);

-- Austrália --
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES 
('Sydney - 6 Meses', 'Homestay', 'Inglês', 'Navitas English Sydney', '6 meses', 'Curso intensivo de inglês em Sydney, oferecido pela Navitas.', 'Imagens/planoaustralia1.png', 8, 14000.00, 'Em até 12x de R$1166.67', 1),
('Melbourne - 4 Meses', 'Residência Estudantil', 'Inglês', 'IH Melbourne', '4 meses', 'Curso de inglês em Melbourne, uma das cidades mais dinâmicas da Austrália.', 'Imagens/planoaustralia2.png', 8, 12000.00, 'Em até 12x de R$1000.00', 1),
('Brisbane - 1 Ano', 'Homestay', 'Inglês', 'Langports Brisbane', '1 ano', 'Curso intensivo de inglês em Brisbane, cidade com clima tropical e praias.', 'Imagens/planoaustralia3.png', 8, 25000.00, 'Em até 12x de R$2083.33', 1);

-- Inglaterra --
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES 
('Londres - 6 Meses', 'Homestay', 'Inglês', 'The London School of English', '6 meses', 'Curso de inglês em Londres, uma das cidades mais famosas do mundo.', 'Imagens/planoreinounido1.png', 9, 18000.00, 'Em até 12x de R$1500.00', 1),
('Manchester - 4 Meses', 'Residência Estudantil', 'Inglês', 'EC Manchester', '4 meses', 'Curso intensivo de inglês em Manchester.', 'Imagens/planoreinounido2.png', 9, 14000.00, 'Em até 12x de R$1166.67', 1),
('Brighton - 1 Ano', 'Homestay', 'Inglês', 'EF Brighton', '1 ano', 'Curso avançado de inglês em Brighton, cidade costeira popular entre estudantes.', 'Imagens/planoreinounido3.png', 9, 25000.00, 'Em até 12x de R$2083.33', 1);

-- França --
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES
('Paris - 6 Meses', 'Homestay', 'Francês', 'Alliance Française Paris', '6 meses', 'Curso de francês em Paris, oferecido pela renomada Alliance Française.', 'Imagens/planofranca1.png', 10, 16000.00, 'Em até 12x de R$1333.33', 1),
('Lyon - 3 Meses', 'Residência Estudantil', 'Francês', 'Inflexyon Lyon', '3 meses', 'Curso intensivo de francês em Lyon, famosa por sua gastronomia e cultura.', 'Imagens/planofranca2.png', 10, 12000.00, 'Em até 12x de R$1000.00', 1),
('Nice - 1 Ano', 'Homestay', 'Francês', 'Azurlingua', '1 ano', 'Curso de francês avançado em Nice, cidade costeira do sul da França.', 'Imagens/planofranca3.png', 10, 24000.00, 'Em até 12x de R$2000.00', 1);

-- Irlanda --
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES
('Dublin - 6 Meses', 'Homestay', 'Inglês', 'Dublin School of English', '6 meses', 'Curso intensivo de inglês em Dublin, oferecido pela Dublin School of English.', 'Imagens/planoirlanda1.png', 11, 13000.00, 'Em até 12x de R$1083.33', 1),
('Cork - 4 Meses', 'Residência Estudantil', 'Inglês', 'Cork English Academy', '4 meses', 'Curso de inglês em Cork, cidade cultural da Irlanda.', 'Imagens/planoirlanda2.png', 11, 11000.00, 'Em até 12x de R$916.67', 1),
('Galway - 1 Ano', 'Homestay', 'Inglês', 'Atlantic Language Galway', '1 ano', 'Curso de inglês avançado em Galway, conhecida por sua música e festivais.', 'Imagens/planoirlanda3.png', 11, 22000.00, 'Em até 12x de R$1833.33', 1);

-- Japão --
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES
('Tóquio - 6 Meses', 'Homestay', 'Japonês', 'Kudan Institute of Japanese Language', '6 meses', 'Curso intensivo de japonês em Tóquio, oferecido pelo Kudan Institute.', 'Imagens/planojapao1.png', 12, 18000.00, 'Em até 12x de R$1500.00', 1),
('Quioto - 3 Meses', 'Residência Estudantil', 'Japonês', 'GenkiJACS Kyoto', '3 meses', 'Curso de japonês em Quioto, antiga capital do Japão e berço da cultura tradicional.', 'Imagens/planojapao2.png', 12, 15000.00, 'Em até 12x de R$1250.00', 1),
('Osaka - 1 Ano', 'Homestay', 'Japonês', 'Osaka Japanese Language Academy', '1 ano', 'Curso avançado de japonês em Osaka, cidade vibrante e moderna do Japão.', 'Imagens/planojapao3.png', 12, 28000.00, 'Em até 12x de R$2333.33', 1);

-- Coreia do sul--
INSERT INTO Plano_tbl (nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, image_plano, id_pais, valor, parcela_plano, qtd_plano)
VALUES
('Seul - 6 Meses', 'Homestay', 'Coreano', 'Korea University Sejong Campus', '6 meses', 'Curso intensivo de coreano em Seul, oferecido pela Korea University.', 'Imagens/planocoreiasul1.png', 13, 17000.00, 'Em até 12x de R$1416.67', 1),
('Busan - 4 Meses', 'Residência Estudantil', 'Coreano', 'Pusan National University', '4 meses', 'Curso de coreano em Busan, cidade costeira famosa por suas praias.', 'Imagens/planocoreiasul2.png', 13, 14000.00, 'Em até 12x de R$1166.67', 1),
('Incheon - 1 Ano', 'Homestay', 'Coreano', 'Inha University', '1 ano', 'Curso avançado de coreano em Incheon, cidade moderna próxima a Seul.', 'Imagens/planocoreiasul3.png', 13, 25000.00, 'Em até 12x de R$2083.33', 1);


-- PROCEDURES --
-- procedure que separa os planos em sessões --
Delimiter //
create procedure SelecionarPlanosPorPaisIdsO(IN PaisId INT)
begin
    select
        p.id_plano,
        p.nome_plano, 
        p.hospedagem_plano, 
        p.curso_plano, 
        p.instituicao_plano, 
        p.periodo_plano, 
        p.descricao_plano, 
        p.image_plano, 
		p.id_pais,
        p.valor, 
        p.parcela_plano, 
        p.qtd_plano,
        pa.nome_pais
    from 
        Plano_tbl p
    inner join
        Pais_tbl pa ON p.id_pais = pa.id_pais
    where 
        pa.id_pais = PaisId;
end //
Delimiter ;


-- consultar telefone do User --
Delimiter $$
create procedure spSelectTelefone(vId_cliente int)
begin
	if exists (select * from Telefone_tbl where id_cliente = vId_cliente) then
		select telefone_cliente from Telefone_tbl where id_cliente = vId_cliente;
	end if;
end $$
call spselectTelefone(1);


-- Primeiro será consultar carrinho do User --
Delimiter $$
create procedure spSelectcarrinho(vId_cliente int)
begin
	if exists (select * from Carrinho_tbl where id_cliente = vId_cliente) then
		select * from Cliente_tbl where id_cliente = vId_cliente;
    end if;
end $$
call spselectcarrinho(1);
call spselectcarrinho(2);


-- Segundo consultar Favorito do User --
Delimiter $$
create procedure spSelectfavorito(vId_cliente int)
begin
	if exists (select * from Favorito_tbl where id_cliente = vId_cliente) then
		select * from Cliente_tbl where id_cliente = vId_cliente;
	end if;
end $$
call spselectfavorito(1);


-- 2º realizar insert no favorito do User --
Delimiter $$
create procedure spInsertFavorito(vStatus_favorito varchar(10), vId_plano int, vId_cliente int)
begin
	if exists (select * from Cliente_tbl where id_cliente = vId_Cliente) then
	insert into Favorito_tbl(status_favorito, id_plano, id_cliente)
		values(vStatus_favorito, vId_plano, vId_cliente);
	end if;
end $$
call spInsertFavorito('salvo', 2, 2);
					
					
-- atualiza registro do favorito --
Delimiter $$
create procedure spUpdateFavorito(vStatus_favorito varchar(10), vId_plano int, vId_cliente int)
begin
	if exists (select * from Cliente_tbl where id_cliente = vId_Cliente) then
		update Favorito_tbl set status_favorito = vStatus_favorito, id_plano = vId_plano
			where id_cliente = vId_cliente;
    end if;
end $$
call spUpdateFavorito('salvo', 2, 2);


-- 2º realizar updated no carrinho(itens_carrinho, valor_total_carrinho) do User --
Delimiter $$
create procedure spUpdatedCarrinho(vItens_carrinho int, vId_plano int, vId_cliente int)
begin
	if exists(select * from Cliente_tbl where id_cliente = vId_cliente) then
		update Carrinho_tbl set iten_carrinho = vItens_carrinho, id_plano = vId_plano where id_cliente = vId_cliente;
    end if;
end $$

call spUpdatedCarrinho();


-- 1º realizar insert no carrinho do User --
Delimiter $$
create procedure spInsertCarrinho(vItens_carrinho int, vValor_total_carrinho decimal(8,2), vId_pais int, vId_cliente int)
begin
	if exists (select * from Cliente_tbl where id_cliente = vId_Cliente) then
	insert into Carrinho_tbl(vItens_carrinho, vValor_total_carrinho, vId_pais, vId_cliente)
		values(itens_carrinho, valor_total_pagamento, id_pais, id_cliente);
	end if;
end $$
call spinsertCarrinho();


-- 4º realizar insert no pagamento do User --
Delimiter $$
create procedure spInsertPagamento(vForma_pagamento varchar(10), vStatus_pagamento varchar(10), vHora_pagamento time, vValor_pagamento decimal(8,2), vId_carrinho int)
begin
	if exists (select * from Carrinho_tbl where id_carrinho = vId_carrinho) then
	insert into Pagamento_tbl(forma_pagamento, status_pagamento, hora_pagamento, valor_pagamento, id_carrinho)
		values(vForma_pagamento, vStatus_pagamento, vHora_pagamento, vValor_pagamento, vId_carrinho);
	end if;
end $$
call spinsertPagamento();


-- 5º realizar insert nf do User --
Delimiter $$
create procedure spInsertNF(vValor_nf decimal(8,2), vData_emissao date, vHora_emissao time, vId_pagamento int)
begin
	insert into NF_tbl(valor_nf, data_emissao, hora_emissao, id_pagamento)
		values(vValor_nf, vData_emissao, vHora_emissao, vId_pagamento);
end $$
call spinsertNF();


-- inserindo na tb Pais, caso precise, pois não haverá no sistema inserção de país, serão só os parceiros --
/*Delimiter $$
create procedure spInsertPais(vNome_pais varchar(50), vClima_pais varchar(50), vComidas_tip varchar(50), vMoeda_pais varchar(20), vDescricao_pais varchar(800), vImage_pais varchar(50))
begin
	insert into Pais_tbl(nome_pais, clima_pais, comidas_tip, moeda_pais, descricao_pais, image_pais)
		values(vNome_pais, vClima_pais, vComidas_tip, vMoeda_pais, vDescricao_pais, vImage_pais);
end $$*/


-- inserindo na tb Plano --
Delimiter $$
create procedure spInsertPlano(vNome_plano varchar(50), vHospedagem_plano varchar(100), vCurso_plano varchar(100), vInstituicao_plano varchar(150), vPeriodo_plano varchar(20), vDescricao_plano varchar(800), vValor_plano decimal(8,2), vId_pais int)
begin
	insert into Plano_tbl(nome_plano, hospedagem_plano, curso_plano, instituicao_plano, periodo_plano, descricao_plano, valor_plano, id_pais)
		values(vNome_plano, vHospedagem_plano, vCurso_plano, vInstituicao_plano, vPeriodo_plano, vDescricao_plano,vValor_plano, vId_pais);
end $$
call spInsertPlano();


-- inserindo na tb Cliente --
Delimiter $$
create procedure spInsertCliente(vNome_cliente varchar(100), vEmail_cliente varchar(150), vSenha_cliente varchar(10), vCpf_cliente varchar(11), vImage_cliente varchar(50), vId_telefone int, vData_nascimento date)
begin
	insert into Cliente_tbl(nome_cliente, email_cliente, senha_cliente, cpf_cliente, image_cliente, id_telefone, data_nascimento)
		values(vNome_cliente, vEmail_cliente, vSenha_cliente, vCpf_cliente, vImage_cliente, vId_telefone, vData_nascimento);
end $$
call spInsertCliente('roger', 'roger@gmail.com', 'fretrog', '24356787890', '', 3, '2000-08-08');


-- TRIGGERS NAS TABELAS HISTÓRICO --

-- tabela histórico Carrinho --
Create table HistoricoCarrinho like Carrinho_tbl;

Delimiter $$
Create trigger Trg_Carrinho after insert on Carrinho_tbl
	for each row
begin
	insert into HistoricoCarrinho
		set id_carrinho = new.id_carrinho,
			itens_carrinho = new.itens_carrinho,
            valor_total_carrinho = new.valor_total_carrinho,
            id_plano = new.id_plano,
            id_cliente = new.id_cliente,
            atualizacao_carrinho = current_timestamp(),
            situacao_carrinho = 'novo';
end$$

 -- drop trigger Trg_Favorito;

-- tabela histórico Favorito --
Create table HistoricoFavorito like Favorito_tbl;

Delimiter $$
Create trigger Trg_Favorito after insert on Favorito_tbl
	for each row
begin
	insert into HistoricoFavorito
		set id_favorito = new.id_favorito,
			status_favorito = new.status_favorito,
            id_plano = new.id_plano,
            id_cliente = new.id_cliente,
            atualizacao_favorito = current_timestamp(),
            situacao_favorito = 'novo';
end$$

-- tabela histórico Cliente --
Create table HistoricoCliente like Cliente_tbl;

Delimiter $$
Create trigger Trg_Cliente after insert on Cliente_tbl
	for each row
begin
	insert into HistoricoCliente
    set id_cliente = new.id_cliente,
		nome_cliente = new.nome_cliente,
        email_cliente = new.email_cliente,
        senha_cliente = new.senha_cliente,
        cpf_cliente = new.cpf_cliente,
        image_cliente = new.image_cliente,
        id_telefone = new.id_telefone,
        data_nascimento = new.data_nascimento,
        atualizacao_cliente = current_timestamp(),
        situacao_cliente = 'novo cliente!';
end$$

-- tabela histórico Pagamento --
Create table HistoricoPagamento like Pagamento_tbl;

Delimiter $$
Create trigger Trg_Pagamento after insert on Pagamento_tbl
	for each row
begin
	insert into HistoricoPagamento
    set id_pagamento = new.id_pagamento,
    forma_pagamento = new.forma_pagamento,
    status_pagamentos = new.status_pagamento,
    hora_pagamento = new.hora_pagamento,
    valor_pagamento = new.valor_pagamento,
    id_carrinho = new.id_carrinho,
    atualizacao_pagamento = current_timestamp(),
    situacao_pagamento = 'adicionado';
end$$

-- JOINS E VIEWS --
create view Vw_Planos as
select * from Plano_tbl inner join Cliente_tbl on id_plano = id_cliente;

-- DESCRIBES --                        
describe Pais_tbl;
describe Plano_tbl;
describe Cliente_tbl;
describe Carrinho_tbl;
describe Favorito_tbl;
describe Pagamento_tbl;
describe Telefone_tbl;
describe NF_tbl;
describe HistoricoCarrinho;
describe HistoricoFavorito;
describe HistoricoCliente;
describe HistoricoPagamento;

-- SELECTS --                        
select * from Pais_tbl;
select * from Plano_tbl;
select * from Cliente_tbl;
select * from Carrinho_tbl;
select * from Favorito_tbl;
select * from Pagamento_tbl;
select * from Telefone_tbl;
select * from NF_tbl;
select * from HistoricoCarrinho;
select * from HistoricoFavorito;
select * from HistoricoCliente;
select * from HistoricoPagamento;
select * from Vw_Planos;

-- ALTERS TABLE (NÃO RECOMENDÁVEL) NAS TABELAS --                        
alter table HistoricoCarrinho modify column id_carrinho int not null;
alter table HistoricoCarrinho drop primary key;
alter table HistoricoCarrinho add atualizacao_carrinho datetime;
alter table HistoricoCarrinho add situacao_carrinho varchar(20);
alter table HistoricoCarrinho add constraint PK_Id_HistoricoCarrinho primary key(id_carrinho, atualizacao_carrinho, situacao_carrinho);
alter table HistoricoFavorito modify column id_favorito int not null;
alter table HistoricoFavorito drop primary key;
alter table HistoricoFavorito add atualizacao_favorito datetime;
alter table HistoricoFavorito add situacao_favorito varchar(20);
alter table HistoricoFavorito add constraint PK_Id_HistoricoFavorito primary key(id_favorito, atualizacao_favorito, situacao_favorito);
alter table HistoricoCliente modify column id_cliente int not null;
alter table HistoricoCliente drop primary key;
alter table HistoricoCliente add atualizacao_cliente datetime;
alter table HistoricoCliente add situacao_cliente varchar(20);
alter table HistoricoCliente add constraint PK_Id_Cliente primary key(id_cliente, atualizacao_cliente, situacao_cliente);

-- SHOWS --                        
show databases;
show tables;
show variables like "sql_safe_updates";

-- FUNÇÕES DE TEMPO, SUER, DATA... --                        
select current_date();
select current_time();
select current_user();
set sql_safe_updates = 0;

-- DROPS --                        
drop database bd_infinity;
drop table Pais_tbl;
drop table Plano_tbl;
drop table Cliente_tbl;
drop table Carrinho_tbl;
drop table Favorito_tbl;
drop table Pagamento_tbl;
drop table Telefone_tbl;
drop table NF_tbl;
drop procedure spInsertCliente;
drop view Vw_Planos;