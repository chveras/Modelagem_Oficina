-- drop database oficina_mecanica;

-- criando o banco
create database oficina_mecanica;

-- entrando no banco
use oficina_mecanica;

--
-- criando as tabelas
--

-- clientes
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11),
    Address varchar(255),
    Phone char(11),
    Email varchar(45),
    constraint unique_cpf_client unique (CPF)
);
alter table clients auto_increment=1;

-- mecânicos
create table mechanics(
	idMechanic int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11),
    Speciality varchar(100),
    Address varchar(255),
    Phone char(11),
    Email varchar(45),
    constraint unique_cpf_mechanic unique (CPF)
);
alter table mechanics auto_increment=1;

-- pedidos
create table requests(
	idRequest int auto_increment primary key,
    idRequestClient int,
    Rtype_service enum('Reparo','Revisão'),
    Rdescription varchar(255),
    Rstatus enum('Em análise', 'Em execução', 'Liberado'),
    Rmechanic_analyzes int,
    Rmechanic_service int,
    Rdate date,
    constraint fk_request_client foreign key (idRequestClient) references clients(idClient)
			on update cascade
);
alter table requests auto_increment=1;

-- ordens de serviço
create table service_order(
	idService_order int auto_increment primary key,
    idSOrderRequest int,
    Sdate date,
    Stime varchar(10),
    Sservice_price float,
    Spart_price float,
    Stotal_price float,
    Sauthorization binary,
    constraint fk_sorder_request foreign key (idSOrderRequest) references requests(idRequest)
);
alter table service_order auto_increment=1;

-- pagamento
create table payments(
	idPayment int auto_increment primary key,
    idPaymentSorder int,
    typePayment enum('Dinheiro','Crédito','Débito'),
    Pdate date,
    constraint fk_payment_Sorder foreign key (idPaymentSorder) references service_order(idService_order)
);
alter table payments auto_increment=1;

--
-- criando as tabelas de relacionamento N:M
--

-- relação ordem de servido/mecânico
create table SorderMechanic(
	idSMsorder int,
    idSMmechanic int,
    smStatus enum('Em espera', 'Em execução', 'Pronto'),
    primary key (idSMsorder, idSMmechanic),
    constraint fk_Sordermechanic_sorder foreign key (idSMsorder) references service_order(idService_order),
    constraint fk_Sordermechanic_mechanic foreign key (idSMmechanic) references mechanics(idMechanic)
);
