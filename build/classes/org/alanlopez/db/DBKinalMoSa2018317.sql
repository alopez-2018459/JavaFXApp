Drop database if exists DBKinalMoSa2018317;
Create database DBKinalMoSa2018317;

Use DBKinalMoSa2018317;

Create table Pacientes(
	codigoPaciente int not null,
    nombresPaciente varchar(50) not null,
    apellidosPaciente varchar(50) not null,
    sexo char not null,
    fechaNacimiento date not null,
    direccionPaciente varchar(100) not null,
    telefonoPersonal varchar(8),
    fechaPrimeraVisita date,
    primary key PK_codigoPaciente (codigoPaciente)
);

Create table Especialidades(
	codigoEspecialidad int not null auto_increment,
    descripcion varchar(100) not null,
    primary key PK_codigoEspecialidad (codigoEspecialidad)
);

Create table Medicamentos(
	codigoMedicamento int not null auto_increment,
    nombreMedicamento varchar(100) not null,
    primary key PK_codigoMedicamento (codigoMedicamento)
);

Create table Doctores(
	 numeroColegiado int not null,
     nombresDoctor varchar(50) not null,
     apellidosDoctor varchar(50) not null,	
     telefonoContacto varchar(8) not null,
     codigoEspecialidad int not null,
     primary key PK_numeroColegiado (numeroColegiado),
     constraint FK_Doctores_Especialidades foreign key (codigoEspecialidad)
		references Especialidades (codigoEspecialidad)
);

Create table Recetas(
	codigoReceta int not null auto_increment,
    fechaReceta date not null,
    numeroColegiado int not null,
    primary key PK_codigoReceta (codigoReceta),
    constraint FK_Recetas_Doctores foreign key (numeroColegiado)
		references Doctores (numeroColegiado)
);

Create table Citas(
	codigoCita int not null auto_increment,
    fechaCita date not null,
    horaCita time not null,
    tratamiento varchar(150),
    descripcionCondicionActual varchar(150) not null,
    codigoPaciente int not null,
    numeroColegiado int not null,
    primary key PK_codigoCita (codigoCita),
    constraint FK_Citas_Pacientes foreign key (codigoPaciente)
		references Pacientes (codigoPaciente),
    constraint FK_Citas_Doctores foreign key (numeroColegiado)
		references Doctores (numeroColegiado)
);

Create table DetalleReceta(
	codigoDetalleReceta int not null auto_increment,
    dosis varchar(100) not null,
    codigoReceta int not null,
    codigoMedicamento int not null,
    primary key PK_codigoDetalleReceta (codigoDetalleReceta),
    constraint FK_DetalleReceta_Recetas foreign key (codigoReceta)
		references Recetas (codigoReceta),
	constraint FK_DetalleReceta_Medicamentos foreign key (codigoMedicamento)
		references Medicamentos (codigoMedicamento)
);

-- ------------------------------- PROCEDIMIENTOS ALMACENADOS -------------------------------
-- --------------------------------------- PACIENTES ----------------------------------------
-- --------- Agregar Pacientes ---------
Delimiter $$
Create procedure sp_AgregarPaciente (in codigoPaciente int, in nombresPaciente varchar(50), in apellidosPaciente varchar(50), in sexo char, in fechaNacimiento date,
									in direccionPaciente varchar(100), in telefonoPersonal varchar(8), in fechaPrimeraVisita date)
	Begin
		Insert into Pacientes (codigoPaciente, nombresPaciente, apellidosPaciente, sexo, fechaNacimiento, direccionPaciente, telefonoPersonal, fechaPrimeraVisita)
			Values(codigoPaciente, nombresPaciente, apellidosPaciente, upper(sexo), fechaNacimiento, direccionPaciente, telefonoPersonal, fechaPrimeraVisita);
    End$$
Delimiter ;

call sp_AgregarPaciente (1001, 'Angel Fernando', 'Cañeñas Vasquez', 'm', '2001-01-24', 'zona 2 ave. 5 A-8', '65483215', curdate());
call sp_AgregarPaciente (1002, 'José Miguel', 'Perez Castillo', 'm', '1996-08-10', 'zona 1 ave. 1 C-5', '94836966', curdate());
call sp_AgregarPaciente (1003, 'Alan René', 'Villatoro Velasquez', 'm', '1999-07-29', 'zona 10 ave. 8 C-10', '89106976', curdate());

