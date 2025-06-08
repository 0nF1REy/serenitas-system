<%@ page import="io.github.cdimascio.dotenv.Dotenv" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de produtos</title>
    </head>
    <body>
        <%
            // Receber os dados do formulário
            String n = request.getParameter("nome");
            String m = request.getParameter("marca");
            BigDecimal p = new BigDecimal(request.getParameter("preco"));

            try {
                // Inicializar dotenv
                Dotenv dotenv = Dotenv.configure()
                        .directory(application.getRealPath("/"))
                        .load();

                String url = dotenv.get("DB_URL");
                String user = dotenv.get("DB_USER");
                String password = dotenv.get("DB_PASSWORD");

                // Fazer a conexão com o Banco de Dados
                Connection conexao;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexao = DriverManager.getConnection(url, user, password);

                // Inserir os dados na tabela tb_produto do banco de dados aberto (PREPARAÇÃO DO COMANDO INSERT)
                st = conexao.prepareStatement("INSERT INTO tb_produto (nome, marca, preco) VALUES (?, ?, ?)");
                st.setString(1, n);
                st.setString(2, m);
                st.setBigDecimal(3, p);
                st.executeUpdate(); // Envia os dados para o banco de dados (EXECUTA O COMANDO INSERT)
                out.print("Produto cadastrado com sucesso");

            } catch (Exception ex) {
                out.print("Mensagem de erro: " + ex.getMessage());
            }
        %>
    </body>
</html>
