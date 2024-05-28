#creando base de datos "hospital"
create database hospital;

use hospital;

#creando tabla "departamento"
CREATE TABLE `hospital`.`department` (
  `id_depart` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_depart`),
  UNIQUE INDEX `id_depart_UNIQUE` (`id_depart` ASC));

#creando tabla "doctor"
CREATE TABLE `hospital`.`doctor` (
  `id_doctor` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `phone` INT NULL,
  `id_depart` INT NOT NULL,
  PRIMARY KEY (`id_doctor`),
  INDEX `id_depart_idx` (`id_depart` ASC),
  CONSTRAINT `id_depart`
    FOREIGN KEY (`id_depart`)
    REFERENCES `hospital`.`department` (`id_depart`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

#creando tabla "paciente"
CREATE TABLE `hospital`.`patient` (
  `id_patient` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `phone` INT NOT NULL,
  PRIMARY KEY (`id_patient`),
  UNIQUE INDEX `id_patient_UNIQUE` (`id_patient` ASC));

#creando tabla "cirugias"
CREATE TABLE `hospital`.`surgeries` (
  `id_surgeries` INT NOT NULL AUTO_INCREMENT,
  `id_doctor` INT NOT NULL,
  `id_patient` INT NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id_surgeries`),
  UNIQUE INDEX `id_surgeries_UNIQUE` (`id_surgeries` ASC),
  INDEX `id_doctor_idx` (`id_doctor` ASC),
  INDEX `id_patient_idx` (`id_patient` ASC),
  CONSTRAINT `id_doctor`
    FOREIGN KEY (`id_doctor`)
    REFERENCES `hospital`.`doctor` (`id_doctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_patient`
    FOREIGN KEY (`id_patient`)
    REFERENCES `hospital`.`patient` (`id_patient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

/* 
	Agregando los nombres de los departamentos. 
	Paso solo el nombre porque el ID es autoincrementado y no es necesario ingresarlo.
*/
insert into department(name) values 
("Cardiologia"),
("Neurologia"),
("General"),
("Pediatria");

#Agregando nombre, apellido, numero de telefono y id de departamento.
insert into doctor(name, surname, phone, id_depart) values
("Meredith","Grey",64828734,3),
("Cristina","Yang",88475743,1),
("Derek","Sheperd",93847598,2),
("Miranda","Bailey",83984793,3),
("Arizona","Robbins",98374985,4),
("Amelia","Sheperd",87634587,2),
("Alex","Karev",87634578,4),
("Margaret","Pierce",98723454,1);

#Agregando nombre, apellido, numero de telefono.
insert into patient (name, surname,phone) values
("Lionel","Messi",87623465),
("Cristiano","Ronaldo",89034342),
("Julian","Alvarez",78645632),
("Charles","Leclerc",23454364),
("Lewis","Hamilton",89765766),
("Novak","Djokovic",64535321),
("Serena","Williams",75666654),
("Aryna","Sabalenka",45345452);

/*
	Agregando id de doctor, id de paciente y fecha.
	Tampoco paso id de corugias porque el id es autoincrementado.
*/
insert into surgeries(id_doctor, id_patient, date) values 
(1,3,"2023-05-13"),
(6,5,"2022-08-17"),
(2,6,"2024-03-21"),
(3,4,"2024-04-20"),
(5,2,"2023-11-01"),
(7,1,"2022-07-20"),
(8,7,"2021-09-11"),
(4,8,"2024-01-15"),
(5,1,"2024-05-25");


/* 
	Seleccionara nombre, apellido,telefono de tabla doctor 
	y nombre de tabla departamento.
	Los ordenara de manera ascendente basandose en el campo
	nombre de la tabla doctor.

	a = doctor
	b = departamento
*/
select a.name, a.surname, a.phone, b.name as department 
from doctor a inner join department b on a.id_depart = b.id_depart 
order by a.name ;

/* 
	Seleccionara nombre, apellido de tabla doctor, 
	nombre, apellido de tabla paciente,
	nombre de tabla departamento,
	fecha de tabla cirugias. 

	El join hace que se conecte el: 
	id_doctor de cirugias con id_doctor de doctor.
	id_patient de cirugias con id_patient de pacientes.
	id_depart de doctor con id_depart de departamento. 

	El ultimo join es posible gracias al join 
	de cirugias con doctor.

	a = cirugias
	b = doctor
	c = paciente
	d = departamento
*/
select b.name as name_doctor, b.surname as surname_doctor,
c.name as name_paciente, c.surname as surname_paciente, d.name as departamento, a.date 
from surgeries a 
inner join doctor b on a.id_doctor = b.id_doctor 
inner join patient c on a.id_patient = c.id_patient
inner join department d on b.id_depart = d.id_depart order by c.name,c.surname;

