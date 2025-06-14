<%@ page import="io.github.cdimascio.dotenv.Dotenv" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Excluir produto</title>
        <link rel="stylesheet" href="./styles/delete.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    </head>
    <body>
        <div class="container">
            <%
                String mensagem = "";
                String classeMensagem = "";
                String id = request.getParameter("id");
                String nomeProduto = "";

                try {
                    Dotenv dotenv = Dotenv.configure()
                            .directory(application.getRealPath("/"))
                            .load();

                    String url = dotenv.get("DB_URL");
                    String user = dotenv.get("DB_USER");
                    String password = dotenv.get("DB_PASSWORD");

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(url, user, password);

                    PreparedStatement psBusca = conn.prepareStatement("SELECT nome FROM tb_produto WHERE id_produto = ?");
                    psBusca.setInt(1, Integer.parseInt(id));
                    java.sql.ResultSet rs = psBusca.executeQuery();

                    if (rs.next()) {
                        nomeProduto = rs.getString("nome");

                        PreparedStatement psDelete = conn.prepareStatement("UPDATE tb_produto SET deleted_at = NOW() WHERE id_produto = ?");

                        psDelete.setInt(1, Integer.parseInt(id));
                        int resultado = psDelete.executeUpdate();

                        if (resultado > 0) {
                            mensagem = "✅ Produto '" + nomeProduto + "' excluído com sucesso!";
                            classeMensagem = "success";
                        } else {
                            mensagem = "Produto não encontrado.";
                            classeMensagem = "error";
                        }

                    } else {
                        mensagem = "Produto com ID " + id + " não encontrado.";
                        classeMensagem = "error";
                    }

                    conn.close();
                } catch (Exception erro) {
                    mensagem = "Erro ao excluir: entre em contato com o suporte e informe o erro: " + erro.getMessage();
                    classeMensagem = "error";
                }
            %>
            <p class="<%= classeMensagem%>"><%= mensagem%></p>

            <a href="listapro.jsp" class="back-link">
                <i class="fa-solid fa-arrow-left"></i> Voltar para listagem
            </a>
        </div>
    </body>
</html>
