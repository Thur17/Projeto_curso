INSERT INTO perfil (id, nome) VALUES
(1, 'Patrão'),
(2, 'Administrador'),
(3, 'Operador');

INSERT INTO usuario (
nome,
email,
email_verified_at,
senha,
id_perfil,
created_at
) VALUES (
'Usuário Sistema',
'attini@system.com.br',
NOW(),
'$2y$10$2hQ6yV1N1fKJv6wZp0vKle8nG5kLZtZy9bZ1xU4N0r9Yp6nFv8y.e',
1,
NOW()
);