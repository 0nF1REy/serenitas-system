<%@ page import="io.github.cdimascio.dotenv.Dotenv" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Consulta de produtos</title>
        <link rel="stylesheet" href="./styles/product-search.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    </head>
    <body>
        <%
            String n = request.getParameter("nome");
            Connection conexao = null;
            PreparedStatement st = null;
            ResultSet rs = null;

            try {
                Dotenv dotenv = Dotenv.configure()
                        .directory(application.getRealPath("/"))
                        .load();

                String url = dotenv.get("DB_URL");
                String user = dotenv.get("DB_USER");
                String password = dotenv.get("DB_PASSWORD");

                Class.forName("com.mysql.cj.jdbc.Driver");
                conexao = DriverManager.getConnection(url, user, password);

                st = conexao.prepareStatement(
                        "SELECT * FROM tb_produto WHERE deleted_at IS NULL AND nome LIKE ? ORDER BY preco"
                );
                st.setString(1, "%" + n + "%");
                rs = st.executeQuery();

                boolean hasProducts = false;

                java.util.List<java.util.Map<String, Object>> produtos = new java.util.ArrayList<>();

                while (rs.next()) {
                    hasProducts = true;
                    java.util.Map<String, Object> produto = new java.util.HashMap<>();
                    produto.put("nome", rs.getString("nome"));
                    produto.put("marca", rs.getString("marca"));
                    produto.put("preco", rs.getBigDecimal("preco"));
                    produtos.add(produto);
                }

                if (hasProducts) {
        %>
        <h2 class="resultado-titulo">Resultado da consulta pelo produto: "<%= n%>"</h2>

        <table class="produtos-tabela">
            <tr class="produtos-tr">
                <th class="produtos-th">Nome</th>
                <th class="produtos-th">Marca</th>
                <th class="produtos-th">Preço</th>
            </tr>
            <%
                for (java.util.Map<String, Object> produto : produtos) {
            %>
            <tr class="produtos-tr">
                <td class="produtos-td"><%= produto.get("nome")%></td>
                <td class="produtos-td"><%= produto.get("marca") != null ? produto.get("marca") : "N/A"%></td>
                <td class="produtos-td">R$ <%= produto.get("preco")%></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
        } else {
        %>
        <h2 class="resultado-titulo">Nenhum produto encontrado com o nome "<%= n%>"</h2>
        <%
            }
        } catch (Exception ex) {
        %>
        <p class="erro-msg">Erro ao buscar produto: <%= ex.getMessage()%></p>
        <%
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (st != null) {
                        st.close();
                    }
                    if (conexao != null) {
                        conexao.close();
                    }
                } catch (Exception e) {
                }
            }
        %>
        <div class="btn-container">
            <a href="conpro.html" class="btn-consultar">
                Realizar nova consulta <i class="fa fa-search"></i>
            </a>
        </div>
    </body>
</html>