-- --------- Listar Pacientes ---------
Delimiter $$
Create procedure sp_ListarPaciente()
	Begin
		Select
			P.codigoPaciente,
            P.nombresPaciente,
            P.apellidosPaciente,
            P.sexo,
            P.fechaNacimiento,
            P.direccionPaciente,
            P.telefonoPersonal,
            P.fechaPrimeraVisita
		From Pacientes P;
    End$$
Delimiter ;

call sp_ListarPaciente();

-- --------- Buscar Paciente ---------
Delimiter $$
	Create procedure sp_BuscarPaciente(in codPaciente int)
		Begin
			Select
				P.codigoPaciente,
				P.nombresPaciente,
				P.apellidosPaciente,
				P.sexo,
				P.fechaNacimiento,
				P.direccionPaciente,
				P.telefonoPersonal,
				P.fechaPrimeraVisita
            From Pacientes P
				where codigoPaciente = codPaciente;
		End$$
Delimiter ;

call sp_BuscarPaciente(1001);

-- --------- Eliminar Paciente ---------
Delimiter $$
	Create procedure sp_EliminarPaciente (in codPaciente int)
		Begin
			delete from Pacientes
				where codigoPaciente = codPaciente;
		End$$
Delimiter ;

call sp_EliminarPaciente(1003);
call sp_ListarPaciente();

-- --------- Editar Paciente ---------
Delimiter $$
	Create Procedure sp_EditarPaciente (in codPaciente int, in nomPaciente varchar(50), in apellPaciente varchar(50), in sex char, in fechaNaci date,
										in direcPaciente varchar(100), in telPersonal varchar(8), in fechaPV date) 
		Begin
			Update Pacientes P
				set
					P.nombresPaciente = nomPaciente,
                    P.apellidosPaciente = apellPaciente,
                    P.sexo = upper(sex),
                    P.fechaNacimiento = fechaNaci,
                    P.direccionPaciente = direcPaciente,
                    P.telefonoPersonal = telPersonal,
                    P.fechaPrimeraVisita = fechaPV
					where codigoPaciente = codPaciente;
        End$$
Delimiter ;

call sp_EditarPaciente(1002, 'Angel Alejandro', 'Morales Vasquez', 'm', '2000-01-26', 'zona 12 ave. 5 A-10', '65449215', curdate());
call sp_ListarPaciente();

-- --------------------------------------- PACIENTES ----------------------------------------
-- --------- Agregar Especialidades ---------
Delimiter $$
	Create procedure sp_AgregarEspecialidad(in descripcion varchar(100))
    Begin
		Insert into Especialidades(descripcion)
			Values(descripcion);
	End $$
Delimiter ;

call sp_AgregarEspecialidad("Anatomía Patológica");
call sp_AgregarEspecialidad("Dermatología");
call sp_AgregarEspecialidad("Pediatría");

-- --------- Listar Especialidades ---------
Delimiter $$
	Create procedure sp_ListarEspecialidad()
    Begin
		Select
			E.codigoEspecialidad,
            E.descripcion
		From Especialidades E;
	End$$
Delimiter ;

call sp_ListarEspecialidad();

-- --------- Buscar Especialidades ---------
Delimiter $$
	Create procedure sp_BuscarEspecialidad(in codEspecialidad int)
    Begin
		Select
			E.codigoEspecialidad,
            E.descripcion
		From Especialidades E
			where codigoEspecialidad = codEspecialidad;
	End$$
Delimiter ;

call sp_BuscarEspecialidad(1);

-- --------- Eliminar Especialidades ---------
Delimiter $$
	Create procedure sp_EliminarEspecialidad(in codEspecialidad int)
    Begin
		Delete From Especialidades
			where codigoEspecialidad = codEspecialidad;
	End$$
Delimiter ;

call sp_EliminarEspecialidad(3);
call sp_ListarEspecialidad();

-- --------- Editar Especialidades ---------
Delimiter $$
	Create procedure sp_EditarEspecialidad(in codEspecialidad int, in descrip varchar(100))
    Begin
		Update Especialidades E
			set
				E.descripcion = descrip
				where codigoEspecialidad = codEspecialidad;
	End$$
Delimiter ;

call sp_EditarEspecialidad(2, "Cirugía General");
call sp_ListarEspecialidad();

-- --------------------------------------- MEDICAMENTOS ----------------------------------------
-- --------- Agregar Medicamentos ---------
Delimiter $$
	Create procedure sp_AgregarMedicamento(in nombreMedicamento varchar(100))
    Begin
		Insert into Medicamentos(nombreMedicamento)
			Values(nombreMedicamento);
	End$$
