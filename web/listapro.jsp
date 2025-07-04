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
        <title>Listagem de produtos</title>
        <link rel="stylesheet" href="./styles/listing.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    </head>
    <body>
        <%
            Connection conexao = null;
            PreparedStatement st = null;
            ResultSet rs = null;
            boolean hasProducts = false;

            try {
                // Inicializar dotenv
                Dotenv dotenv = Dotenv.configure()
                        .directory(application.getRealPath("/"))
                        .load();

                String url = dotenv.get("DB_URL");
                String user = dotenv.get("DB_USER");
                String password = dotenv.get("DB_PASSWORD");

                // Conectar ao banco
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexao = DriverManager.getConnection(url, user, password);

                // Consulta SQL
                st = conexao.prepareStatement("SELECT * FROM tb_produto WHERE deleted_at IS NULL ORDER BY preco");
                rs = st.executeQuery();
        %>

        <%  if (rs.next()) {
                hasProducts = true;
        %>
        <table class="produtos-tabela">
            <tr class="produtos-tr">
                <th class="produtos-th">Nome</th>
                <th class="produtos-th">Marca</th>
                <th class="produtos-th">Preço</th>
                <th class="produtos-th">Ações</th>
            </tr>

            <%
                do {
                    int id = rs.getInt("id_produto");
            %>
            <tr class="produtos-tr">
                <td class="produtos-td"><%= rs.getString("nome")%></td>
                <td class="produtos-td"><%= rs.getString("marca")%></td>
                <td class="produtos-td">R$ <%= rs.getBigDecimal("preco")%></td>
                <td class="produtos-td">
                    <a href="altpro.jsp?id=<%= id%>" title="Editar produto">
                        <i class="fa-solid fa-pen"></i>
                    </a>
                    <a href="excpro.jsp?id=<%= id%>" title="Excluir produto">
                        <i class="fa-solid fa-trash"></i>
                    </a>

                </td>
            </tr>
            <%
                } while (rs.next());
            %>
        </table>

        <%
        } else {
        %>
        <p class="produtos-sem-registro">Nenhum produto encontrado.</p>
        <%
                }

            } catch (Exception ex) {
                out.print("Erro ao listar produtos: " + ex.getMessage());
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                } catch (Exception e) {
                }
                try {
                    if (st != null) {
                        st.close();
                    }
                } catch (Exception e) {
                }
                try {
                    if (conexao != null) {
                        conexao.close();
                    }
                } catch (Exception e) {
                }
            }
        %>
    </body>
</html>