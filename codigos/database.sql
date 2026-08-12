CREATE DATABASE IF NOT EXISTS colegio_db;
USE colegio_db;

-- 1. ROLES Y USUARIOS
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO roles (nombre) VALUES ('admin'), ('profesor'), ('alumno');

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    rut VARCHAR(12) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    id_rol INT NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

-- 2. CURSOS
CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_profesor_jefe INT,
    FOREIGN KEY (id_profesor_jefe) REFERENCES usuarios(id_usuario)
);

CREATE TABLE curso_alumno (
    id_curso INT NOT NULL,
    id_alumno INT NOT NULL,
    PRIMARY KEY (id_curso, id_alumno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    FOREIGN KEY (id_alumno) REFERENCES usuarios(id_usuario)
);

-- 3. SALAS CON GPS
CREATE TABLE salas (
    id_sala INT AUTO_INCREMENT PRIMARY KEY,
    nombre_o_numero VARCHAR(50) NOT NULL,
    piso VARCHAR(20),
    pabellon VARCHAR(50),
    latitud DECIMAL(10, 8),
    longitud DECIMAL(11, 8)
);

-- 4. MATERIAS Y HORARIOS
CREATE TABLE materias (
    id_materia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE horarios (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    id_materia INT NOT NULL,
    id_profesor INT NOT NULL,
    id_sala INT NOT NULL,
    dia_semana TINYINT NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia),
    FOREIGN KEY (id_profesor) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_sala) REFERENCES salas(id_sala)
);

-- 5. ANUNCIOS
CREATE TABLE anuncios (
    id_anuncio INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    id_autor INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    FOREIGN KEY (id_autor) REFERENCES usuarios(id_usuario)
);

-- DATOS DE PRUEBA (Para probar el Login)
INSERT INTO usuarios (rut, password, nombre, apellido, id_rol) 
VALUES ('1-9', 'admin123', 'Daniel', 'Administrador', 1);

INSERT INTO usuarios (rut, password, nombre, apellido, id_rol) 
VALUES ('2-7', 'profe123', 'Juan', 'Carlos', 2);

INSERT INTO usuarios (rut, password, nombre, apellido, id_rol) 
VALUES ('3-5', 'alumno123', 'Jorge', 'Badani', 3);
