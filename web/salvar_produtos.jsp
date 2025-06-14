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
        <link rel="stylesheet" href="./styles/save.css" />
    </head>
    <body>
        <div class="box">
            <%
                String mensagem = "";
                boolean sucesso = false;
                try {
                    String n = request.getParameter("nome");
                    String m = request.getParameter("marca");
                    BigDecimal p = new BigDecimal(request.getParameter("preco"));

                    Dotenv dotenv = Dotenv.configure()
                            .directory(application.getRealPath("/"))
                            .load();

                    String url = dotenv.get("DB_URL");
                    String user = dotenv.get("DB_USER");
                    String password = dotenv.get("DB_PASSWORD");

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conexao = DriverManager.getConnection(url, user, password);

                    PreparedStatement st = conexao.prepareStatement("INSERT INTO tb_produto (nome, marca, preco) VALUES (?, ?, ?)");
                    st.setString(1, n);
                    st.setString(2, m);
                    st.setBigDecimal(3, p);
                    st.executeUpdate();

                    mensagem = "✅ Produto '" + n + "' cadastrado com sucesso!";
                    sucesso = true;

                    conexao.close();
                } catch (Exception ex) {
                    mensagem = "❌ Erro ao cadastrar o produto '" + request.getParameter("nome") + "': " + ex.getMessage();
                }
            %>
            <p class="<%= sucesso ? "" : "error"%>"><%= mensagem%></p>
            <a href="cadpro.html" target="centro" class="btn">Cadastrar novo produto</a>
        </div>
    </body>
</html>