Delimiter ;

call sp_AgregarMedicamentos("Paracetamol");
call sp_AgregarMedicamentos("Aspirina");
call sp_AgregarMedicamentos("Amlodipina");

-- --------- Listar Medicamentos ---------
Delimiter $$
	Create procedure sp_ListarMedicamento()
    Begin
		Select
			M.nombreMedicamento
		From Medicamentos;
	End$$
Delimiter ;

call sp_ListarMedicamento();

-- --------- Buscar Medicamentos ---------
Delimiter $$
	Create procedure sp_BuscarMedicamento(in codMedicamento int)
    Begin
		Select
			M.nombreMedicamento
		From Medicamentos
			where codigoMedicamento = codMedicamento;
	End$$
Delimiter ;

call sp_BuscarMedicamento(1);

-- --------- Eliminar Medicamentos ---------
Delimiter $$
	Create procedure sp_EliminarMedicamento(in codMedicamento int)
	Begin
		Delete from Medicamentos M
			where codigoMedicamento = codMedicamento;
	End$$
Delimiter ;

call sp_EliminarMedicamento(3);
call sp_ListarMedicamento();

-- --------- Editar Medicamentos ---------
Delimiter $$
	Create procedure sp_EditarMedicamento(in codMedicamento int, in nombMedicamento varchar(100))
    Begin
		Update Medicamentos M
			set
				nombreMedicamento = nombMedicamento
			where codigoMedicamento = codMedicamento;
    End$$
Delimiter ;

call sp_EditarMedicamento(2, "Omeprazol");
call sp_ListarMedicamento();

-- --------------------------------------- DOCTORES ----------------------------------------
-- --------- Agregar Doctores ---------
Delimiter $$
	Create procedure sp_AgregarDoctor(in numeroColegiado int, in nombresDoctor varchar(50), in apellidosDoctor varchar(50),
										in telefonoContacto varchar(8), in codigoEspecialidad int)
	Begin
		Insert into Doctores(numeroColegiado, nombresDoctor, apellidosDoctor, telefonoContacto, codigoEspecialidad)
			Values(numeroColegiado, nombresDoctor, apellidosDoctor, telefonoContacto, codigoEspecialidad);
    End$$
Delimiter ; 

call sp_AgregarDoctor(1, 'Pablo José', 'Castillo Perez', '48193569', 1);
call sp_AgregarDoctor(2, 'Leonel Alejandro', 'Morales Arreaza', '87420402', 2);
call sp_AgregarDoctor(3, 'Juan Carlos', 'Gutierrez Mendoza', '80901578', 3);

-- --------- Listar Doctores ---------
Delimiter $$
	Create procedure sp_ListarDoctor()
	Begin
		Select
			D.numeroColegiado,
            D.nombresDoctor,
            D.apellidosDoctor,
            D.telefonoContacto,
            D.codigoEspecialidad
		From Doctores D;
    End$$
Delimiter ;

call sp_ListarDoctor();

-- --------- Buscar Doctores ---------
Delimiter $$
	Create procedure sp_BuscarDoctor(in numColegiado int)
    Begin
		Select
			D.numeroColegiado,
            D.nombresDoctor,
            D.apellidosDoctor,
            D.telefonoContacto,
            D.codigoEspecialidad
		From Doctores D 
			where numeroColegiado = numColegiado;
    End$$
Delimiter ;

call sp_BuscarDoctor(1);

-- --------- Eliminar Doctores ---------
Delimiter $$
	Create procedure sp_EliminarDoctor(in numColegiado int)
    Begin
		Delete from Doctor D
			where numeroColegiado = numColegiado;
    End$$
Delimiter ;

call sp_EliminarDoctor(3);
call sp_ListarDoctor();

-- --------- Editar Doctores ---------
Delimiter $$
	Create procedure sp_EditarDoctor(in numColegiado int, in nomDoctor varchar(50), in apellDoctor varchar(50),
										in telContacto varchar(8))
	Begin
		Update Doctores D
			set
				D.numeroColegiado = numeroColegiado,
                D.nombresDoctor = nomDoctor,
                D.apellidosDoctor = apellDoctor,
                D.telefonoContacto = telContacto
				where numeroColegiado = numColegiado;
    End$$
Delimiter ;

call sp_EditarDoctor(2, 'Daniel Jesús', 'Estrada Salazar', '48769320');
call sp_ListarDoctor();

-- --------------------------------------- RECETAS ----------------------------------------
-- --------- Agregar Recetas ---------