<%@ page import="io.github.cdimascio.dotenv.Dotenv" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listagem de produtos</title>
    <link rel="stylesheet" href="./style.css" />
</head>
<body>
    <%
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

            // Listar os dados da tabela tb_produto do banco de dados
            st = conexao.prepareStatement("SELECT * FROM tb_produto");
            ResultSet rs = st.executeQuery();
    %>

    <table class="produtos-tabela">
        <tr class="produtos-tr">
            <th class="produtos-th">Nome</th>
            <th class="produtos-th">Marca</th>
            <th class="produtos-th">Preço</th>
        </tr>

        <%
            while (rs.next()) {
        %>
        <tr class="produtos-tr">
            <td class="produtos-td"><%= rs.getString("nome") %></td>
            <td class="produtos-td"><%= rs.getString("marca") %></td>
            <td class="produtos-td"><%= rs.getString("preco") %></td>
        </tr>
        <%
            }
        %>
    </table>

    <%
        } catch (Exception ex) {
            out.print("Mensagem de erro: " + ex.getMessage());
        }
    %>
</body>
</html>
